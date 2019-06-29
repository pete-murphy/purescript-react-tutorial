module Counter where

import Prelude
import Data.Maybe (Maybe(..))
import Effect (Effect)
import React.Basic.DOM as R
import React.Basic.DOM.Events (capture_)
import React.Basic.Hooks (CreateComponent, component, useState, (/\))
import React.Basic.Hooks as React

type Props
  = { label :: String
    , onClick :: Int -> Effect Unit
    , counterType :: CounterType
    }

data CounterType
  = Increment
  | Decrement

counterTypeToString :: CounterType -> String
counterTypeToString Increment = "+"

counterTypeToString Decrement = "-"

counterTypeFromString :: String -> Maybe CounterType
counterTypeFromString = case _ of
  "+" -> Just Increment
  "-" -> Just Decrement
  _ -> Nothing

counter :: CreateComponent Props
counter =
  component "Counter" \props -> React.do
    count /\ setCount <- useState 0
    pure
      $ R.button
          { onClick:
            capture_ do
              let
                newCount = case props.counterType of
                  Increment -> count + 1
                  Decrement -> count - 1
              setCount \_ -> newCount
              props.onClick newCount
          , children:
            [ R.text $ props.label <> " " <> show count ]
          }
