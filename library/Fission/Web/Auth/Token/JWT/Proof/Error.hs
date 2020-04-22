module Fission.Web.Auth.Token.JWT.Proof.Error (Error (..)) where

import           Servant.Server

import           Fission.Prelude
import           Fission.Web.Error.Class

import qualified Fission.Web.Auth.Token.JWT.Resolver as JWT.Resolver

data Error
  = InvalidSignatureChain
  | ScopeOutOfBounds
  | PotencyEscelation
  | ResolverError JWT.Resolver.Error
  deriving (Show, Eq, Exception)

instance Display Error where
  display = \case
    InvalidSignatureChain -> "Invalid signature chain"
    ScopeOutOfBounds      -> "Path scope not in delegated rights"
    PotencyEscelation     -> "Potency escelation"
    ResolverError resErr  -> "Unable to resolve CID proof: " <> display resErr

instance ToServerError Error where
  toServerError = \case
    ResolverError err     -> toServerError err
    ScopeOutOfBounds      -> err401 { errBody = displayLazyBS ScopeOutOfBounds      }
    PotencyEscelation     -> err401 { errBody = displayLazyBS PotencyEscelation     }
    InvalidSignatureChain -> err422 { errBody = displayLazyBS InvalidSignatureChain }
