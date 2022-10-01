module Components exposing
    ( ArticleSection
    , PageData
    , blockquote
    , loadingAnim
    , pageFooter
    , pageHeader
    , pageMain
    , pageSection
    )

import Html exposing (Html)
import Html.Attributes as HA
import Utils


type alias PageData msg =
    { windowTitle : String
    , h1Text : String
    , view : List (Html msg)
    }


type alias ArticleSection msg =
    { title : String
    , htmlId : String
    , content : List (Html msg)
    }


loadingAnim : Html msg
loadingAnim =
    Html.div [ HA.class "loading_ring" ]
        [ Html.div [] [], Html.div [] [], Html.div [] [], Html.div [] [] ]


blockquote : String -> String -> Html msg
blockquote signature content =
    Html.blockquote []
        [ Utils.md content
        , Html.footer [] [ Utils.md ("— " ++ signature) ]
        ]


pageHeader : Html msg
pageHeader =
    Html.header []
        [ Html.a [ HA.id "top" ] []
        , musicButton
        , siteMenu
        ]


pageMain : String -> List (Html msg) -> Html msg
pageMain mainTitle children =
    Html.main_ []
        (Html.h1 [] [ Html.text mainTitle ]
            :: children
        )


pageSection : ArticleSection msg -> Html msg
pageSection data =
    Html.section []
        (heading data.title data.htmlId
            :: data.content
        )


pageFooter : Html msg
pageFooter =
    Html.footer []
        [ Html.p []
            [ Html.a [ HA.href "#top", HA.target "_self" ]
                [ Html.text "Jump to top" ]
            ]
        ]



-- PRIVATE


musicButton : Html msg
musicButton =
    let
        btn =
            Html.span [ HA.class "song_title" ]
                [ Html.div [ HA.id "header_play_button" ] []
                , Html.text "BGM"
                ]

        audioTag =
            Html.audio
                [ HA.id "ost"
                , HA.class "audioplay-player"
                , HA.preload "none"
                ]
                [ Html.source [ HA.src "./ykk_ost.mp3" ] []
                , Html.text "Your browser doesn't support audio element."
                ]
    in
    Html.div [ HA.id "music_player" ]
        [ btn
        , audioTag
        ]


siteMenu : Html msg
siteMenu =
    Html.nav []
        [ Utils.link "Home" "/"
        , Utils.link "Where to get YKK (& merch)" "/where_to_get"
        , Utils.link "YKK communities & links" "/links"
        ]


heading : String -> String -> Html msg
heading title htmlId =
    Html.a
        [ HA.href ("#" ++ htmlId)
        , HA.class "heading"
        , HA.target "_self" -- prevents Elm from hijacking URL anchor
        ]
        [ Html.h2
            [ HA.id htmlId ]
            [ Html.text title ]
        ]
