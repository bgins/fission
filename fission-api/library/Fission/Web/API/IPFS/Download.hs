module Fission.Web.API.IPFS.Download (API) where

import           Network.IPFS.File.Types as File
import qualified Network.IPFS.Types      as IPFS

import           Servant.API

type API =  PathAPI
       :<|> QueryAPI

type PathAPI
  =  Summary "Get a file (path)"
  :> Description "Download a file by its CID"
  :> Capture "cid" IPFS.CID
  :> Get '[OctetStream, PlainText] File.Serialized

type QueryAPI
  =  Summary "Get a file (query param)"
  :> Description "Download a file by its CID"
  :> QueryParam "cid" IPFS.CID
  :> Get '[OctetStream, PlainText] File.Serialized
