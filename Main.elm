module Main exposing (main)


import Html exposing (Html)
import Transit
import Switch exposing (Switch, On, Off)
import Either exposing (Either)
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
  }


type alias WithData data =
  { data | data : Data}


type alias WithSwitch model =
  { model | switch : Either (Switch On) (Switch Off) }


type alias Model =
  Transit.WithTransition (WithSwitch (WithData {}))


initialSwitch : Either (Switch On) (Switch Off)
initialSwitch =
  Either.right Switch.initialModel


initialModel : Model
initialModel =
  { switch = initialSwitch
  , transition = Transit.empty
  , data =
    { icon = "cancel"
    , text = "Få nyhederne først!"
    }
  }


init : ( Model, Cmd Msg )
init = ( initialModel, Cmd.none )


type Msg
  = OpenSwitch --Switch.On
  | CloseSwitch
  | SwitchMsg
  | TransitMsg (Transit.Msg Msg)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    SwitchMsg ->
      let
        newSwitch =
          Either.map1 Switch.switchOff Switch.switchOn model.switch
      in
        ({ model | switch = newSwitch }, Cmd.none)

    OpenSwitch ->
      Transit.start TransitMsg SwitchMsg (500, 500) model

    CloseSwitch ->
      Transit.start TransitMsg SwitchMsg (500, 500) model

    TransitMsg transitMsg ->
      Transit.tick TransitMsg transitMsg model


subscriptions : Model -> Sub Msg
subscriptions model =
  Transit.subscriptions TransitMsg model


view : Model -> Html Msg
view model =
  Either.map2 (viewOn model) (viewOff model) model.switch


animation : Transit.Transition -> Html.Attribute msg
animation transition =
  Html.Attributes.style
    [ ( "opacity", toString ( Transit.getValue transition ) )
    , ( "bottom", toString (2 * ( Transit.getValue transition )) ++ "%" )
    ]


viewOn : Model -> Html Msg
viewOn model =
  Bootstrap.mdPop
    [ animation model.transition ]
    [ header model.data CloseSwitch
    , body
    ]


body : Html Msg
body =
  Bootstrap.mdOneTwo [] image content


viewOff : Model -> Html Msg
viewOff model =
  Bootstrap.mdPop
    [ animation model.transition ]
    [ header model.data OpenSwitch ]


header : Data -> Msg -> Html Msg
header { icon, text } msg =
  Bootstrap.mdMaxZero []
    ( title text ) ( button msg icon )


title : String -> Html msg
title text =
  Bootstrap.mdTitle [] [ Html.text text ]


button : Msg -> String -> Html Msg
button msg icon =
  Bootstrap.mdIcon [ Html.Events.onClick msg ] [ Html.text icon ]


image : Html msg
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


content : Html msg
content =
  Bootstrap.padding1
    [ paragraph1
    , paragraph2
    , form
    ]


paragraph1 : Html msg
paragraph1 =
  Html.p []
    [ Html.text "Tilmeld dig vores nyhedsmail og få tilbud, inspiration og de bedste rejsetilbud før alle andre." ]


paragraph2 : Html msg
paragraph2 =
  Html.p []
    [ Html.text "Du er samtidig med i lodtrækningen om et rejsegavekort på 5000 kr." ]


form : Html msg
form =
  Bootstrap.mdForm
    [ Html.Attributes.method "POST"
    , Html.Attributes.action "http://coco.cctravel.dk/scripts/apsis/Tilmelding/Callback.php"
    ]
    [ emailInput
    , submitButton
    ]


emailInput : Html msg
emailInput =
  Bootstrap.mdText
    [ Html.Attributes.autocomplete False
    , Html.Attributes.type_ "email"
    , Html.Attributes.name "Email"
    , Html.Attributes.placeholder "Email-addresse"
    ]


submitButton : Html msg
submitButton =
  Bootstrap.mdInput
    [ Html.Attributes.type_ "submit"
    , Html.Attributes.value "TILMELD"
    ]
