module Fission.Web.API.App.Update (API) where

import           Network.IPFS.CID.Types
import           Servant.API

import           Fission.Web.URL.Types

type API
  =  Summary     "Set app content"
  :> Description "Update the content (CID) for an app"
  :> Capture     "App URL" URL
  :> Capture     "New CID" CID
  :> QueryParam  "copy-data" Bool
  :> PatchAccepted '[JSON] NoContent
