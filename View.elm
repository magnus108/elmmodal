module View exposing (view)

import Transit

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

import Bootstrap exposing (..)

import Modal
import Models exposing (Model)
import Messages exposing (Msg(..))









view : Model -> Html Msg
view model =
  mdPop
    [ style
      [ ( "opacity", toString (Transit.getValue model.transition) )
      , ( "bottom", toString (2 * (Transit.getValue model.transition)) ++ "%" )
      ]
    ]
    [ mdContent
      [ Modal.view config model.modal
      ]
    ]


config : Modal.Config Msg
config =
  Modal.Config
    { open = OpenModal
    , header = header
    , body = body
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
            , form
            ]
          ]
        ]
      ]
    ]


form : Html Msg
form =
  mdForm
    [ method "POST"
    , action "http://coco.cctravel.dk/scripts/apsis/Tilmelding/Callback.php"
    ]
    [ emailInput
    , submitButton
    ]


emailInput : Html Msg
emailInput =
  mdText
    [ autocomplete False
    , type_ "email"
    , name "Email"
    , placeholder "Email-addresse"
    ]


submitButton : Html Msg
submitButton =
  mdInput
    [ type_ "submit"
    , value "TILMELD"
    ]



close : Html Msg
close =
  span [ onClick ( CloseModal )]
    [ mdIcon
      [ text "cancel"
      ]
    ]
