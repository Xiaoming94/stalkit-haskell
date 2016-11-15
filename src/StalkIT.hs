import Control.Monad
import Data.Maybe
import JsonHandler

main :: IO()
main = stalkIT getSessions

stalkIT :: IO (Maybe [Session]) -> IO ()
stalkIT sess1 = do
  let sess2 = getSessions
  s1 <- sess1
  s2 <- sess2
  print s1
  print s2
