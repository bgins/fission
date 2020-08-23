module Fission.Web.API.IPFS.Upload (API) where

import           Network.IPFS.File.Types as File
import qualified Network.IPFS.Types      as IPFS

import           Servant.API

type API
  =  Summary "Upload file"
  :> Description "Directly upload a file over HTTP"
  :> ReqBody '[PlainText, OctetStream] File.Serialized
  :> Post    '[PlainText, OctetStream] IPFS.CID
