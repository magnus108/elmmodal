module Models exposing (Model, init)


import Process
import Task
import Time exposing (Time)


import Modal exposing (State(..))
import Messages exposing (Msg(..))


type alias Model =
  { modalState : Modal.State
  , opened : Bool
  }


initialModel : Model
initialModel =
  { modalState = Closed
  , opened = False
  }


init : ( Model, Cmd Msg )
init = ( initialModel, delay (Time.second * 5) <| InitModalState Open )


delay : Time -> msg -> Cmd msg
delay time msg =
  Process.sleep time
    |> Task.andThen (always <| Task.succeed msg)
    |> Task.perform identity
