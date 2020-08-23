module Fission.Web.API.User
  ( API
  , Auth
  , RegisterRoute
  , VerifyRoute
  , VerifyEmailRoute
  , UpdatePublicKeyRoute
  , ResetRoute
  , WhoAmIRoute
  ) where

import           Servant

import qualified Fission.Web.API.User.Create             as Create
import qualified Fission.Web.API.User.Password.Reset     as Reset
import qualified Fission.Web.API.User.UpdateData         as UpdateData
import qualified Fission.Web.API.User.UpdateExchangeKeys as UpdateExchangeKeys
import qualified Fission.Web.API.User.UpdatePublicKey    as UpdatePublicKey
import qualified Fission.Web.API.User.Verify             as Verify
import qualified Fission.Web.API.User.VerifyEmail        as VerifyEmail
import qualified Fission.Web.API.User.WhoAmI             as WhoAmI

import qualified Fission.Web.Auth.Types                  as Auth


type API
  =   RegisterRoute
 :<|> Create.PasswordAPI
 :<|> WhoAmIRoute
 :<|> VerifyRoute
 :<|> VerifyEmailRoute
 :<|> UpdatePublicKeyRoute
 :<|> UpdateExchangeKeysRoute
 :<|> UpdateDataRoute
 :<|> ResetRoute

type Auth
  = Auth.HigherOrder

type RegisterRoute
  = Auth.RegisterDID
    :> Create.API

type WhoAmIRoute
  = "whoami"
    :> Auth
    :> WhoAmI.API

type VerifyRoute
  = "verify"
    :> Auth
    :> Verify.API

type VerifyEmailRoute
  = "email"
    :> "verify"
    :> VerifyEmail.API

type UpdatePublicKeyRoute
  = "did"
    :> Auth
    :> UpdatePublicKey.API

type UpdateExchangeKeysRoute
  = "exchange"
    :> "keys"
    :> Auth
    :> UpdateExchangeKeys.API

type UpdateDataRoute
  = "data"
    :> Auth
    :> UpdateData.API

type ResetRoute
  = "reset_password"
    :> Auth
    :> Reset.API
