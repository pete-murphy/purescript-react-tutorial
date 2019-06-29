module Counter.Interop where

import Prelude
import Counter (Props, component, render, initialState)
import Data.Maybe (fromMaybe)
import Data.Nullable (Nullable, toMaybe)
import React.Basic (ReactComponent, toReactComponent)

type JSProps
  = { label :: Nullable String }

jsPropsToProps :: JSProps -> Props
jsPropsToProps { label } = { label: fromMaybe "Count" $ toMaybe label }

jsCounter :: ReactComponent JSProps
jsCounter = toReactComponent jsPropsToProps component { initialState, render }
