module Counter.Interop where

import Prelude
import Counter (Props, counter)
import Data.Maybe (fromMaybe)
import Data.Nullable (Nullable, toMaybe)
import React (ReactElement)

type JSProps
  = { label :: Nullable String }

jsPropsToProps :: JSProps -> Props
jsPropsToProps { label } = { label: fromMaybe "Count" $ toMaybe label }

jsCounter :: JSProps -> ReactElement
jsCounter = counter <<< jsPropsToProps
