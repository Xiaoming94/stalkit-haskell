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

getSessions :: IO (Maybe [Session])
getSessions = decode <$> curlResults
  where
    curlResults = simpleHttp "https://hubbit.chalmers.it/sessions.json"

{-compDiff :: IO (Maybe [Session])
compDiff = do
  sess1 <- getSessions
  sleep 20000
  sess2 <- if isJust sess1 then getSessions else Nothing
  return $ do
    s1 <- sess1
    s2 <- sess2
    return $ diff s1 s2

u = undefined

diff :: [Session] -> [Session] -> [Session]
diff [] _ = []
diff xs [] = []
diff x:xs
-}
