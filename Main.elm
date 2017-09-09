module Main exposing (main)


import Html exposing (program)

import Messages exposing (Msg(..))

import Models exposing (Model, initialModel)
import View exposing (view)
import Update exposing (update)
import Subscription exposing (subscriptions)



init : ( Model, Cmd Msg )
init = update CloseModal initialModel


main : Program Never Model Msg
main =
  program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ModalMsg modalMsg ->
      Modal.alter ModalMsg modalMsg model

    OpenModal ->
      Transit.start TransitMsg (ModalMsg Modal.Open) (500, 500) model

    CloseModal ->
      Transit.start TransitMsg (ModalMsg Modal.Close) (500, 500) model

    TransitMsg transitMsg ->
      Transit.tick TransitMsg transitMsg model
