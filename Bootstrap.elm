module Bootstrap
  exposing
  ( mdColumn
  , mdChip
  , flex
  , flex2
  , mdRow
  , mdPop
  , mdContent
  , mdTitle
  , padding1
  , mdIcon
  , mdBackgroundImage
  , mdInput
  , mdImage
  , mdForm
  , mdText
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


mdIcon : List (Html msg) -> Html msg
mdIcon =
  i [ class [ MaterialIcon, Padding1 ] ]


mdChip : List (Html msg) -> Html msg
mdChip =
  div [ class [ Row, Chip ] ]


padding1 : List (Html msg) -> Html msg
padding1 =
  div [ class [ Padding1 ] ]


mdImage : String -> Html msg
mdImage x =
  img [ src x, class [ Image ] ] []


mdBackgroundImage : String -> Html msg
mdBackgroundImage x =
  div [ class [ BackgroundImage ] ] [ mdImage x ]


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


mdTitle : List (Html msg) -> Html msg
mdTitle =
  div [ class [ Title ] ]


mdContent : List (Html msg) -> Html msg
mdContent =
  div [ class [ MdContent ] ]


mdPop : List (Html msg) -> Html msg
mdPop =
  div [ class [ Pop ] ]


mdForm : List (Attribute msg) -> List (Html msg) -> Html msg
mdForm attr body =
  form ( attr ++ [ class [ MdForm ] ] ) body


mdInput : List (Attribute msg) -> List (Html msg) -> Html msg
mdInput attr body =
  input ( attr ++ [ class [ SubmitButton ] ] ) body


mdText : List (Attribute msg) -> List (Html msg) -> Html msg
mdText attr body =
  input ( attr ++ [ class [ MdText ] ] ) body
