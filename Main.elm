module Main exposing (main)


import Html exposing (Html)
import Transit
import Switch exposing (On, OnOff, Off, OffOn, Hidden, Mini)
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


type alias WithSwitch model = { model | switch : Switch }


type alias Model =
  Transit.WithTransition (WithSwitch {})


type alias Switch =
  Either
    (Switch.Switch Hidden)
    (Switch.Switch On)
    (Switch.Switch OnOff)
    (Switch.Switch Off)
    (Switch.Switch OffOn)
    (Switch.Switch Mini)


initialSwitch : Switch
initialSwitch =
  Either.hidden Switch.hidden


initialModel : Model
initialModel =
  { switch = initialSwitch
  , transition = Transit.empty
  }


init : (Model, Cmd Msg)
init = update SwitchUnhide initialModel


type Msg
  = SwitchUnhide
  | SwitchOn (Switch.Switch OffOn)
  | SwitchOff (Switch.Switch On)
  | SwitchMsg (Switch)
  | TransitMsg (Transit.Msg Msg)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    SwitchMsg switch ->
  --    let
        -- Im pretty sure there could be more safety here
        -- make you own transit module with 2 states done og transit...
        -- simply like switch... GG
 --       newSwitch =
  --        Either.map1 Switch.switchOff Switch.switchOn model.switch
   ---   in
      ({ model | switch = switch }, Cmd.none)

    SwitchUnhide ->
      Transit.start TransitMsg (SwitchMsg switchUnhide) (500, 500)
        model

    SwitchOn switch ->
      Transit.start TransitMsg (SwitchMsg (switchOn switch)) (500, 500)
        { model | switch = Either.offOn switch }

    SwitchOff switch ->
      -- DER SKAL VÆRE EN LET HER CUZ SIDEEFFEKT :S
      -- Det skal være min model jeg passer rundt jo
      -- Det skal være min model jeg passer rundt jo
      -- Det skal være min model jeg passer rundt jo
      -- Det skal være min model jeg passer rundt jo
      -- Det skal være min model jeg passer rundt jo
      Transit.start TransitMsg (SwitchMsg (switchOff switch)) (500, 500)
        { model | switch = Either.onOff (Switch.switchingOff switch) }

    TransitMsg transitMsg ->
      Transit.tick TransitMsg transitMsg model


switchUnhide : Switch
switchUnhide =
  Either.off Switch.off


switchOn : Switch.Switch OffOn -> Switch
switchOn =
  Either.on << Switch.switchOn


switchOff : Switch.Switch On -> Switch
switchOff =
  Either.off << Switch.switchOff


subscriptions : Model -> Sub Msg
subscriptions model =
  Transit.subscriptions TransitMsg model


view : Model -> Html Msg
view model =
  Either.map
    (viewHidden model)
    (viewOn model)
    (viewOnOff model)
    (viewOff model)
    (viewOffOn model)
    (viewMini model)
    model.switch


animation : Transit.Transition -> Html.Attribute msg
animation transition =
  Html.Attributes.style
    [ ( "opacity", toString ( Transit.getValue transition ) )
    , ( "bottom", toString (2 * ( Transit.getValue transition )) ++ "%" )
    ]


legacy : Html.Attribute msg
legacy =
  Html.Attributes.style
    [ ( "z-index", "200" ) ]


legacy2 : Html.Attribute msg
legacy2 =
  Html.Attributes.style
    [ ( "background", "white" ) ]


legacy3 : Html.Attribute msg
legacy3 =
  Html.Attributes.style
    [ ( "word-wrap", "initial" ) ]


empty : Html msg
empty = Html.text ""


viewHidden : Model -> Switch.Switch Hidden -> Html Msg
viewHidden model switch =
  empty


viewMini : Model -> Switch.Switch Mini -> Html Msg
viewMini mode switch =
  empty


viewOn : Model -> Switch.Switch On -> Html Msg
viewOn model switch =
  Bootstrap.mdPop
    [ animation model.transition, legacy, legacy2 ]
    [ header2
      { icon = "cancel"
      , text = "Få nyhederne først!"
      , disabled = False
      , msg = SwitchOff switch
      }
    , body
    ]


viewOnOff : Model -> Switch.Switch OnOff -> Html Msg
viewOnOff model switch =
  Bootstrap.mdPop
    [ animation model.transition, legacy, legacy2 ]
    [ header2
      { icon = "cancel"
      , text = "Få nyhederne først!"
      , disabled = True
      , msg = SwitchMsg model.switch --fejl
      }
    , body
    ]


body : Html Msg
body =
  Bootstrap.mdOneTwo [legacy2] image content


viewOff : Model -> Switch.Switch Off -> Html Msg
viewOff model switch =
  Bootstrap.mdPop
    [ animation model.transition, legacy, legacy2 ]
    [ header
      { icon = "menu"
      , text = "Få nyhederne først"
      , disabled = False
      , msg = SwitchOn (Switch.switchingOn switch)
      }
    ]

viewOffOn : Model -> Switch.Switch OffOn -> Html Msg
viewOffOn model switch =
  Bootstrap.mdPop
    [ animation model.transition, legacy, legacy2 ]
    [ header
      { icon = "menu"
      , text = "Få nyhederne først"
      , disabled = True
      , msg = SwitchMsg model.switch -- fejl
      }
    ]


header : Data -> Html Msg
header { icon, text, disabled, msg } =
  Bootstrap.mdMaxZero
    [ Html.Events.onClick msg
    , Html.Attributes.disabled disabled
    ]
    ( title text ) ( button icon )

--remove i got stressed
header2 : Data -> Html Msg
header2 { icon, text, disabled, msg } =
  Bootstrap.mdMaxZero2
    [ Html.Events.onClick msg
    , Html.Attributes.disabled disabled
    ]
    ( title text ) ( button icon )


title : String -> Html msg
title text =
  Bootstrap.mdTitle [] [ Html.text text ]


button : String -> Html Msg
button icon =
  Bootstrap.mdIcon
    [ legacy3 ]
    [ Html.text icon ]


image : Html msg
image =
  Bootstrap.mdImage
    [ backgroundImage ]


backgroundImage : Html.Attribute msg
backgroundImage =
  Html.Attributes.style
    [ ( "background-image", "url(//cctravel.dk/sites/cctravel.dk/files/images/image.jpg)" )
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
    , Html.Attributes.action "//cctravel.dk/sites/cctravel.dk/files/testmail/Tilmelding/Callback.php"
    ]
    [ emailInput
    , submitButton
    ]


emailInput : Html msg
emailInput =
  Bootstrap.mdText
    [ legacy2
    , Html.Attributes.autocomplete False
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
