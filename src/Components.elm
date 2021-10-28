module Components exposing
    ( PageData
    , PageSection
    , blockquote
    , loadingAnim
    , pageFooter
    , pageHeader
    , pageMain
    , pageSection
    )

import Helpers as Hlp
import Html as H exposing (Html)
import Html.Attributes as HA


type alias PageData model msg =
    { windowTitle : String
    , h1Text : String
    , view : model -> List (Html msg)
    }


type alias PageSection msg =
    { title : String
    , htmlId : String
    , content : List (Html msg)
    }


loadingAnim : Html msg
loadingAnim =
    H.div [ HA.class "loading_ring" ]
        [ H.div [] [], H.div [] [], H.div [] [], H.div [] [] ]


blockquote : String -> String -> Html msg
blockquote signature content =
    H.blockquote []
        [ Hlp.md content
        , H.footer [] [ Hlp.md ("— " ++ signature) ]
        ]


pageHeader : Html msg
pageHeader =
    H.header []
        [ H.a [ HA.id "top" ] []
        , musicButton
        , siteMenu
        ]


pageMain : String -> List (Html msg) -> Html msg
pageMain mainTitle children =
    H.main_ []
        (H.h1 [] [ H.text mainTitle ]
            :: children
        )


pageSection : PageSection msg -> Html msg
pageSection data =
    H.section []
        (heading data.title data.htmlId
            :: data.content
        )


pageFooter : Html msg
pageFooter =
    H.footer []
        [ H.p []
            [ H.a [ HA.href "#top", HA.target "_self" ]
                [ H.text "Jump to top" ]
            ]
        ]



-- PRIVATE


musicButton : Html msg
musicButton =
    let
        btn =
            H.span [ HA.class "song_title" ]
                [ H.div [ HA.id "header_play_button" ] []
                , H.text "BGM"
                ]

        audioTag =
            H.audio
                [ HA.id "ost"
                , HA.class "audioplay-player"
                , HA.preload "none"
                ]
                [ H.source [ HA.src "./ykk_ost.mp3" ] []
                , H.text "Your browser doesn't support audio element."
                ]
    in
    H.div [ HA.id "music_player" ]
        [ btn
        , audioTag
        ]


siteMenu : Html msg
siteMenu =
    H.nav []
        [ Hlp.link "Home" "/"
        , Hlp.link "Where to get YKK (& merch)" "/where_to_get"
        , Hlp.link "YKK communities & links" "/links"
        ]


heading : String -> String -> Html msg
heading title htmlId =
    H.a
        [ HA.href ("#" ++ htmlId)
        , HA.class "heading"
        , HA.target "_self" -- prevents Elm from hijacking URL anchor
        ]
        [ H.h2
            [ HA.id htmlId ]
            [ H.text title ]
        ]
