module Counter.Interop where

import Prelude
import Counter
  ( CounterType(..)
  , Props
  , component
  , counterTypeFromString
  , render
  , initialState
  )
import Data.Maybe (fromMaybe)
import Data.Nullable (Nullable, toMaybe)
import Effect.Uncurried (EffectFn1, runEffectFn1)
import React.Basic (ReactComponent, toReactComponent)

type JSProps
  = { label :: Nullable String
    , onClick :: Nullable (EffectFn1 Int Unit)
    , counterType :: Nullable String
    }

jsPropsToProps :: JSProps -> Props
jsPropsToProps props =
  { label:
    fromMaybe (deriveLabelFromType props.counterType) $ toMaybe props.label
  , onClick:
    fromMaybe mempty $ map runEffectFn1 $ toMaybe props.onClick
  , counterType:
    fromMaybe Increment $ counterTypeFromString =<< toMaybe props.counterType
  }
  where
  deriveLabelFromType :: Nullable String -> String
  deriveLabelFromType = fromMaybe "Count" <<< toMaybe

jsCounter :: ReactComponent JSProps
jsCounter = toReactComponent jsPropsToProps component { initialState, render }
