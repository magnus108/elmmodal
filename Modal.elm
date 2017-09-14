module Modal
  exposing
    ( Config(..)
    , Msg(..)
    , alter
    , WithModal
    , empty
    , viewHeader
    , viewBody
    )


-- purge
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Bootstrap exposing (..)


type alias WithModal model =
  { model | modal : Modal }


type Modal
  = M State


getState : Modal -> State
getState modal =
  case modal of
    M s -> s


type alias State =
  { status : Status
  , pristine : Bool
  }


type Status
  = NotCalled
  | Opened
  | Closed


type Msg msg
  = Open
  | Close


empty : Modal
empty =
  M initialState


initialState : State
initialState =
  { status = NotCalled
  , pristine = True
  }


alter : (Msg msg -> msg) -> Msg msg -> WithModal parent -> ( WithModal parent, Cmd msg )
alter tagger msg parent =
  let
    state =
      getState parent.modal

    tag ( state, fx ) =
      ( { parent | modal = M state }, Cmd.map tagger fx )
  in
    case msg of
      Open ->
        tag ( { state | status = Opened, pristine = False }, Cmd.none )

      Close ->
        tag ( { state | status = Closed }, Cmd.none )





















type Config headerData bodyData msg =
  Config
    { body : bodyData -> Html msg
    , header : headerData -> Html msg --- kan ændres til WithData ??
    }


--THIS seems weird that config needs body data here
viewHeader : Config headerData bodyData msg -> Modal -> headerData -> Html msg
viewHeader ( Config { header } ) modal data =
  let
    state =
      getState modal
  in
    case state.status of
      NotCalled ->
        text ""

      Closed ->
        header data
  --      mdContent [] [ header closedHeaderConfig openMsg ]

      Opened ->
        header data
        --mdContent [] [ header openHeaderConfig closeMsg, body ]


viewBody : Config headerData bodyData msg -> Modal -> bodyData -> Html msg
viewBody ( Config { body } ) modal data =
  let
    state =
      getState modal
  in
    case state.status of
      NotCalled ->
        text ""

      Closed ->
        text ""
  --      mdContent [] [ header closedHeaderConfig openMsg ]

      Opened ->
        body data
        --mdContent [] [ header openHeaderConfig closeMsg, body ]



{-
type HeaderConfig =
  HeaderConfig
    { title : String
    , icon : String
    }


closedHeaderConfig : HeaderConfig
closedHeaderConfig =
  HeaderConfig
    { title = "Tilmeld dig nyhedsbrevet"
    , icon = "menu"
    }


openHeaderConfig : HeaderConfig
openHeaderConfig =
  HeaderConfig
    { title = "Få nyhederne først!"
    , icon = "cancel"
    }


-- DEN Her skal nok ikke være gemt her. Tanken er at header er statisk i modal
header : HeaderConfig -> msg -> Html msg
header ( HeaderConfig { title, icon } ) msg =
  mdChip
    [ mdTitle [] [ text title ]
    , mdIcon [ onClick msg ] [ text icon ]
    ]
    -}
