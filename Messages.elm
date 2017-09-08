module Messages exposing (Msg(..))


import Transit

import Modal


type Msg
  = InitModalState Modal.State
  | StartModalState
  | OpenModalStart
  | OpenModalStop
  | CloseModalStart
  | CloseModalStop
  | TransitMsg (Transit.Msg Msg)
