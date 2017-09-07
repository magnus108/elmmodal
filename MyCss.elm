module MyCss exposing (..)


import Css exposing (..)

import Css.Elements
  exposing
    ( html
    , body
    , img
    )

import Css.Namespace exposing (namespace)

import Colors exposing (..)


type CssClasses
  = MdContent
  | Flex
  | Flex2
  | Row
  | Column
  | Title
  | Pop
  | Padding1
  | Chip
  | MaterialIcon
  | BackgroundImage
  | Image



name : String
name = "bootstrap"


css : Stylesheet
css =
  (stylesheet << namespace name)
  [ html
    [ height (pct 100)
    , fontSize (px 16)
    ]
  , body
    [ displayFlex
    , margin zero
    , height (pct 100)
    ]
  , class MdContent
    [ flex (int 8)
    ]
  , class Flex
    [ flex (int 1)
    ]
  , class Flex2
    [ flex (int 1)
    , flexBasis ( Css.rem 10)
    ]
  , class Row
    [ displayFlex
    , flexFlow2 wrap row
    ]
  , class Column
    [ displayFlex
    , flexFlow2 noWrap column
    ]
  , class Title
    [ color primaryIconColor
    , backgroundColor primaryDarkColor
    , fontSize (Css.rem 1.5)
    , padding2 (Css.rem 0.7) (Css.rem 1)
    ]
  , class Pop
    [ position fixed
    , bottom (Css.rem 1)
    , right (Css.rem 1)
    , maxWidth (Css.rem 30)
    , primaryBoxShadow
    ]
  , class Padding1
    [ padding2 (Css.rem 0.7) (Css.rem 1)
    ]
  , class Chip
    [ backgroundColor primaryDarkColor
    , fontSize (Css.rem 1.5)
    , lineHeight (Css.rem 1.7)
    ]
  , class MaterialIcon
    [ fontFamilies [(qt "Material Icons")] --should use svg instead
    , fontStyle normal
    , display inlineBlock
    , color primaryIconColor
    , cursor pointer
    ]
  , class Image
    [ maxWidth (pct 100)
    , display block
    , minWidth (Css.rem 11)
    ]
  , class BackgroundImage
    [ position fixed
    , top (pct -50)
    , left (pct -50)
    , width (pct 200)
    , height (pct 200)
    , zIndex (int -1)
    , children
      [ img
        [  position absolute
        , top zero
        , left zero
        , right zero
        , bottom zero
        , margin auto
        , minWidth (pct 50)
        , minHeight (pct 50)
        ]
      ]
    ]
  ]
