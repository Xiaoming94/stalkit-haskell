import Control.Monad
import Data.Maybe
import JsonHandler
import Pusher
import Control.Concurrent
import Data.List

sleepingTime = 10000000

main :: IO()
main = do
  initialSession <- getSessions
  stalkIT initialSession

stalkIT :: Maybe [Session] -> IO ()
stalkIT s1 = do
  threadDelay sleepingTime
  s2 <- getSessions
  handleSessions (fromJust s1) (fromJust s2)
  stalkIT s2

handleSessions :: [Session] -> [Session] -> IO()
handleSessions s1 s2
  | diff > 0 = hasLeft sessionDiff
  | diff < 0 = hasArrived sessionDiff
  | otherwise = return()
  where
    diff = length s1 - length s2
    sessionDiff = calcDiffNicks s1 s2

calcDiffNicks :: [Session] -> [Session]-> [String]
calcDiffNicks [] _        = ["Dumbass"]
calcDiffNicks _  []       = ["Dumbass"]
calcDiffNicks s1 s2
  | length s1 > length s2 = (getNicksFromJson s1) \\ (getNicksFromJson s2)
  | length s1 < length s2 = (getNicksFromJson s2) \\ (getNicksFromJson s1)
  | otherwise             = []
