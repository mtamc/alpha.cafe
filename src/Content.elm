module Content exposing (update, viewHeader, viewPageMain, viewSection, viewVideoThumb, viewVideoThumbNoThumbFile, md, viewQuote, nestedLi, viewImageThumb, link, liLink, lineBreak, Status, Msg, Model, init)
import Markdown.Parser as MD
import Markdown.Renderer as MDRenderer
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Json.Encode



-- MODEL


type alias Model =
    { status : Status }


type Status
    = Browsing
    | ViewingMedia String


type Msg
    = ClearMedia
    | ViewMedia String


init : Status
init =
    Browsing



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        ClearMedia ->
            { model | status = Browsing }

        ViewMedia name ->
            { model | status = ViewingMedia name }



-- VIEW FUNCTIONS


viewLoading : Html msg
viewLoading =
    div [ class "loading_ring" ] [ div [] [], div [] [], div [] [], div [] [] ]


viewQuote : String -> String -> Html msg
viewQuote signature content =
    blockquote [] [ md content, footer [] [ md ("— " ++ signature) ] ]


viewSection : ( String, String ) -> List (Html msg) -> Html msg
viewSection title children =
    section [] (viewHeading (Tuple.first title) (Tuple.second title) :: children)


viewHeader : Html msg
viewHeader =
    header [] [ viewMusicButton, viewNav ]


viewMusicButton : Html msg
viewMusicButton =
    div [ id "music_player" ]
        [ span [ class "song_title" ]
            [ div [ id "header_play_button" ] []
            , text "BGM"
            ]
        , audio [ id "ost", class "audioplay-player", preload "none" ]
            [ source [ src "./ykk_ost.mp3" ] []
            , text "Your browser doesn't support audio element."
            ]
        ]


viewNav : Html msg
viewNav =
    nav []
        [ link "/" "Home"
        , link "/where_to_get" "Where to get YKK (& merch)"
        , link "/links" "YKK communities & links"
        ]


path : String -> String -> String -> String
path folder name ext =
    "./" ++ folder ++ "/" ++ name ++ ext
    

viewVideoThumb : Status -> String -> String -> String -> Html Msg
viewVideoThumb status folder name classes =
    let mp4Thumb   = path folder name "_thumb.mp4"
        webmThumb  = path folder name "_thumb.webm"
        mp4Full    = path folder name ".mp4"
        webmFull   = path folder name ".webm"
        vidPoster  = path folder name ".jpg"
    in
    viewTogglableFigure status name classes
        [ div [ class "thumbnail" ]
            [ viewThumbVid mp4Thumb webmThumb, viewLoading ]
        , htmlIf (status == ViewingMedia name) <|
            div [ class "fullsize visible" ]
                [ viewFullVid mp4Full webmFull vidPoster ]
        ]


viewVideoThumbNoThumbFile : Status -> String -> String -> String -> Html Msg
viewVideoThumbNoThumbFile status folder name classes =
    let mp4Full    = path folder name ".mp4"
        webmFull   = path folder name ".webm"
    in
    viewTogglableFigure status name classes
        [ div [ class "thumbnail" ]
            [ viewThumbVid mp4Full webmFull , viewLoading ]
        , htmlIf (status == ViewingMedia name) <|
            div [ class "fullsize visible" ]
                [ viewFullVid mp4Full webmFull "" ]
        ]


viewImageThumb : Status -> String -> String -> String -> String -> String -> Html Msg
viewImageThumb status folder name ext altName classes =
    viewTogglableFigure status name classes
        [ div [ class "thumbnail" ]
            [ viewLazyImg (path folder name ("_thumb."++ ext)) altName
            , viewLoading
            ]
        , htmlIf (status == ViewingMedia name) <|
            div [ class "fullsize visible" ]
                [ viewLazyImg (path folder name ext) altName ]
        ]


viewTogglableFigure : Status -> String -> String -> List (Html Msg) -> Html Msg
viewTogglableFigure status name classes children =
    let
        clickAction =
            if status == ViewingMedia name then ClearMedia else ViewMedia name
    in
    figure [ class ("thumb_enlarger " ++ classes), onClick clickAction ] children


viewLazyImg : String -> String -> Html msg
viewLazyImg source altName =
    img [ src source, alt altName, attribute "importance" "low", attribute "loading" "lazy" ] []


viewThumbVid : String -> String -> Html msg
viewThumbVid srcMp4 srcWebm =
    video [ property "loop" (Json.Encode.bool True), attribute "playsinline" "", autoplay True, attribute "muted" "" ]
        [ source [ src srcMp4, type_ "video/mp4" ] []
        , source [ src srcWebm, type_ "video/webm" ] []
        , text "Your browser does not support the video tag."
        ]


viewFullVid : String -> String -> String -> Html msg
viewFullVid srcMp4 srcWebm vidPoster =
    let thumb = if String.length vidPoster > 0 then [ poster vidPoster ] else []
    in
    video ([ property "loop" (Json.Encode.bool True), controls True ] ++ thumb)
        [ source [ src srcMp4, type_ "video/mp4" ] []
        , source [ src srcWebm, type_ "video/webm" ] []
        , text "Your browser does not support the video tag."
        ]


viewHeading : String -> String -> Html msg
viewHeading id_ title =
    a [ href ("#" ++ id_), class "heading", target "_self" ]
        [ h2 [ id id_ ] [ text title ] ]


viewPageMain : String -> List (Html msg) -> Html msg
viewPageMain mainTitle children =
    main_ [] (h1 [] [ text mainTitle ] :: children)


md : String -> Html msg
md markdownBody =
    case List.head (mdParser markdownBody) of
        Just parag -> parag
        Nothing    -> p [] []


nestedLi : List (Html msg) -> Html msg
nestedLi content =
    ul [] [ li [] content ]


mdParser : String -> List (Html msg)
mdParser markdownBody =
    case
        MD.parse markdownBody
            |> Result.mapError (List.map MD.deadEndToString >> String.join "\n")
            |> Result.andThen (MDRenderer.render MDRenderer.defaultHtmlRenderer)
    of
        Ok rendered -> rendered
        Err errors  -> [ text errors ]


htmlIf : Bool -> Html msg -> Html msg
htmlIf cond el =
    if cond then el else text ""



link : String -> String -> Html msg
link url displayedText =
    a [ href url ] [ text displayedText ]

liLink : String -> String -> Html msg
liLink url displayedText =
    li [] [ link url displayedText ]

lineBreak : Html msg
lineBreak =
    br [] []
