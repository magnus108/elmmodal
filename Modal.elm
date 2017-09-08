module Modal exposing (State(..), Config(..), view)


import Html exposing (Html, div, text)


type State
  = Open
  | Closed
  | Starting


type Config msg =
  Config
    { header : Html msg
    , body : Html msg
    , closed : Html msg
    }


view : Config msg -> State -> Html msg
view (Config {header, body, closed}) state =
  case state of
    Starting ->
      div [] []

    Closed ->
      div [] [ closed ]

    Open ->
      div [] [ header, body ]
