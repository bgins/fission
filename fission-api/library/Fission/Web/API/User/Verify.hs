module Fission.Web.API.User.Verify (API) where

import           RIO
import           Servant.API

type API
  =  Summary "Validate auth"
  :> Description "DEPRECATED ⛔ Verify user auth -- prefer /user/whoami"
  :> Get '[JSON] Bool
