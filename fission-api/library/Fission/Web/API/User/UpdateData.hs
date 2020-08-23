module Fission.Web.API.User.UpdateData (API) where

import           Network.IPFS.CID.Types
import           Servant.API

type API
  =  Summary "Update data root"
  :> Description "Set/update currently authenticated user's file system content"
  :> Capture "newCID" CID
  :> PatchNoContent '[PlainText, OctetStream, JSON] NoContent
