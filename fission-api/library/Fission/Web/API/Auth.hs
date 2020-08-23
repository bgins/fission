module Fission.Web.API.Auth
  ( Checks
  -- * Reexports
  , module Fission.Web.API.Auth.Types
  ) where

import           Network.Wai
import           Servant.API
-- import           Servant.Server.Experimental.Auth

import           Fission.User.DID.Types
import           Fission.Web.API.Auth.Types

type Checks
  = '[ AuthHandler    Request DID
     , AuthHandler    Request Authorization
     , BasicAuthCheck Heroku.Auth
     ]
