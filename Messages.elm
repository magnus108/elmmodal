module Messages exposing (Msg(..))


import Modal


type Msg
  = SetModalState Modal.State
  | InitModalState Modal.State
