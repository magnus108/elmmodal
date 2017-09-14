module Bootstrap
  exposing
  ( mdColumn
  , flex
  , flex2
  , mdRow
  , mdPop
  , mdContent
  , mdTitle
  , padding1
  , mdIcon
  , mdInput
  , mdImage
  , mdForm
  , mdText
  , mdOneTwo
  , mdMaxZero
  )


import Html
  exposing
    ( Html
    , Attribute
    , div
    , form
    , i
    , img
    , input
    )


import Html.Attributes
  exposing
    ( src
    )


import Html.CssHelpers

import MyCss exposing (CssClasses(..))


{id, class, classList} =
  Html.CssHelpers.withNamespace MyCss.name



-- Kig gerne på det der layout modul.
-- bruger ikke attribtues.
mdOneTwo : List (Attribute msg) -> Html msg -> Html msg -> Html msg
mdOneTwo attributes one two =
  div [ class [ OneTwo, Row, Padding1, Flex ] ]
    [ one
    , two
    ]


mdMaxZero : List (Attribute msg) -> Html msg -> Html msg -> Html msg
mdMaxZero attributes max zero =
  div [ class [ MaxZero, Row ] ]
    [ max
    , zero
    ]

{-Bootstrap.mdRow
    [ Bootstrap.padding1
      [ Bootstrap.mdRow
        [ left
        , right
        ]
      ]
    ]
-}


mdIcon : List (Attribute msg) -> List (Html msg) -> Html msg
mdIcon attributes =
  i ( attributes ++ [ class [ MaterialIcon, Padding1 ] ] )




padding1 : List (Html msg) -> Html msg
padding1 =
  div [ class [ Padding1 ] ]


mdImage : List (Attribute msg) -> Html msg
mdImage attributes =
  div ( attributes ++ [ class [ Padding1, Dimension ] ] ) []



flex : List (Html msg) -> Html msg
flex =
  div [ class [ Flex ] ]


flex2 : List (Html msg) -> Html msg
flex2 =
  div [ class [ Flex2 ] ]


mdColumn : List (Html msg) -> Html msg
mdColumn =
  div [ class [ Column, Flex ] ]


mdRow : List (Html msg) -> Html msg
mdRow =
  div [ class [ Row, Flex ] ]


mdTitle : List (Attribute msg) -> List (Html msg) -> Html msg
mdTitle attributes =
  div ( attributes ++ [ class [ Title ] ] )


mdContent : List (Attribute msg) -> List (Html msg) -> Html msg
mdContent attributes =
  div ( attributes ++ [ class [ MdContent ] ] )


mdPop : List (Attribute msg) -> List (Html msg) -> Html msg
mdPop attr body =
  div ( attr ++ [ class [ Pop ] ] ) body


mdForm : List (Attribute msg) -> List (Html msg) -> Html msg
mdForm attr body =
  form ( attr ++ [ class [ MdForm ] ] ) body


mdInput : List (Attribute msg) -> Html msg
mdInput attr =
  input ( attr ++ [ class [ SubmitButton ] ] ) []


mdText : List (Attribute msg) -> Html msg
mdText attr =
  input ( attr ++ [ class [ MdText ] ] ) []
