module Messages exposing (Msg(..))


import Transit
import Modal


type Msg
  = ModalMsg (Modal.Msg Msg)
  | OpenModal
  | CloseModal
  | TransitMsg (Transit.Msg Msg)
