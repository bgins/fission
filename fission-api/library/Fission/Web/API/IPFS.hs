module Fission.Web.API.IPFS
  ( API
  , Auth
  , AuthedAPI
  , PublicAPI
  , UnauthedAPI
  ) where

import           Servant.API

import qualified Fission.Web.Auth.Types        as Auth

import qualified Fission.Web.API.IPFS.CID      as CID
import qualified Fission.Web.API.IPFS.DAG      as DAG
import qualified Fission.Web.API.IPFS.Download as Download
import qualified Fission.Web.API.IPFS.Peer     as Peer
import qualified Fission.Web.API.IPFS.Pin      as Pin
import qualified Fission.Web.API.IPFS.Upload   as Upload

type API
  =    AuthedAPI
  :<|> PublicAPI

type Auth
  = Auth.HigherOrder

type AuthedAPI
  = Auth
    :> UnauthedAPI

type UnauthedAPI
  = "cids"
    :> CID.API
      :<|> Upload.API
      :<|> Pin.API
      :<|> "dag"
           :> DAG.API

type PublicAPI
  = "peers"
    :> Peer.API :<|> Download.API
