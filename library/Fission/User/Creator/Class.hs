module Fission.User.Creator.Class
  ( Creator (..)
  , Errors
  ) where

import           Data.UUID (UUID)
import           Database.Esqueleto hiding ((<&>))
import           Servant

import           Fission.Prelude
import           Fission.Error as Error
import           Fission.Models

import qualified Fission.Platform.Heroku.Region.Types  as Heroku
import qualified Fission.Platform.Heroku.AddOn.Creator as Heroku.AddOn

import qualified Fission.User.Creator.Error as User
import           Fission.User.Modifier      as User
import qualified Fission.User.Password      as Password
import           Fission.User.Types

import qualified Fission.App.Domain as AppDomain
import qualified Fission.App.Creator as App

import           Fission.IPFS.DNSLink
import           Fission.URL.Subdomain.Types

import qualified Fission.App.Content as App.Content
import qualified Fission.App.Domain  as App.Domain

type Errors = OpenUnion
  '[ ActionNotAuthorized App
   , NotFound            App

   , AlreadyExists HerokuAddOn
   , AppDomain.AlreadyAssociated
   , User.AlreadyExists

   , Password.FailedDigest

   , ServerError
   ]

class Heroku.AddOn.Creator m => Creator m where
  -- | Create a new, timestamped entry
  create ::
       Username
    -> DID
    -> Email
    -> UTCTime
    -> m (Either Errors (UserId, Subdomain))

  -- | Create a new, timestamped entry and heroku add-on
  createWithHeroku ::
       UUID
    -> Heroku.Region
    -> Username
    -> Text
    -> UTCTime
    -> m (Either Errors UserId)

instance
  ( MonadIO                 m
  , MonadDNSLink            m
  , App.Domain.Initializer  m
  , App.Content.Initializer m
  )
  => Creator (Transaction m) where
  create username did email now =
    User
      { userDid           = Just did
      , userUsername      = username
      , userEmail         = Just email
      , userRole          = Regular
      , userActive        = True
      , userHerokuAddOnId = Nothing
      , userSecretDigest  = Nothing
      , userDataRoot      = App.Content.empty
      , userInsertedAt    = now
      , userModifiedAt    = now
      }
      |> insertUnique
      |> bind \case
        Nothing ->
          return (Error.openLeft User.AlreadyExists)

        Just userId ->
          now
            |> User.setData userId did App.Content.empty
            |> bind \case
              Left err ->
                return (Error.openLeft err)

              Right () ->
                now
                  |> App.createWithPlaceholder userId
                  |> fmap \case
                    Left err             -> Error.relaxedLeft err
                    Right (_, subdomain) -> Right (userId, subdomain)

  createWithHeroku herokuUUID herokuRegion username password now =
    Heroku.AddOn.create herokuUUID herokuRegion now >>= \case
      Left err ->
        return . Left <| openUnionLift err

      Right herokuAddOnId ->
        Password.hashPassword password >>= \case
          Left err ->
            return . Left <| openUnionLift err

          Right secretDigest ->
            User
              { userDid           = Nothing
              , userUsername      = username
              , userEmail         = Nothing
              , userRole          = Regular
              , userActive        = True
              , userHerokuAddOnId = Just herokuAddOnId
              , userSecretDigest  = Just secretDigest
              , userDataRoot      = App.Content.empty
              , userInsertedAt    = now
              , userModifiedAt    = now
              }
            |> insertUnique
            |> bind \case
              Just userID ->
                return (Right userID)

              Nothing ->
                return . Left <| openUnionLift User.AlreadyExists