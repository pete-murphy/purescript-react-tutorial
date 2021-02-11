module App where

import Prelude
import Counter (CounterType(..), mkCounter)
import React.Basic.DOM as R
import React.Basic.Hooks (Component)
import React.Basic.Hooks as React

mkApp :: Component Unit
mkApp = do
  counter <- mkCounter
  React.component "App" \_ -> React.do
    pure do
      R.div_
        [ R.h1_ [ R.text "My App" ]
        , counter
            { counterType: Increment
            , label: "Count"
            , onClick: mempty
            }
        ]
