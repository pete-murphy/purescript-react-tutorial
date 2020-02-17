module Counter.Interop where

import Prelude
import Counter (CounterType(..), Props, renderCounter)
import Data.Maybe (fromMaybe)
import Data.Nullable (Nullable, toMaybe)
import Data.String.Read (read)
import Effect.Uncurried (EffectFn1, runEffectFn1)
import Effect.Unsafe (unsafePerformEffect)
import React.Basic.Hooks (ReactComponent, component)

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
    fromMaybe Increment $ read =<< toMaybe props.counterType
  }
  where
  deriveLabelFromType :: Nullable String -> String
  deriveLabelFromType = fromMaybe "Count" <<< toMaybe

mkJsCounter :: ReactComponent JSProps
mkJsCounter = unsafePerformEffect $ component "Counter" (renderCounter <<< jsPropsToProps)
