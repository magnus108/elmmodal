module Subscription exposing (subscriptions)


import Transit

import Models exposing (Model)
import Messages exposing (Msg(..))


subscriptions : Model -> Sub Msg
subscriptions model =
  Transit.subscriptions TransitMsg model
