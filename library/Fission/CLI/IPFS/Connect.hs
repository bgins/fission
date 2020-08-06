-- | Module for connecting to the Fission IPFS service
module Fission.CLI.IPFS.Connect
  ( swarmConnectWithRetry
  , couldNotSwarmConnect
  ) where

import           Fission.Prelude

import qualified System.Console.ANSI as ANSI
import qualified RIO.NonEmpty        as NonEmpty
import           Control.Parallel.Strategies (parMap, rpar)

import           Fission.Web.Client
import           Fission.Web.Client.Peers as Peers

import qualified Fission.Internal.UTF8 as UTF8

import           Fission.CLI.IPFS.Error.Types

import           Network.IPFS
import qualified Network.IPFS.Types       as IPFS
import qualified Network.IPFS.Peer        as IPFS.Peer


-- | Connect to the Fission IPFS network with a set amount of retries
swarmConnectWithRetry ::
  ( MonadUnliftIO  m
  , MonadLogger    m
  , MonadLocalIPFS m
  , MonadWebClient m
  )
  => NonEmpty IPFS.Peer
  -> Int
  -> m (Either SomeException ())
swarmConnectWithRetry _peers (-1) =
  return . Left $ toException UnableToConnect

swarmConnectWithRetry peers tries = do
  attempts <- sequence $ parMap rpar IPFS.Peer.connect (NonEmpty.toList peers)
  if any isRight attempts
    then do
      logDebug $ "Successfully connected to a node. Full results: " <> textShow attempts
      return ok

    else 
      Peers.getPeers >>= \case
        Left _ ->
          return . Left $ toException UnableToConnect

        Right retryPeers -> do
          UTF8.putText "🛰 Unable to connect to the Fission IPFS peer, trying again...\n"
          swarmConnectWithRetry retryPeers (tries - 1)

-- | Create a could not connect to Fission peer message for the terminal
couldNotSwarmConnect :: MonadIO m => m ()
couldNotSwarmConnect = do
  liftIO $ ANSI.setSGR [ANSI.SetColor ANSI.Foreground ANSI.Vivid ANSI.Red]
  UTF8.putText "😭 We were unable to connect to the Fission IPFS peer!\n"

  liftIO $ ANSI.setSGR [ANSI.SetColor ANSI.Foreground ANSI.Vivid ANSI.Blue]
  UTF8.putText "Try checking your connection or logging in again\n"

  liftIO $ ANSI.setSGR [ANSI.Reset]