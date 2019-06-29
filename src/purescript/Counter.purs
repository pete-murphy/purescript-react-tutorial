module Counter where

import Prelude
import React
  ( ReactClass
  , ReactElement
  , ReactThis
  , component
  , createLeafElement
  , getProps
  , getState
  , setState
  )
import React.DOM as D
import React.DOM.Props as P

type Props
  = { label :: String }

type State
  = { count :: Int }

counter :: Props -> ReactElement
counter = createLeafElement counterClass

counterClass :: ReactClass Props
counterClass =
  component "Counter" \(this :: ReactThis Props State) -> do
    let
      render = do
        state <- getState this
        props <- getProps this
        pure
          $ D.button
              [ P.onClick \_ -> setState this { count: state.count + 1 } ]
              [ D.text $ props.label <> ": " <> show state.count ]
    pure
      { state: { count: 0 }
      , render
      }
