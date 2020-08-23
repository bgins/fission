-- | Top-level router type for the application
module Fission.Web.API
  ( API
  , UserPrefix
  , UserRoute
  , HerokuRoute
  , IPFSPrefix
  , IPFSRoute
  , PingRoute
  , DNSRoute
  , AppRoute
  , AppPrefix
  ) where

import           Servant.API

import qualified Fission.Web.API.App        as App
import qualified Fission.Web.API.Auth.Types as Auth
import qualified Fission.Web.API.DNS        as DNS
import qualified Fission.Web.API.Heroku     as Heroku
import qualified Fission.Web.API.IPFS       as IPFS
import qualified Fission.Web.API.Ping       as Ping
import qualified Fission.Web.API.User       as User

type API
  =    IPFSRoute
  :<|> AppRoute
  :<|> HerokuRoute
  :<|> UserRoute
  :<|> PingRoute
  :<|> DNSRoute

type AppRoute
  =  AppPrefix
  :> Auth.HigherOrder
  :> App.API

type AppPrefix
  = "app"

type PingRoute
  =  "ping"
  :> Ping.API

type UserRoute
  =  UserPrefix
  :> User.API

type UserPrefix
  = "user"

type IPFSRoute
  =  IPFSPrefix
  :> IPFS.API

type IPFSPrefix
  = "ipfs"

type HerokuRoute
  =  "heroku"
  :> "resources"
  :> Auth.HerokuAddOnAPI
  :> Heroku.API

type DNSRoute
  =  "dns"
  :> Auth.HigherOrder
  :> DNS.API
