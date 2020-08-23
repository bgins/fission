module Fission.Web.API.App.Create (API) where

import           Servant.API

import           Fission.Web.URL.Types

type API
  =  Summary "Create app"
  :> Description "Creates a new app, assigns an initial subdomain, and sets an asset placeholder"
  :> QueryParam "subdomain" Subdomain
  :> PostAccepted '[JSON] URL
