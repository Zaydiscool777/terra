module Main (main) where

import Helm as H
import qualified Helm.Asset as H.Ast
import qualified Helm.Cmd as H.Cmd
import qualified Helm.Color as H.Color
import qualified Helm.Engine as H.Eng
import qualified Helm.Engine.SDL as SDL
import qualified Helm.Engine.SDL.Asset as SDL.Ast
import qualified Helm.Engine.SDL.Engine as SDL.Eng
import qualified Helm.Engine.SDL.Graphics2D as SDL.G2D
import qualified Helm.Engine.SDL.Keyboard as SDL.Key
import qualified Helm.Engine.SDL.Mouse as SDL.Mouse
import qualified Helm.Graphics as H.Gs
import qualified Helm.Graphics2D as G2D
import qualified Helm.Graphics2D.Text as G2D.Text
import qualified Helm.Graphics2D.Transform as G2D.Tran
import qualified Helm.Keyboard as H.Key
import qualified Helm.Mouse as H.Mouse
import qualified Helm.Sub as H.Sub
import qualified Helm.Time as H.Time
import qualified Helm.Window as H.Win
import Linear

type Model = () -- game model
type Action = () -- game action/state?

main :: IO ()
main = do
  sdl <- SDL.startupWith (SDL.defaultConfig {SDL.windowDimensions = pure 500})
  run sdl (H.Eng.GameConfig _init (upd sdl) (subs sdl) view)
-- a is action
_init :: (Model, Cmd SDL.SDLEngine Action)
_init = ((), H.Cmd.none)
upd :: SDL.SDLEngine -> Model -> Action -> (Model, Cmd SDL.SDLEngine Action)
upd _ _ _ = ((), H.Cmd.none)
subs :: SDL.SDLEngine -> H.Sub.Sub SDL.SDLEngine Action
subs _ = H.Sub.none
view :: Model -> Graphics SDL.SDLEngine
view _ = H.Gs.Graphics2D (G2D.collage
  [G2D.filled (H.Color.rgb 1 1 1) (G2D.rect (pure 1250)),
  G2D.move (V2 150 50) (G2D.text (G2D.Text.showText "IO goes here"))])
