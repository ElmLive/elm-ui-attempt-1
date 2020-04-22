module Main exposing (main)

import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Html exposing (Html)


colors =
    { primaryText = rgb255 0xFF 0xFD 0xFF
    , background = rgb255 0x21 0x1C 0x2E
    }


main : Html msg
main =
    layout
        [ Font.color colors.primaryText
        , Background.color colors.background
        ]
    <|
        text "hi from elm-ui"
