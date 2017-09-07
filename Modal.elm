module Modal exposing (State(..), Config(..), view)


import Html exposing (Html, div, text)


type State
  = Open
  | Closed


type Config msg =
  Config
    { toMsg : State -> msg
    , header : Html msg
    , body : Html msg
    , closed : Html msg
    }


view : Config msg -> State -> Html msg
view (Config {toMsg, header, body, closed}) state =
  case state of
    Closed ->
      div [] [ closed ]

    Open ->
      div [] [ header, body ]
