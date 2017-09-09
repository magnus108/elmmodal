module Modal
  exposing
    ( Config(..)
    , Msg(..)
    , alter
    , WithModal
    , empty
    , view
    )

import Html exposing (..)
import Html.Events exposing (..)




import Bootstrap exposing (..)



type alias WithModal model =
  { model | modal : Modal }


type Modal
  = M State


getState : Modal -> State
getState modal =
  case modal of
    M s ->
      s


type alias State =
  { status : Status
  , pristine : Bool
  }


type Status
  = Opening
  | Opened
  | Closed



type Msg msg
  = Open
  | Close



empty : Modal
empty =
  M initialState


initialState : State
initialState =
  { status = Opening
  , pristine = True
  }



alter : (Msg msg -> msg) -> Msg msg -> WithModal parent -> ( WithModal parent, Cmd msg )
alter tagger msg parent =
  let
    state =
      getState parent.modal

    tag ( state, fx ) =
      ( { parent | modal = M state }, Cmd.map tagger fx )
  in
    tag ( { state | status = Opened, pristine = False }, Cmd.none )









closed : msg -> Html msg
closed toMsg =
  mdChip
    [ flex
      [ mdTitle [ text "Tilmeld dig nyhedsbrevet" ]
      ]
    , open toMsg
    ]


open : msg -> Html msg
open toMsg =
  span [ onClick toMsg ]
    [ mdIcon
      [ text "menu"
      ]
    ]




type Config msg =
  Config
    { open : msg
    , header : Html msg
    , body : Html msg
    }



view : Config msg -> Modal -> Html msg
view ( Config { header, body, open } ) modal =
  let
    state =
      getState modal
  in
    case state.status of
      Opening ->
        text ""

      Closed ->
        div [] [ closed open ]

      Opened ->
        div [] [ header, body ]
