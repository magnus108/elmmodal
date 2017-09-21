module Either
  exposing
    ( Either
    , left
    , right
    , map1
    , map2
    )


type Either a b
    = Left a
    | Right b


left : a -> Either a x
left = Left


right : b -> Either x b
right = Right


-- This is a simple library. Refactor this.
map1 : (a -> b) -> (c -> d) -> Either a c -> Either d b
map1 f g e =
  case e of
    Left a ->
      Right <| f a

    Right b ->
      Left <| g b


-- This is a simple library. Refactor this.
map2 : (a -> c) -> (b -> c) -> Either a b -> c
map2 f g e =
  case e of
    Left a -> f a

    Right b -> g b
