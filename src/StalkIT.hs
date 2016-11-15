import Control.Monad
import Data.Maybe
import JsonHandler
import Control.Concurrent

sleepingTime = 10000000

main :: IO()
main = stalkIT getSessions

stalkIT :: IO (Maybe [Session]) -> IO ()
stalkIT sess1 = do
  threadDelay sleepingTime
  let sess2 = getSessions
  s1 <- sess1
  s2 <- sess2
  handleSessions fromJust(s1) fromJust(s2)

handleSession :: [Session] -> [Session] -> [Session]
handleSession s1 s2 = s1
