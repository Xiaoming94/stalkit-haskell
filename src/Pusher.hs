module Pusher where

import DBus.Notify
import System.IO
import Control.Monad
import Control.Concurrent

delay      = 2000000

hasLeft :: [String] -> IO()
hasLeft [] = return()
hasLeft (nick:nickList) = do
  pushLeft nick
  threadDelay delay
  hasLeft nickList


hasArrived :: [String] -> IO()
hasArrived [] = return()
hasArrived (nick:nickList) = do
  pushArrived nick
  threadDelay delay
  hasArrived nickList

pushLeft :: String -> IO()
pushLeft nick = do
  client <- connectSession
  let push = blankNote { summary = "StalkIT",
                         body    = (Just $ Text (nick ++ " has left hubben")) }
  notification <- notify client push
  return ()

pushArrived :: String -> IO()
pushArrived nick = do
  client <- connectSession
  let push = blankNote { summary = "StalkIT",
                         body    = (Just $ Text (nick ++ " has entered hubben")) }
  notification <- notify client push
  return ()
