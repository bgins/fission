module Fission.Web.API.IPFS.CID (API) where

import           Network.IPFS.CID.Types
import           Servant.API

type API
  =  Summary "CID Index"
  :> Description "List of all of your pinned CIDs (not associated with your personal file system or apps)"
  :> Get '[JSON, PlainText] [CID]
