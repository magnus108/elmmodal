module Models exposing (Model, initialModel)


import Transit
import Modal


type alias Model =
  Transit.WithTransition (Modal.WithModal {})


initialModel : Model
initialModel =
  { modal = Modal.empty
  , transition = Transit.empty
  }
