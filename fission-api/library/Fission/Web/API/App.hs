module Fission.Web.API.App (API) where

import           Servant.API

import qualified Fission.Web.API.App.Create  as Create
import qualified Fission.Web.API.App.Destroy as Destroy
import qualified Fission.Web.API.App.Index   as Index
import qualified Fission.Web.API.App.Update  as Update

type API
  =    Index.API
  :<|> Create.API
  :<|> Update.API
  :<|> Destroy.API
