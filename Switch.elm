module Switch
  exposing
    ( Switch
    , On
    , OnOff
    , Off
    , OffOn
    , Hidden
    , Mini
    , mini
    , hidden
    , off
    , switchOn
    , switchOff
    , switchingOff
    , switchingOn
    )


type On = On
type OnOff = OnOff
type Off = Off
type OffOn = OffOn
type Hidden = Hidden
type Mini = Mini

type Switch a = State


state : Switch a
state = State


switch : Switch a -> Switch b
switch _ = State


mini : Switch Mini
mini = State


on : Switch On
on = state


onOff : Switch OnOff
onOff = state


off : Switch Off
off = state


offOn : Switch OffOn
offOn = state


hidden : Switch Hidden
hidden = state


switchOn : Switch OffOn -> Switch On
switchOn = switch


switchOff : Switch On -> Switch Off
switchOff = switch


switchingOff : Switch On -> Switch OnOff
switchingOff = switch


switchingOn : Switch Off -> Switch OffOn
switchingOn = switch
