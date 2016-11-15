import Control.Monad
import Data.Maybe
import JsonHandler
import Control.Concurrent
import Data.List

sleepingTime = 10000000
shortST      = 2000000

main :: IO()
main = stalkIT getSessions

stalkIT :: IO (Maybe [Session]) -> IO ()
stalkIT sess1 = do
  threadDelay sleepingTime
  let sess2 = getSessions
  s1 <- sess1
  s2 <- sess2
  handleSessions (fromJust s1) (fromJust s2)

handleSessions :: [Session] -> [Session] -> IO()
handleSessions s1 s2
  | diff > 0 = hasLeft sessionDiff
  | diff < 0 = hasArrived sessionDiff
  | otherwise = print "equal"
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


hasLeft :: [String] -> IO()
hasLeft [] = print "Haha"
hasLeft (nick:nickList) = do
  print "blaha"


hasArrived :: [String] -> IO()
hasArrived [] = print "haha"
hasArrived (nick:nickList) = do
  print "blaha"
