module Main exposing (main)


import Html exposing (program)

import Messages exposing (Msg)
import Models exposing (Model, init)
import View exposing (view)
import Update exposing (update)
import Subscription exposing (subscriptions)


main : Program Never Model Msg
main =
  program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
