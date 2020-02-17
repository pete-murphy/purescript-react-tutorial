module Counter where

import Prelude
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.Maybe (Maybe(..))
import Data.String.Read (class Read)
import Effect (Effect)
import React.Basic.DOM as R
import React.Basic.DOM.Events (capture_)
import React.Basic.Hooks (JSX, ReactComponent, Render, UseState, component, useState, (/\))
import React.Basic.Hooks as React

type Props
  = { label :: String
    , onClick :: Int -> Effect Unit
    , counterType :: CounterType
    }

data CounterType
  = Increment
  | Decrement

derive instance genericCounterType :: Generic CounterType _

instance showCounterType :: Show CounterType where
  show = genericShow

instance readCounterType :: Read CounterType where
  read = case _ of
    "Increment" -> Just Increment
    "Decrement" -> Just Decrement
    _ -> Nothing

mkCounter :: Effect (ReactComponent Props)
mkCounter = component "Counter" renderCounter

renderCounter :: Props -> Render Unit (UseState Int Unit) JSX
renderCounter props = React.do
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
