module Form where

import Prelude
import Data.Maybe (fromMaybe)
import React.Basic.DOM as R
import React.Basic.DOM.Events (targetValue)
import React.Basic.Events (EventHandler, handler)
import React.Basic.Hooks (CreateComponent, Hook, JSX, Render, Tuple, UseState, component, useState, (/\))
import React.Basic.Hooks as React

mkForm :: CreateComponent {}
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

useInputs :: Person -> Hook UseInputs (Tuple Person (Field -> EventHandler))
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
  pure
    $ R.form_
        [ R.input
            { type: "text"
            , value: values.name
            , name: "name"
            , onChange: handleChange Name
            }
        , R.input
            { type: "email"
            , value: values.email
            , name: "email"
            , onChange: handleChange Email
            }
        , R.pre_ [ R.text $ show values ]
        ]
