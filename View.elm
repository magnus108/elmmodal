module View exposing (view)


import Html exposing (Html, div, text, button, span, br)
import Html.Events exposing (onClick)

import Bootstrap
  exposing
    ( mdTitle
    , mdContent
    , mdRow
    , flex
    , flex2
    , mdPop
    , padding1
    , mdChip
    , mdIcon
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
            [ mdImage "Nepal2.png"
            ]
          ]
        , flex2
          [ padding1
            [ text " Tilmeld dig vores nyhedsmail og få tilbud, inspiration og de bedste rejsetilbud før alle andre." 
            , br [] []
            , text " Vi trækker lod fire gange om året om et gavekort à 5000 kr. Måske bliver du den heldige vinder!"
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
