module MyCss exposing (..)


import Css exposing (..)
import Css.Media as Media

import Css.Elements
  exposing
    ( img
    )

import Css.Namespace exposing (namespace)

import Colors exposing (..)


type CssClasses
  = MdContent
  | Dimension
  | SubmitButton
  | MdText
  | MdForm
  | Flex
  | Flex2
  | Row
  | Column
  | Title
  | Pop
  | Padding1
  | MaxZero
  | MaxZero2
  | MaterialIcon
  | OneTwo



name : String
name = "bootstrap"


css : Stylesheet
css =
  (stylesheet << namespace name)
  [ class MdContent
    [ flex (int 8)
    , maxWidth (Css.rem 45)
    ]
  , class Flex
    [ flex (int 1)
    ]
  , class Flex2
    [ flex (int 2)
    ]
  , class Dimension
    [ Media.withMedia
      [ Media.only Media.screen [ Media.maxWidth (px 800) ] ]
      [ display none ]
    ]
  , class OneTwo
    [ children
      [ everything
        [ firstChild
          [ flex (int 1) ]
        , lastChild
          [ minWidth (Css.rem 16)
          , flex (int 2)
          ]
        ]
      ]
    ]
  , class Row
    [ displayFlex
    , flexFlow2 wrap row
    ]
  , class SubmitButton
    [ backgroundColor primaryAccentColor
    , color primaryIconColor
    , border zero
    , flex (int 1)
    , padding (px 10)
    , margin (px 5)
    , primaryBoxShadow
    , hover
      [ backgroundColor secondaryAccentColor
      ]
    , focus
      [ outline none
      ]
    ]
  , class Column
    [ displayFlex
    , flexFlow2 noWrap column
    ]
  , class Title
    [ color primaryIconColor
    , backgroundColor primaryDarkColor
    , fontSize (Css.rem 1)
    , padding2 (Css.rem 0.4) (Css.rem 1)
    ]
  , class Pop
    [ position fixed
    , bottom (Css.pct 2)
    , right (Css.pct 2)
    , maxWidth (Css.pct 96)
    , primaryBoxShadow
    ]
  , class Padding1
    [ padding2 (Css.rem 0.4) (Css.rem 0.6)
    ]
  , class MaxZero
    [ backgroundColor primaryDarkColor
    , alignItems center
    , children
      [ everything
        [ firstChild
          [ flex (int 1)
          , Media.withMedia
            [ Media.only Media.screen [ Media.maxWidth (px 800) ] ]
            [ display none ]
          ]
        ]
      ]
    ]
  , class MaxZero2
    [ backgroundColor primaryDarkColor
    , alignItems center
    , children
      [ everything
        [ firstChild
          [ flex (int 1) ]
        ]
      ]
    ]
  , class MaterialIcon
    [ fontFamilies [(qt "Material Icons")] --should use svg instead
    , fontStyle normal
    , fontSize (Css.rem 1.4)
    , display inlineBlock
    , color primaryIconColor
    , backgroundColor primaryDarkColor
    , border zero
    , outline zero
    , cursor pointer
    , disabled
      [ cursor notAllowed ]
    ]
  , class MdForm
    [ displayFlex
    , flexWrap wrap
    ]
  , class MdText
    [ outline none
    , flex (int 6)
    , margin4 (px 8) (px 32) (px 8) (px 0)
    , padding2 (px 8) (px 2)
    , fontSize (px 16)
    , display block
    , border zero
    , borderBottom3 (px 1) solid (rgba 0 0 0 0.12)
    , minWidth (Css.rem 10)
    , focus
      [ outline none
      , borderBottom3 (px 1) solid secondaryAccentColor
      ]
    ]
  ]
