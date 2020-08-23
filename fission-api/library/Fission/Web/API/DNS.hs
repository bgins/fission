module Fission.Web.API.DNS (API) where

import           Network.IPFS.CID.Types
import           Servant.API

import           Fission.Web.URL.Types

type API
  =  Summary "Set account's DNSLink"
  :> Description "DEPRECATED ⛔ Set account's DNSLink to a CID"
  :> Capture "cid" CID
  :> PutAccepted '[PlainText, OctetStream] DomainName
