module Node.Wkhtmltopdf
  ( WkhtmltopdfOptions
  , PageSize(..)
  , Orientation(..)
  , toPDF
  , defaultOptions
  )
  where


import Prelude (class Show, show)
import Control.Monad.Eff (Eff)
import Node.Stream (Readable)
import Data.Maybe (Maybe(..))


type WkhtmltopdfOptions =
  { pageSize :: PageSize
  , orientation :: Orientation
  , title :: Maybe String
  }


data PageSize
  = A0
  | A1
  | A2
  | A3
  | A4
  | A5
  | A6
  | A7
  | A8
  | A9
  | B0
  | B1
  | B2
  | B3
  | B4
  | B5
  | B6
  | B7
  | B8
  | B9
  | B10
  | C5E
  | Comm10E
  | DLE
  | Executive
  | Folio
  | Ledger
  | Legal
  | Letter
  | Tabloid


instance showPageSize :: Show PageSize where
  show A0 = "A0"
  show A1 = "A1"
  show A2 = "A2"
  show A3 = "A3"
  show A4 = "A4"
  show A5 = "A5"
  show A6 = "A6"
  show A7 = "A7"
  show A8 = "A8"
  show A9 = "A9"
  show B0 = "B0"
  show B1 = "B1"
  show B2 = "B2"
  show B3 = "B3"
  show B4 = "B4"
  show B5 = "B5"
  show B6 = "B6"
  show B7 = "B7"
  show B8 = "B8"
  show B9 = "B9"
  show B10 = "B10"
  show C5E = "C5E"
  show Comm10E = "Comm10E"
  show DLE = "DLE"
  show Executive = "Executive"
  show Folio = "Folio"
  show Ledger = "Ledger"
  show Legal = "Legal"
  show Letter = "Letter"
  show Tabloid = "Tabloid"


data Orientation
  = Portrait
  | Landscape


instance showOrientation :: Show Orientation where
  show Portrait = "Portrait"
  show Landscape = "Landscape"


defaultOptions :: WkhtmltopdfOptions
defaultOptions =
  { pageSize : A4
  , orientation : Portrait
  , title : Nothing
  }


foreign import toPDFImpl :: forall eff a.
                            { | a }
                         -> String
                         -> Eff eff (Readable () eff)


toPDF :: forall eff. WkhtmltopdfOptions -> String -> Eff eff (Readable () eff)
toPDF options content =
  toPDFImpl (toOptions options) content


toOptions :: forall a. WkhtmltopdfOptions -> { | a }
toOptions options =
  toOptionsImpl
    { pageSize : show options.pageSize
    , orientation : show options.orientation
    , title : options.title
    }


foreign import toOptionsImpl :: forall a b. { | a } -> { | b }

