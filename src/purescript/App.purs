module App where

import Prelude

import Counter (CounterType(..), counter)
import Effect (Effect)
import React.Basic (element, JSX)
import React.Basic.DOM (div_, h1_, text)

app :: Effect JSX
app = do
  counter' <- counter
  pure $ div_
    [ h1_ [ text "My App" ]
    , element counter'
        { counterType: Increment
        , label: "Count"
        , onClick: mempty
        }
    ]
