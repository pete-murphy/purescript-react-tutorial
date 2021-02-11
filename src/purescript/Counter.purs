module Counter where

import Prelude
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.Maybe (Maybe(..))
import Data.String.Read (class Read)
import Effect (Effect)
import React.Basic.DOM as R
import React.Basic.Events as Events
import React.Basic.Hooks (Component, JSX, Render, UseState, (/\))
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

mkCounter :: Component Props
mkCounter = React.component "Counter" renderCounter

renderCounter :: Props -> Render Unit (UseState Int Unit) JSX
renderCounter props = React.do
  count /\ setCount <- React.useState' 0
  pure do
    R.button
      { onClick:
          Events.handler_ do
            let
              newCount = case props.counterType of
                Increment -> count + 1
                Decrement -> count - 1
            setCount newCount
            props.onClick newCount
      , children:
          [ R.text (props.label <> " " <> show count) ]
      }
