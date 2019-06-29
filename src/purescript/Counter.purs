module Counter where

import Prelude
import Data.Maybe (Maybe(..))
import Effect (Effect)
import React.Basic (Component, JSX, Self, createComponent, make, readProps, readState)
import React.Basic.DOM as R
import React.Basic.DOM.Events (capture_)

type Props
  = { label :: String
    , onClick :: Int -> Effect Unit
    , counterType :: CounterType
    }

type State
  = { count :: Int }

data CounterType
  = Increment
  | Decrement

component :: Component Props
component = createComponent "Counter"

counterTypeToString :: CounterType -> String
counterTypeToString Increment = "+"

counterTypeToString Decrement = "-"

counterTypeFromString :: String -> Maybe CounterType
counterTypeFromString = case _ of
  "+" -> Just Increment
  "-" -> Just Decrement
  _ -> Nothing

counter :: Props -> JSX
counter = make component { initialState, render }

initialState :: State
initialState = { count: 0 }

render :: Self Props State -> JSX
render self =
  R.button
    { onClick:
      capture_ do
        state <- readState self
        props <- readProps self
        let
          newCount = case props.counterType of
            Increment -> add state.count 1
            Decrement -> sub state.count 1
        self.setState _ { count = newCount }
        props.onClick newCount
    , children:
      [ R.text $ self.props.label <> " " <> show self.state.count ]
    }
