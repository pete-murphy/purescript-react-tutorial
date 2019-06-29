module Counter where

import Prelude
import React.Basic (JSX, createComponent, make)
import React.Basic.DOM as R
import React.Basic.DOM.Events (capture_)

type Props
  = { label :: String }

counter :: Props -> JSX
counter = make (createComponent "Counter") { initialState, render }
  where
  initialState = { count: 0 }

  render self =
    R.button
      { onClick:
        capture_ $ self.setState \s -> s { count = s.count + 1 }
      , children:
        [ R.text $ self.props.label <> " " <> show self.state.count ]
      }
