{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

import GHC.Generics
import Network.HTTP.Conduit
import qualified Data.ByteString.Lazy as B
import Data.Aeson
import System.IO
import Control.Monad

data Session = Session{ user_id :: String
                        ,nick :: String
                        ,start_time :: String
                      } deriving (Show,Generic)

instance FromJSON Session
instance ToJSON Session

getSessions :: IO B.ByteString
getSessions = curlResults
  where
    curlResults = simpleHttp "https://hubbit.chalmers.it/sessions.json"
