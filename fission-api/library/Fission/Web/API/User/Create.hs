module Fission.Web.API.User.Create
  ( API
  , PasswordAPI
  , withDID
  , withPassword
  ) where

import           Servant.API

import qualified Fission.User           as User
import           Fission.User.DID.Types

type API
  =  Summary "Create user with DID and UCAN proof"
  :> Description "Register a new user (must auth with user-controlled DID)"
  :> ReqBody    '[JSON] User.Registration
  :> PutCreated '[JSON] NoContent

type PasswordAPI
  =  Summary "Create user with password"
  :> Description "DEPRECATED ⛔ Register a new user (must auth with user-controlled DID)"
  :> ReqBody     '[JSON] User.Registration
  :> PostCreated '[JSON] ()
