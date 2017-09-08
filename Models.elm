module Models exposing (Model, init)


import Process
import Task
import Time exposing (Time)


import Modal exposing (State(..))
import Messages exposing (Msg(..))

import Transit

--naming!
type alias General =
  { modalState : Modal.State
  , opened : Bool
  }

type alias Model =
  Transit.WithTransition General


initialModel : Model
initialModel =
  { modalState = Opening
  , opened = False
  , transition = Transit.empty
  }


popupMsg : Cmd Msg
popupMsg = delay (Time.second * 5) <| InitModalState Opened


blinkMsg : Cmd Msg
blinkMsg = delay (Time.second * 0) <| CloseModalStart


init : ( Model, Cmd Msg )
init = initialModel ! [ blinkMsg ]


delay : Time -> msg -> Cmd msg
delay time msg =
  Process.sleep time
    |> Task.andThen (always <| Task.succeed msg)
    |> Task.perform identity
