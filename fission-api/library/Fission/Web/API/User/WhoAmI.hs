module Fission.Web.API.User.WhoAmI (API) where

import           Servant.API

import           Fission.User.Username.Types

type API
  =  Summary "Get username"
  :> Description "Get username registered to currently authenticated user"
  :> Get '[PlainText, JSON] Username
