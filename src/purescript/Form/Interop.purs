module Form.Interop where

import Effect.Unsafe (unsafePerformEffect)
import Form (mkForm)
import React.Basic (ReactComponent)

mkJsForm :: ReactComponent {}
mkJsForm = unsafePerformEffect mkForm
