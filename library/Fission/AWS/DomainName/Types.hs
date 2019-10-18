module Fission.AWS.DomainName.Types (DomainName (..)) where

import           RIO
import qualified RIO.ByteString.Lazy as Lazy

import Data.Aeson
import Data.Swagger (ToSchema (..))
import Servant

import qualified Fission.Internal.UTF8 as UTF8

-- | Type safety wrapper for Route53 domain names
newtype DomainName = DomainName { getDomainName :: Text }
  deriving          ( Eq
                    , Generic
                    , Show
                    )
  deriving anyclass ( ToSchema )
  deriving newtype  ( IsString )

instance FromJSON DomainName where
  parseJSON = withText "AWS.DomainName" \txt ->
    DomainName <$> parseJSON (String txt)

instance MimeRender PlainText DomainName where
  mimeRender _ = UTF8.textToLazyBS . getDomainName

instance MimeRender OctetStream DomainName where
  mimeRender _ = UTF8.textToLazyBS . getDomainName

instance MimeUnrender PlainText DomainName where
  mimeUnrender _proxy bs =
    case decodeUtf8' $ Lazy.toStrict bs of
      Left err  -> Left $ show err
      Right txt -> Right $ DomainName txt