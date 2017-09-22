module Either
  exposing
    ( Either
    , hidden
    , on
    , onOff
    , off
    , offOn
    , mini
    , map
    )


type Either a b c d e f
    = Hidden a
    | On b
    | OnOff c
    | Off d
    | OffOn e
    | Mini f


hidden : a -> Either a x1 x2 x3 x4 x5
hidden = Hidden


on : a -> Either x1 a x2 x3 x4 x5
on = On


onOff : a -> Either x1 x2 a x3 x4 x5
onOff = OnOff


off : a -> Either x1 x2 x3 a x4 x5
off = Off


offOn : a -> Either x1 x2 x3 x4 a x5
offOn = OffOn


mini : a -> Either x1 x2 x3 x4 x5 a
mini = Mini

-- This is a simple library. Refactor this.
--map1 : (a -> b) -> (c -> d) -> Either a c -> Either d b
--map1 f g e =
---  case e of
--    Left a ->
--      Right <| f a
--
--    Right b ->
--      Left <| g b


-- This is a simple library. Refactor this.
map : (a -> x) -> (b -> x) -> (c -> x) -> (d -> x) -> (e -> x) -> (f -> x)
  -> Either a b c d e f -> x
map f g h i j k x =
  case x of
    Hidden y -> f y

    On y -> g y

    OnOff y -> h y

    Off y -> i y

    OffOn y -> j y

    Mini y -> k y
