module Fission.Web.User.DataRoot.Get
  ( API
  , server
  ) where

import           Fission.Prelude
import           Servant

import qualified Fission.Web.Error           as Web.Err

import           Fission.User.Username.Types
import           Fission.WNFS as WNFS
import           Network.IPFS.CID.Types


type API
  =  Summary "Get Data Root"
  :> Description "Retrieve a user's data root from DNS"
  :> Capture "username" Username
  :> Get '[JSON, PlainText] CID

server ::
  ( MonadLogger m
  , MonadThrow  m
  , MonadWNFS   m
  )
  => ServerT API m
server username = Web.Err.ensureM $ WNFS.getUserDataRoot username
