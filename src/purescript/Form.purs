module Form where

import Prelude

import Data.Maybe (Maybe(..), fromMaybe)
import Data.Nullable (toMaybe)
import React.Basic.DOM as R
import React.Basic.DOM.Events (targetValue)
import React.Basic.Events (EventFn, EventHandler, SyntheticEvent, handler, merge, unsafeEventFn)
import React.Basic.Hooks (CreateComponent, Hook, JSX, Render, Tuple, UseState, component, useState, (/\))
import React.Basic.Hooks as React
import Unsafe.Coerce (unsafeCoerce)

targetName :: EventFn SyntheticEvent (Maybe String)
targetName = unsafeEventFn \e -> toMaybe (unsafeCoerce e).target.name

mkForm :: CreateComponent {}
mkForm = component "Form" renderForm

type UseInputs
  = UseState Person

type Person
  = { name :: String
    , email :: String
    }

useInputs :: Person -> Hook UseInputs (Tuple Person EventHandler)
useInputs initialValues = React.do
  values /\ replaceValues <- useState initialValues
  let
    handleChange =
      handler
        (merge { targetValue, targetName }) \e -> do
        replaceValues \_ -> case e.targetName of
          Just "name" -> values { name = fromMaybe "" e.targetValue }
          Just "email" -> values { email = fromMaybe "" e.targetValue }
          _ -> values
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
            , onChange: handleChange
            }
        , R.input
            { type: "email"
            , value: values.email
            , name: "email"
            , onChange: handleChange
            }
        , R.pre_ [ R.text $ show values ]
        ]
