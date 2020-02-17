{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "react-tutorial"
, dependencies =
  [ "console"
  , "effect"
  , "generics-rep"
  , "psci-support"
  , "react-basic-hooks"
  , "read"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
