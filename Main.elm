--DET JO EN TOGGLE
--DET JO EN TOGGLE
--DET JO EN TOGGLE
--DET JO EN TOGGLE
--DET JO EN TOGGLE
--DET JO EN TOGGLE
--DET JO EN TOGGLE
--DET JO EN TOGGLE
--DET JO EN TOGGLE
--DET JO EN TOGGLE
--DET JO EN TOGGLE
--DET JO EN TOGGLE
--DET JO EN TOGGLE
--DET JO EN TOGGLE
--DET JO EN TOGGLE
--DET JO EN TOGGLE
--DET JO EN TOGGLE
--DET JO EN TOGGLE
module Main exposing (main)


import Html
import Transit
import Modal
import Html
import Html.Events
import Html.Attributes
import Bootstrap


main : Program Never Model Msg
main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


type alias Data =
  { text : String
  , icon : String
  , toMsg : Msg
  }


type alias WithData data =
  { data | data : Data}


type alias Model =
  Transit.WithTransition (Modal.WithModal (WithData {}))


initialModel : Model
initialModel =
  { modal = Modal.empty
  , transition = Transit.empty
  , data =
    { icon = "cancel"
    , text = "Få nyhederne først!"
    , toMsg = CloseModal -- this makes room for error!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    }
  }


init : ( Model, Cmd Msg )
init = update OpenModal initialModel


type Msg
  = ModalMsg (Modal.Msg Msg)
  | OpenModal
  | CloseModal
  | TransitMsg (Transit.Msg Msg)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ModalMsg modalMsg ->
      Modal.alter ModalMsg modalMsg model

    OpenModal ->
      Transit.start TransitMsg (ModalMsg Modal.Open) (500, 500) model

    CloseModal ->
      Transit.start TransitMsg (ModalMsg Modal.Close) (500, 500) model

    TransitMsg transitMsg ->
      Transit.tick TransitMsg transitMsg model


subscriptions : Model -> Sub Msg
subscriptions model =
  Transit.subscriptions TransitMsg model


config : Modal.Config Data (List int) Msg
config =
  Modal.Config
    { header = header
    , body = body
    }


view : Model -> Html.Html Msg
view { transition, modal, data } =
  Bootstrap.mdPop
    [ animation transition ]
    [ Modal.viewHeader config modal data -- data must be a list
    , Modal.viewBody config modal []
    ]


animation : Transit.Transition -> Html.Attribute msg
animation transition =
  Html.Attributes.style
    [ ( "opacity", toString ( Transit.getValue transition ) )
    , ( "bottom", toString (2 * ( Transit.getValue transition )) ++ "%" )
    ]


header : Data -> Html.Html Msg
header { text, icon, toMsg } =
  -- THIS IS WRONG ikke mdMaxZero men istedet title med children siblings samme lineheight
  Bootstrap.mdMaxZero [] ( title text ) ( button toMsg icon )


title : String -> Html.Html Msg
title text =
  Bootstrap.mdTitle [] [ Html.text text ]


button : Msg -> String -> Html.Html Msg
button msg icon =
  Bootstrap.mdIcon [ Html.Events.onClick msg ] [ Html.text icon ]


body : data -> Html.Html msg
body data =
  Bootstrap.mdOneTwo [] image content


image : Html.Html msg
image =
  Bootstrap.mdImage
    [ backgroundImage ]


backgroundImage : Html.Attribute msg
backgroundImage =
  Html.Attributes.style
    [ ( "background-image", "url(image.jpg)" )
    , ( "background-repeat", "no-repeat" )
    , ( "background-size", "cover" )
    , ( "background-position", "center" )
    , ( "background-origin", "content-box" )
    ]


content : Html.Html msg
content =
  Bootstrap.padding1
    [ paragraph1
    , paragraph2
    , form
    ]


paragraph1 : Html.Html msg
paragraph1 =
  Html.p []
    [ Html.text "Tilmeld dig vores nyhedsmail og få tilbud, inspiration og de bedste rejsetilbud før alle andre." ]


paragraph2 : Html.Html msg
paragraph2 =
  Html.p []
    [ Html.text "Du er samtidig med i lodtrækningen om et rejsegavekort på 5000 kr." ]


form : Html.Html msg
form =
  Bootstrap.mdForm
    [ Html.Attributes.method "POST"
    , Html.Attributes.action "http://coco.cctravel.dk/scripts/apsis/Tilmelding/Callback.php"
    ]
    [ emailInput
    , submitButton
    ]


emailInput : Html.Html msg
emailInput =
  Bootstrap.mdText
    [ Html.Attributes.autocomplete False
    , Html.Attributes.type_ "email"
    , Html.Attributes.name "Email"
    , Html.Attributes.placeholder "Email-addresse"
    ]


submitButton : Html.Html msg
submitButton =
  Bootstrap.mdInput
    [ Html.Attributes.type_ "submit"
    , Html.Attributes.value "TILMELD"
    ]

