module Fission.Web.API.App.Index (API) where

import           RIO.Map               as Map
import           Servant.API

import           Fission.Web.URL.Types

type API
  =  Summary "App index"
  :> Description "A list of all of your apps and their associated domain names"
  :> Get '[JSON] (Map Natural [URL]) -- FIXME temp replaced
  -- :> Get '[JSON] (Map AppId [URL])
                   -- ^ FIXME DB dependency
