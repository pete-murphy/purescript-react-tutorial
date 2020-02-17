module Form where

import Prelude
import Data.Maybe (fromMaybe)
import Effect (Effect)
import React.Basic (ReactComponent, fragment)
import React.Basic.DOM as R
import React.Basic.DOM.Events (targetValue)
import React.Basic.Events (EventHandler, handler)
import React.Basic.Hooks (Hook, JSX, Render, UseState, component, useState, (/\), type (/\))
import React.Basic.Hooks as React

mkForm :: Effect (ReactComponent {})
mkForm = component "Form" renderForm

type UseInputs
  = UseState Person

type Person
  = { name :: String
    , email :: String
    }

data Field
  = Name
  | Email

useInputs :: Person -> Hook UseInputs (Person /\ (Field -> EventHandler))
useInputs initialValues = React.do
  values /\ setValues <- useState initialValues
  let
    handleChange field =
      handler
        targetValue \value -> do
        setValues \_ -> case field of
          Name -> values { name = fromMaybe "" value }
          Email -> values { email = fromMaybe "" value }
  pure (values /\ handleChange)

renderForm :: {} -> Render Unit (UseInputs Unit) JSX
renderForm _ = React.do
  let
    initialValues =
      { name: "Jane Doe"
      , email: "janedoe@gmail.com"
      }
  values /\ handleChange <- useInputs initialValues
  let
    inputLabel children =
      R.label
        { style:
          R.css
            { display: "inline-grid"
            , gridGap: "0.5rem"
            , gridAutoFlow: "column"
            , paddingRight: "1rem"
            }
        , children
        }
  pure
    $ fragment
        [ R.h2_ [ R.text "Form example" ]
        , R.form_
            [ inputLabel
                [ R.text "Name"
                , R.input
                    { type: "text"
                    , value: values.name
                    , name: "name"
                    , onChange: handleChange Name
                    }
                ]
            , inputLabel
                [ R.text "Email"
                , R.input
                    { type: "email"
                    , value: values.email
                    , name: "email"
                    , onChange: handleChange Email
                    }
                ]
            , R.pre_ [ R.text $ show values ]
            ]
        ]
