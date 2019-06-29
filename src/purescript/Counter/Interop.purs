module Counter.Interop where

import Prelude

import Counter (CounterType(..), Props, counter, counterTypeFromString, foo)
import Data.Maybe (fromMaybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, runEffectFn1)
import React.Basic (JSX, ReactComponent, make, toReactComponent)
import React.Basic.Hooks (CreateComponent, Render, UseState)

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


