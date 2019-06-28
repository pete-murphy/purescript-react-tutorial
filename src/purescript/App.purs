module App where

import Counter (counter)
import React (ReactElement)
import React.DOM (div', h1', text)
import React.DOM.Props (Props)

app :: Props -> ReactElement
app _ =
  div'
    [ h1' [text "My App"]
    , counter { label: "Count" }
    , counter { label: "Clicks" }
    , counter { label: "Interactions" }
    , counter { label: "PureScript!" }
    ]
    