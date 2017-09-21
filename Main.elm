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
  , disabled : Bool
  , msg : Msg
  }


type alias WithSwitch model =
  { model | switch : Either (Switch On) (Switch Off) }


type alias Model =
  Transit.WithTransition (WithSwitch {})


initialSwitch : Either (Switch On) (Switch Off)
initialSwitch =
  Either.right Switch.initialModel


initialModel : Model
initialModel =
  { switch = initialSwitch
  , transition = Transit.empty
  }


init : ( Model, Cmd Msg )
init = ( initialModel, Cmd.none )


type Msg
  = SwitchOn (Switch Off)
  | SwitchOff (Switch On)
  | SwitchMsg
  | TransitMsg (Transit.Msg Msg)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    SwitchMsg ->
      let
        -- Im pretty sure there could be more safety here
        -- make you own transit module with 2 states done og transit...
        -- simply like switch... GG
        newSwitch =
          Either.map1 Switch.switchOff Switch.switchOn model.switch
      in
        ({ model | switch = newSwitch }, Cmd.none)

    SwitchOn switch ->
      Transit.start TransitMsg SwitchMsg (500, 500) model

    SwitchOff switch ->
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


disabled : Float -> Bool
disabled x =
  x /= 1


viewOn : Model -> Switch On -> Html Msg
viewOn model switch =
  Bootstrap.mdPop
    [ animation model.transition ]
    [ header
      { icon = "cancel"
      , text = "Få nyhederne først!"
      , disabled = disabled (Transit.getValue model.transition)
      , msg = SwitchOff switch
      }
    , body
    ]


body : Html Msg
body =
  Bootstrap.mdOneTwo [] image content


viewOff : Model -> Switch Off -> Html Msg
viewOff model switch =
  Bootstrap.mdPop
    [ animation model.transition ]
    [ header
      { icon = "menu"
      , text = "Tilmeld dig nyhedsbrevet"
      , disabled = disabled (Transit.getValue model.transition)
      , msg = SwitchOn switch
      }
    ]


header : Data -> Html Msg
header { icon, text, disabled, msg } =
  Bootstrap.mdMaxZero []
    ( title text ) ( button msg icon disabled )


title : String -> Html msg
title text =
  Bootstrap.mdTitle [] [ Html.text text ]


button : Msg -> String -> Bool -> Html Msg
button msg icon disabled =
  Bootstrap.mdIcon
    [ Html.Events.onClick msg
    , Html.Attributes.disabled disabled
    ]
    [ Html.text icon ]


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
