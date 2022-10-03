module Page exposing (MenuItem, Page, toDocument, toParentMsg)

import Browser exposing (Document)
import Html exposing (Html, div, h1, p, span, text)
import Html.Attributes as HA
import Utils


type alias Page msg =
    { windowTitle : String
    , h1Text : String
    , content : List (Html msg)
    }


type alias MenuItem =
    { label : String
    , link : String
    }


toParentMsg : (msg1 -> msg2) -> Page msg1 -> Page msg2
toParentMsg parentMsg page =
    { windowTitle = page.windowTitle
    , h1Text = page.h1Text
    , content = List.map (Html.map parentMsg) page.content
    }


toDocument : { menu : List MenuItem, page : Page msg } -> Document msg
toDocument { menu, page } =
    { title = page.windowTitle
    , body =
        [ pageHeader menu
        , pageMain page
        , pageFooter
        ]
    }



-- PRIVATE


pageHeader : List MenuItem -> Html msg
pageHeader menu =
    Html.header []
        [ Html.a [ HA.id "top" ] []
        , musicButton
        , siteMenu menu
        ]


siteMenu : List MenuItem -> Html msg
siteMenu =
    Html.nav [] << List.map menuItemToLink


menuItemToLink : MenuItem -> Html msg
menuItemToLink { label, link } =
    Utils.link label link


pageMain : Page msg -> Html msg
pageMain { h1Text, content } =
    Html.main_ [] <|
        h1 [] [ text h1Text ]
            :: content


pageFooter : Html msg
pageFooter =
    Html.footer []
        [ p []
            [ Html.a [ HA.href "#top", HA.target "_self" ]
                [ text "Jump to top" ]
            ]
        ]


musicButton : Html msg
musicButton =
    let
        btn =
            span [ HA.class "song_title" ]
                [ div [ HA.id "header_play_button" ] []
                , text "BGM"
                ]

        audioTag =
            Html.audio
                [ HA.id "ost"
                , HA.class "audioplay-player"
                , HA.preload "none"
                ]
                [ Html.source [ HA.src "./ykk_ost.mp3" ] []
                , text "Your browser doesn't support audio element."
                ]
    in
    div [ HA.id "music_player" ]
        [ btn
        , audioTag
        ]
