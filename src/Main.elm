module Main exposing (main)

-- Trying to recreate
-- https://dribbble.com/shots/5528842-Rainbow-Messenger-App

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)


colors =
    { primaryText = rgb255 0xFF 0xFD 0xFF
    , background = rgb255 0x21 0x1C 0x2E
    , highlightBackground = rgb255 0x30 0x29 0x45
    , accent1 = rgb255 0xFF 0x98 0x8D
    }


type alias Model =
    { viewport :
        { width : Int
        , height : Int
        }
    , featured : List Contact
    , groupedContacts :
        List ( String, List Contact )
    }


type alias Contact =
    { name : String
    , slogan : String
    , lastMessage : String
    }


debugModel : Model
debugModel =
    { viewport =
        { width = 360 * 4
        , height = 740 * 4
        }
    , featured =
        [ { name = "Polly Simon"
          , slogan = "Why Las Vegas Hotel Rooms For You"
          , lastMessage = "18:00"
          }
        , { name = "Barry Spencer"
          , slogan = "Coventry City Guide Including Coventry City"
          , lastMessage = "18:00"
          }
        , { name = "Leroy Willis"
          , slogan = "Mother Earth Hostel of Our Travels"
          , lastMessage = "18:00"
          }
        ]
    , groupedContacts =
        [ ( "Work"
          , [ { name = "Terry Butler"
              , slogan = "Addition When Gambling Becomes A Problem"
              , lastMessage = "18:00"
              }
            , { name = "Caleb Munoz"
              , slogan = "Addition When Gambling Becomes A Problem"
              , lastMessage = "18:00"
              }
            ]
          )
        , ( "Family"
          , [ { name = "Ollie Butler"
              , slogan = "Addition When Gambling Becomes A Problem"
              , lastMessage = "18:00"
              }
            , { name = "Agnes Munoz"
              , slogan = "Addition When Gambling Becomes A Problem"
              , lastMessage = "18:00"
              }
            ]
          )
        ]
    }


type alias Fonts =
    { main : Int
    , secondary : Int
    , tinyHighlight : Int
    }


main : Html msg
main =
    view debugModel


view : Model -> Html msg
view model =
    let
        fontSizes =
            { main = model.viewport.width // 100
            , secondary = model.viewport.width // 110
            , tinyHighlight = model.viewport.width // 120

            -- TODO: consider Element.modular when adding additional sizes
            }
    in
    layout
        [ Font.color colors.primaryText
        , Background.color colors.background
        , Font.size fontSizes.main
        ]
    <|
        column
            []
            [ -- header
              row []
                [ appMenuButton
                , column []
                    [ text "TODO: photo"
                    , text "Herbert Patrick"
                    ]
                , notifications
                ]
            , -- featuredContacts
              row
                [ padding 10
                , spacing 10
                ]
                (List.map (featuredCard fontSizes) model.featured)
            , column [] <|
                List.map
                    (\( sectionName, contacts ) ->
                        contactSection sectionName contacts
                    )
                    model.groupedContacts
            ]


appMenuButton =
    text "[appMenu]"


notifications =
    text "[notifications]"


featuredCard : Fonts -> Contact -> Element msg
featuredCard fonts contact =
    column
        [ width (px 130)
        , height (px 150)
        , behindContent
            (column [ height fill, width fill ]
                [ el
                    [ height (px 55)
                    , width fill
                    , Background.color colors.accent1
                    , roundTop 10
                    ]
                    none
                , el [] none
                ]
            )
        , Background.color colors.highlightBackground
        , Border.rounded 10
        , paddingEach { top = 30, bottom = 0, left = 0, right = 0 }
        , spacing 5

        --, inFront popupButtons -- an experiment
        ]
        [ el
            [ width (px 50)
            , height (px 50)
            , Background.color (rgb 1 1 1)
            , centerX
            ]
            (text "photo")
        , el
            [ centerX
            ]
            (text contact.name)
        , paragraph
            [ Font.size fonts.tinyHighlight
            , centerX
            , width fill
            , spacing 2
            , Font.center
            , padding 5
            , Font.color colors.accent1
            ]
            [ text contact.slogan ]
        ]


popupButtons =
    column
        [ alignBottom
        , centerX
        , spacing 10
        , width fill
        , Background.gradient
            { angle = 0
            , steps =
                [ colors.background
                , rgba 0 0 0 0
                ]
            }
        ]
        [ Input.button
            [ Background.color (rgb 1 1.0 0.5)
            , centerX
            ]
            { onPress = Nothing
            , label = text "B"
            }
        , Input.button
            [ Background.color (rgb 0.502 1 0.702)
            , centerX
            ]
            { onPress = Nothing
            , label = text "B"
            }
        , Input.button
            [ Background.color (rgb 0.851 0.502 1)
            , centerX
            ]
            { onPress = Nothing
            , label = text "B"
            }
        ]


contactSection : String -> List Contact -> Element msg
contactSection sectionName contacts =
    column []
        [ row []
            [ text sectionName
            , nextPage
            ]
        , column []
            (List.map contactRow contacts)
        ]


contactRow : Contact -> Element msg
contactRow contact =
    row []
        [ text "photo"
        , column []
            [ row []
                [ text contact.name
                , text contact.lastMessage
                ]
            , text contact.slogan
            ]
        , nextPage
        ]


nextPage =
    text ">"


roundTop i =
    Border.roundEach
        { topLeft = i
        , topRight = i
        , bottomLeft = 0
        , bottomRight = 0
        }
