{-# LANGUAGE OverloadedStrings #-}

import Network.HTTP.Conduit
import qualified Data.ByteString.Lazy as B
import Data.Aeson
import System.IO

data Session = Session{ user_id :: String
                        ,nick :: String
                        ,start_time :: String }

getSessions :: IO B.ByteString
getSessions = curlResults
  where
    curlResults = simpleHttp "https://hubbit.chalmers.it/sessions.json"

instance FromJSON Session where
  parseJSON (Object v) =
    Session <$> v .: "user_id"
            <*> v .: "nick"
            <*> v .: "start_time"

  parseJSON _ = mzero
