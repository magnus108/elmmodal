module Update exposing (update)


import Transit

import Models exposing (Model)
import Messages exposing (Msg(..))

import Modal exposing (State(..))




update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    OpenModalStart ->
      Transit.start TransitMsg OpenModalStop (500, 500) model

    OpenModalStop ->
      ( { model | modalState = Opened, opened = True }, Cmd.none )

    CloseModalStart ->
      Transit.start TransitMsg CloseModalStop (500, 500) model

    CloseModalStop ->
      ( { model | modalState = Closed }, Cmd.none )



    InitModalState newState ->
      if model.opened then
        ( model, Cmd.none )
      else
        ( { model | modalState = newState }, Cmd.none )

    StartModalState ->
      Transit.start TransitMsg OpenModalStart (100, 500) model

    TransitMsg transitMsg ->
      Transit.tick TransitMsg transitMsg model
