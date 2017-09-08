module View exposing (view)


import Html exposing (Html, div, text, button, span, br, input, p)
import Html.Events exposing (onClick, onInput)

import Html.Attributes
  exposing
    ( placeholder
    , type_
    , value
    , action
    , name
    , method
    , autocomplete
    )

import Bootstrap
  exposing
    ( mdTitle
    , mdContent
    , mdForm
    , mdRow
    , flex
    , flex2
    , mdPop
    , mdText
    , padding1
    , mdChip
    , mdIcon
    , mdInput
    , mdColumn
    , mdBackgroundImage
    , mdImage
    )

import Modal exposing (State(..), Config(..))

import Models exposing (Model)
import Messages exposing (Msg(..))


view : Model -> Html Msg
view model =
  mdPop
    [ mdContent
      [ Modal.view config model.modalState
      ]
    ]


config : Config Msg
config =
  Config
    { toMsg = SetModalState
    , header = header
    , body = body
    , closed = closed
    }


header : Html Msg
header =
  mdChip
    [ flex
      [ mdTitle [ text "Få nyhederne først!" ]
      ]
    , close
    ]


body : Html Msg
body =
  mdRow
    [ padding1
      [ mdRow
        [ flex
          [ padding1
            [ mdImage "image.jpg"
            ]
          ]
        , flex2
          [ padding1
            [ p [] [ text "Tilmeld dig vores nyhedsmail og få tilbud, inspiration og de bedste rejsetilbud før alle andre." ]
            , p [] [ text "Du er samtidig med i lodtrækningen om et rejsegavekort på 5000 kr." ]
            , mdForm [ method "POST", action "http://coco.cctravel.dk/scripts/apsis/Tilmelding/Callback.php" ]
              [ mdText [ autocomplete False, type_ "email", name "Email", placeholder "Email-addresse", onInput Email ] []
              , mdInput [ type_ "submit", value "TILMELD" ] []
              ]
            ]
          ]
        ]
      ]
    ]


close : Html Msg
close =
  span [ onClick ( SetModalState Closed )]
    [ mdIcon
      [ text "cancel"
      ]
    ]


closed : Html Msg
closed =
  mdChip
    [ flex
      [ mdTitle [ text "Tilmeld dig nyhedsbrevet" ]
      ]
    , open
    ]


open : Html Msg
open =
  span [ onClick ( SetModalState Open )]
    [ mdIcon
      [ text "menu"
      ]
    ]
