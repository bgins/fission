module Fission.Web.API.User.UpdatePublicKey (API) where

import           Servant.API

import qualified Fission.Key as Key

type API
  =  Summary "Update Public Key"
  :> Description "Set currently authenticated user's root public key to another one"
  :> ReqBody '[JSON] Key.Public
  :> Patch   '[PlainText, OctetStream, JSON] NoContent
