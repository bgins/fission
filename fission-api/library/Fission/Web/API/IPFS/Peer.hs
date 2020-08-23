module Fission.Web.API.IPFS.Peer (API) where

import           Data.List.NonEmpty as NonEmpty

import qualified Network.IPFS.Types as IPFS
import           Servant.API

type API
  =  Summary "Peer index"
  :> Description "List of recommended IPFS peers"
  :> Get '[JSON, PlainText, OctetStream] (NonEmpty IPFS.Peer)
