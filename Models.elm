module Models exposing (Model, init)


import Process
import Task
import Time exposing (Time)


import Modal exposing (State(..))
import Messages exposing (Msg(..))

import Transit


type alias Model =
  Transit.WithTransition
    { modalState : Modal.State
    , opened : Bool
    , email : String
    }


initialModel : Model
initialModel =
  { modalState = Starting
  , opened = False
  , email = ""
  , transition = Transit.empty
  }


popupMsg : Cmd Msg
popupMsg = delay (Time.second * 5) <| InitModalState Open


blinkMsg : Cmd Msg
blinkMsg = delay (Time.second * 0) <| StartModalState


init : ( Model, Cmd Msg )
init = initialModel ! [ blinkMsg ]


delay : Time -> msg -> Cmd msg
delay time msg =
  Process.sleep time
    |> Task.andThen (always <| Task.succeed msg)
    |> Task.perform identity
