module Main (main) where

import Helm as H
import Helm.Engine.SDL as SDL

data Model -- game model

main :: IO ()
main = do
  sdl <- startup
  run sdl (GameConfig (init, H.Cmd.none) upd subs view)
-- a is action
upd :: Model -> a -> (Model, Cmd SDLEngine a)
view :: Model -> Graphics SDLEngine

