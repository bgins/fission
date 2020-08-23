module Fission.Web.Auth.Types
  ( RegisterDID
  , HigherOrder
  ) where

import           Servant.API

type RegisterDID = AuthProtect "register-did"
type HigherOrder = AuthProtect "higher-order"
