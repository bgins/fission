module Fission.Web.API.IPFS.DAG (API) where

import qualified Network.IPFS.File.Types as File
import qualified Network.IPFS.Types      as IPFS

import           Servant.API

type API
  =  Summary "Pin an IPFS DAG structure"
  :> Description "Pin some data not associated to a user app or file system. We call these loose pins, likely to be deprecated."
  :> ReqBody '[PlainText, OctetStream] File.Serialized
  :> Post    '[PlainText, OctetStream] IPFS.CID
