module Fission.Web.API.Ping.Types (Pong (..)) where

import           Control.Lens        ((?~))

import           Data.Aeson
import           Data.Swagger        hiding (name)

import           Flow
import           RIO
import qualified RIO.ByteString.Lazy as Lazy

import           Servant.API

-- | A dead-simple text wrapper.
--   Primarily exists for customized instances.
newtype Pong = Pong { unPong :: Text }
  deriving         ( Eq
                   , Show
                   )
  deriving newtype ( IsString
                   , FromJSON
                   , ToJSON
                   )

instance ToSchema Pong where
  declareNamedSchema _ =
    mempty
      |> type_       ?~ SwaggerString
      |> description ?~ "A simple response"
      |> example     ?~ toJSON (Pong "pong")
      |> NamedSchema (Just "Pong")
      |> pure

instance MimeRender PlainText Pong where
  mimeRender _proxy = Lazy.fromStrict . encodeUtf8 . unPong
