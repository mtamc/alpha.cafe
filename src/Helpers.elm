module Helpers exposing
    ( callWithArg
    , lazyImg
    , liLink
    , lineBreak
    , link
    , md
    , nestedLi
    , parseUrl
    )

import Html as H exposing (Html)
import Html.Attributes as HA
import Markdown.Parser as MD
import Markdown.Renderer as MDR
import Result.Extra as Result
import Url exposing (Url)
import Url.Parser


md : String -> Html msg
md markdownBody =
    markdownBody
        |> mdParser
        |> List.head
        |> Maybe.withDefault (H.p [] [])


nestedLi : List (Html msg) -> Html msg
nestedLi content =
    H.ul []
        [ H.li [] content ]


link : String -> String -> Html msg
link displayedText url =
    H.a [ HA.href url ] [ H.text displayedText ]


liLink : String -> String -> Html msg
liLink displayedText url =
    H.li [] [ link displayedText url ]


lineBreak : Html msg
lineBreak =
    H.br [] []


lazyImg : String -> String -> Html msg
lazyImg source altName =
    H.img
        [ HA.src source
        , HA.alt altName
        , HA.attribute "importance" "low"
        , HA.attribute "loading" "lazy"
        ]
        []


parseUrl : Url -> String
parseUrl url =
    url
        |> Url.Parser.parse Url.Parser.string
        |> Maybe.withDefault ""


callWithArg : a -> (a -> b) -> b
callWithArg arg fn =
    fn arg



-- PRIVATE


mdParser : String -> List (Html msg)
mdParser markdownBody =
    markdownBody
        |> MD.parse
        |> Result.mapError (List.map MD.deadEndToString >> String.join "\n")
        |> Result.andThen (MDR.render MDR.defaultHtmlRenderer)
        |> Result.extract (\errs -> [ H.text errs ])
