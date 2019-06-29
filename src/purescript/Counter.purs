module Counter where

import Prelude
import React.Basic (Component, JSX, Self, createComponent, make)
import React.Basic.DOM as R
import React.Basic.DOM.Events (capture_)

type Props
  = { label :: String }

type State
  = { count :: Int }

component :: Component Props
component = createComponent "Counter"

counter :: Props -> JSX
counter = make component { initialState, render }

initialState :: State
initialState = { count: 0 }

render :: Self Props State -> JSX
render self =
  R.button
    { onClick:
      capture_ $ self.setState \s -> s { count = s.count + 1 }
    , children:
      [ R.text $ self.props.label <> " " <> show self.state.count ]
    }
