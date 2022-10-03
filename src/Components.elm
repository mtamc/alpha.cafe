module Components exposing
    ( blockquote
    , loadingAnim
    , section
    )

import Html exposing (Html, div, text)
import Html.Attributes as HA
import Utils


section : String -> { id : String } -> List (Html msg) -> Html msg
section title { id } content =
    Html.section [] <|
        heading title id
            :: content


loadingAnim : Html msg
loadingAnim =
    div [ HA.class "loading_ring" ]
        [ div [] [], div [] [], div [] [], div [] [] ]


blockquote : String -> String -> Html msg
blockquote signature content =
    Html.blockquote []
        [ Utils.md content
        , Html.footer [] [ Utils.md ("— " ++ signature) ]
        ]



-- PRIVATE


heading : String -> String -> Html msg
heading title htmlId =
    Html.a
        [ HA.href ("#" ++ htmlId)
        , HA.class "heading"
        , HA.target "_self" -- prevents Elm from hijacking URL anchor
        ]
        [ Html.h2 [ HA.id htmlId ] [ text title ] ]
