module Switch
  exposing
    ( Switch
    , On
    , Off
    , initialModel
    , switchOn
    , switchOff
    )


type On = On
type Off = Off
type Switch a = State Bool


initialModel : Switch Off
initialModel = off


fromBool : Bool -> Switch a
fromBool = State


map : (Bool -> Bool) -> Switch a -> Switch b
map f (State a) = fromBool (f a)


switch : Switch a -> Switch b
switch x = map not x


on : Switch On
on = fromBool True


off : Switch Off
off = fromBool False


switchOn : Switch Off -> Switch On
switchOn = switch


switchOff : Switch On -> Switch Off
switchOff = switch


toBool : Switch a -> Bool
toBool (State a) = a
