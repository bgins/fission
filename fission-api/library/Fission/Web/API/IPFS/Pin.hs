module Fission.Web.API.IPFS.Pin
  ( API
  , PinAPI
  , UnpinAPI
  ) where

import           Network.IPFS.CID.Types
import           Servant.API

type API = PinAPI :<|> UnpinAPI

type PinAPI
  =  Summary "Pin CID"
  :> Description "DEPRECATED ⛔ Pin an otherwise unassociated CID"
  :> Capture "cid" CID
  :> Put '[PlainText, OctetStream] NoContent

type UnpinAPI
  =  Summary "Unpin CID"
  :> Description "DEPRECATED ⛔ Unpin an otherwise unassociated CID"
  :> Capture "cid" CID
  :> DeleteAccepted '[PlainText, OctetStream] NoContent
