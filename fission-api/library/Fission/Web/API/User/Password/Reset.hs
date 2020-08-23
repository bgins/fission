module Fission.Web.API.User.Password.Reset (API) where

import           Servant.API

import qualified Fission.User                          as User
import qualified Fission.User.Password                 as User.Password
import qualified Fission.Web.User.Password.Reset.Types as User.Password

type API
  =  Summary "Reset password"
  :> Description "DEPRECATED ⛔ Reset password"
  :> ReqBody '[JSON] User.Password.Reset
  :> Put     '[JSON] User.Password
