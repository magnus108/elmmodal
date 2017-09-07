module Update exposing (update)


import Models exposing (Model)
import Messages exposing (Msg(..))


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    SetModalState newState ->
      ( { model | modalState = newState, opened = True }, Cmd.none )

    InitModalState newState ->
      if model.opened then
        ( model, Cmd.none )
      else
        ( { model | modalState = newState }, Cmd.none )
