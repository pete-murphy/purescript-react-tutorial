module Counter.Interop where

import Prelude
import Counter (CounterType(..), Props, renderCounter)
import Data.Maybe as Maybe
import Data.Nullable (Nullable)
import Data.Nullable as Nullable
import Data.String.Read as Read
import Effect.Uncurried (EffectFn1)
import Effect.Uncurried as Uncurried
import Effect.Unsafe as Unsafe
import React.Basic.Hooks (JSX)
import React.Basic.Hooks as React

type JSProps
  = { label :: Nullable String
    , onClick :: Nullable (EffectFn1 Int Unit)
    , counterType :: Nullable String
    }

jsPropsToProps :: JSProps -> Props
jsPropsToProps props =
  { label:
      Maybe.fromMaybe (deriveLabelFromType props.counterType) (Nullable.toMaybe props.label)
  , onClick:
      Maybe.fromMaybe mempty (map Uncurried.runEffectFn1 (Nullable.toMaybe props.onClick))
  , counterType:
      Maybe.fromMaybe Increment (Read.read =<< Nullable.toMaybe props.counterType)
  }
  where
  deriveLabelFromType :: Nullable String -> String
  deriveLabelFromType = Maybe.fromMaybe "Count" <<< Nullable.toMaybe

jsCounter :: JSProps -> JSX
jsCounter =
  Unsafe.unsafePerformEffect do
    React.component "Counter" (renderCounter <<< jsPropsToProps)
