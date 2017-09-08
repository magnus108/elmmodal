module Messages exposing (Msg(..))


import Transit

import Modal


type Msg
  = SetModalState Modal.State
  | InitModalState Modal.State
  | Email String
  | StartModalState
  | OpenModal
  | CloseModal
  | TransitMsg (Transit.Msg Msg)
