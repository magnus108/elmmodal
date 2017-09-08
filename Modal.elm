module Modal
  exposing
    ( State(..)
    , Config(..)
    , view
    )

import Html
  exposing
    ( Html
    , div
    , text
    )


type State
  = Opening
  | Opened
  | Closed


type Config msg =
  Config
    { header : Html msg
    , body : Html msg
    , closed : Html msg
    }


view : Config msg -> State -> Html msg
view ( Config { header, body, closed } ) state =
  case state of
    Opening ->
      text ""

    Closed ->
      div [] [ closed ]

    Opened ->
      div [] [ header, body ]
