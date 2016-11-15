import Control.Monad
import Data.Maybe
import JsonHandler

main = do
  sessions <- getSessions
  print "Hello World"
  print sessions
