module Fission.Web.API.User.VerifyEmail (API) where

import           Servant.API

import           Fission.Challenge.Types

type API
  =  Summary "Email verification"
  :> Description ""
  :> Capture "Challenge" Challenge
  :> Get '[JSON] ()
