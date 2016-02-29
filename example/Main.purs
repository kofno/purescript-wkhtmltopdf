module Main where

import Prelude (Unit, bind, ($))
import Control.Monad.Aff (launchAff)
import Control.Monad.Eff (Eff())
import Control.Monad.Eff.Exception (EXCEPTION())
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE())
import Node.Stream (Writable, pipe)
import Node.FS.Aff (readTextFile)
import Node.FS (FS)
import Node.Encoding (Encoding(..))
import Node.Wkhtmltopdf (PageSize(..), Orientation(..), toPDF, defaultOptions)


foreign import stdout :: forall e. Writable () (console :: CONSOLE | e)


main :: forall e . Eff (err :: EXCEPTION, fs :: FS, console :: CONSOLE | e) Unit
main = launchAff $ do
  contents <- readTextFile UTF8 "example.html"
  pdf <- liftEff $ toPDF options contents
  liftEff $ pdf `pipe` stdout

  where
    options = defaultOptions { orientation = Landscape, pageSize = Letter }

