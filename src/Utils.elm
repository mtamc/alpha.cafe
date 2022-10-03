module Utils exposing
    ( lazyImg
    , liLink
    , lineBreak
    , link
    , md
    , nestedLi
    )

import Html exposing (Html, br, li, p, text, ul)
import Html.Attributes as HA
import Markdown.Parser as MD
import Markdown.Renderer as MDR
import Result.Extra as Result


md : String -> Html msg
md markdownBody =
    markdownBody
        |> mdParser
        |> List.head
        |> Maybe.withDefault (p [] [])


nestedLi : List (Html msg) -> Html msg
nestedLi content =
    ul []
        [ li [] content ]


link : String -> String -> Html msg
link displayedText url =
    Html.a [ HA.href url ] [ text displayedText ]


liLink : String -> String -> Html msg
liLink displayedText url =
    li [] [ link displayedText url ]


lineBreak : Html msg
lineBreak =
    br [] []


lazyImg : String -> String -> Html msg
lazyImg source altName =
    Html.img
        [ HA.src source
        , HA.alt altName
        , HA.attribute "importance" "low"
        , HA.attribute "loading" "lazy"
        ]
        []



-- PRIVATE


mdParser : String -> List (Html msg)
mdParser markdownBody =
    markdownBody
        |> MD.parse
        |> Result.mapError (List.map MD.deadEndToString >> String.join "\n")
        |> Result.andThen (MDR.render MDR.defaultHtmlRenderer)
        |> Result.extract (\errs -> [ text errs ])
