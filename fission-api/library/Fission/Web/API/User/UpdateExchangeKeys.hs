module Fission.Web.API.User.UpdateExchangeKeys
  ( API
  , AddAPI
  , RemoveAPI
  ) where

import qualified Crypto.PubKey.RSA as RSA
import           Servant.API

type API = AddAPI :<|> RemoveAPI

type AddAPI
  =  Summary "Add Public Exchange Key"
  :> Description "Add a key to the currently authenticated user's root list of public exchange keys"
  :> Capture "did" RSA.PublicKey
  :> Put     '[JSON] [RSA.PublicKey]

type RemoveAPI
  =  Summary "Remove Public Exchange Key"
  :> Description "Remove a key from the currently authenticated user's root list of public exchange keys"
  :> Capture "did" RSA.PublicKey
  :> Delete  '[JSON] [RSA.PublicKey]
