module Colors exposing (..)


import Css exposing (..)


primaryBoxShadow : Mixin
primaryBoxShadow =
  boxShadow5 zero (px 2) (px 5) zero (rgba 0 0 0 0.26)


primaryDarkColor : Color
primaryDarkColor =
  hex "00954a"


primaryColor : Color
primaryColor =
  hex "673ab7"


primaryLightColor : Color
primaryLightColor =
  hex "d1c4e9"


primaryAccentColor : Color
primaryAccentColor =
  hex "ff4081"


primaryIconColor : Color
primaryIconColor =
  hex "ffffff"


primaryTextColor : Color
primaryTextColor =
  hex "212121"


secondaryTextColor : Color
secondaryTextColor =
  hex "757575"


dividerColor : Color
dividerColor =
  hex "bdbdbd"
