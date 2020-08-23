module Fission.Web.API.App.Destroy
  ( API
  , ByURLAPI
  , ByIdAPI
  ) where

import           Servant.API

import           Fission.Authorization
import           Fission.Web.URL.Types

-- FIXME push auth to the leaves for easier clients
type API = ByURLAPI :<|> ByIdAPI

type ByURLAPI
  =  Summary "Destroy app by URL"
  :> Description "Destroy app by any associated URL"
  :> "associated"
  :> Capture "url" URL
  :> DeleteNoContent '[JSON] NoContent

type ByIdAPI
  =  Summary "Destroy app by ID"
  :> Description "Destroy app by its ID"
  :> Capture "appId" AppId
  :> DeleteNoContent '[JSON] NoContent
