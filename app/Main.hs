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

data Model = Model {displaySize :: V2 Double} -- data model
data Action = WindowSizeChanged (V2 Int) -- sum of actions

main :: IO ()
main = do
  sdl <- SDL.startupWith (SDL.defaultConfig {SDL.windowDimensions = pure 625})
  run sdl (H.Eng.GameConfig init' upd subs view)
init' :: (Model, Cmd SDL.SDLEngine Action)
init' = (Model (pure 625), H.Win.size WindowSizeChanged)
upd :: Model -> Action -> (Model, Cmd SDL.SDLEngine Action)
upd _ a = case a of
  WindowSizeChanged size -> (Model (fromIntegral <$> size), H.Cmd.none)
subs :: H.Sub.Sub SDL.SDLEngine Action
subs = H.Win.resizes WindowSizeChanged
view :: Model -> Graphics SDL.SDLEngine
view m = H.Gs.Graphics2D $ G2D.collage
  [G2D.filled (H.Color.rgb 1 1 1) $ G2D.rect $ displaySize m * 2,
  G2D.move (displaySize m - V2 100 20) $ G2D.text $ G2D.Text.showText $ displaySize m]
