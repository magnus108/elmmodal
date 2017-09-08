module Update exposing (update)


import Transit

import Models exposing (Model)
import Messages exposing (Msg(..))

import Modal exposing (State(..))


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    SetModalState newState ->
      ( { model | modalState = newState, opened = True }, Cmd.none )

    OpenModal ->
      Transit.start TransitMsg (SetModalState Open) (500, 500) model

    CloseModal ->
      Transit.start TransitMsg (SetModalState Closed) (500, 500) model

    InitModalState newState ->
      if model.opened then
        ( model, Cmd.none )
      else
        ( { model | modalState = newState }, Cmd.none )

    Email email ->
      ( { model | email = email }, Cmd.none )

    StartModalState ->
      Transit.start TransitMsg (SetModalState Closed) (100, 500) model

    TransitMsg transitMsg ->
      Transit.tick TransitMsg transitMsg model
