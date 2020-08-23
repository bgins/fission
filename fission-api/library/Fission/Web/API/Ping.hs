module Fission.Web.API.Ping
  ( API
  , module Fission.Web.API.Ping.Types
  ) where

import           Fission.Web.API.Ping.Types
import           Servant.API

type API
  = Summary "Simple Ping"
  :> Description "A quick way to check for liveness"
  :> Get '[JSON, PlainText] Pong
