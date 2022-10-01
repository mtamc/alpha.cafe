module ImageViewer exposing
    ( Model
    , Msg
    , imgThumb
    , init
    , update
    , videoThumb
    , videoThumbOnlyOneSize
    )

import Components
import Html exposing (Html, div)
import Html.Attributes as HA
import Html.Events as HE
import Html.Extra as Html
import Json.Encode as JE
import Utils



-- MODEL


type Model
    = NotDisplayingMedia
    | DisplayingMedia String


init : Model
init =
    NotDisplayingMedia



-- UPDATE


type Msg
    = MediaClosingRequested
    | MediaOpeningRequested String


update : Msg -> Model
update msg =
    case msg of
        MediaClosingRequested ->
            NotDisplayingMedia

        MediaOpeningRequested name ->
            DisplayingMedia name



-- VIEW


videoThumb : Model -> String -> String -> String -> Html Msg
videoThumb model folder name classes =
    let
        file ext =
            path folder name ext
    in
    togglableFigure model name classes <|
        [ div [ HA.class "thumbnail" ]
            [ thumbVid
                (file "_thumb.mp4")
                (file "_thumb.webm")
            , Components.loadingAnim
            ]
        , Html.viewIf (model == DisplayingMedia name) <|
            div [ HA.class "fullsize visible" ]
                [ fullVid
                    (file ".mp4")
                    (file ".webm")
                    (Just (file ".jpg"))
                ]
        ]


videoThumbOnlyOneSize : Model -> String -> String -> String -> Html Msg
videoThumbOnlyOneSize model folder name classes =
    let
        file ext =
            path folder name ext
    in
    togglableFigure model name classes <|
        [ div [ HA.class "thumbnail" ]
            [ thumbVid
                (file ".mp4")
                (file ".webm")
            , Components.loadingAnim
            ]
        , Html.viewIf (model == DisplayingMedia name) <|
            div [ HA.class "fullsize visible" ]
                [ fullVid
                    (file ".mp4")
                    (file ".webm")
                    Nothing
                ]
        ]


imgThumb : Model -> String -> String -> String -> String -> String -> Html Msg
imgThumb model folder name ext altName classes =
    togglableFigure model name classes <|
        [ div [ HA.class "thumbnail" ]
            [ Utils.lazyImg (path folder name ("_thumb." ++ ext)) altName
            , Components.loadingAnim
            ]
        , Html.viewIf (model == DisplayingMedia name) <|
            div [ HA.class "fullsize visible" ]
                [ Utils.lazyImg (path folder name ("." ++ ext)) altName ]
        ]



-- PRIVATE


togglableFigure : Model -> String -> String -> List (Html Msg) -> Html Msg
togglableFigure model name classes children =
    let
        clickMsg =
            if model == DisplayingMedia name then
                MediaClosingRequested

            else
                MediaOpeningRequested name
    in
    Html.figure
        [ HA.class ("thumb_enlarger " ++ classes)
        , HE.onClick clickMsg
        ]
        children


path : String -> String -> String -> String
path folder name ext =
    "./" ++ folder ++ "/" ++ name ++ ext


thumbVid : String -> String -> Html msg
thumbVid srcMp4 srcWebm =
    Html.video
        [ HA.property "loop" (JE.bool True)
        , HA.attribute "playsinline" ""
        , HA.autoplay True
        , HA.attribute "muted" ""
        ]
        [ Html.source [ HA.src srcMp4, HA.type_ "video/mp4" ] []
        , Html.source [ HA.src srcWebm, HA.type_ "video/webm" ] []
        , Html.text "Your browser does not support the video tag."
        ]


fullVid : String -> String -> Maybe String -> Html msg
fullVid srcMp4 srcWebm vidPoster =
    Html.video
        [ HA.property "loop" (JE.bool True)
        , HA.controls True
        , HA.poster (Maybe.withDefault "" vidPoster)
        ]
        [ Html.source [ HA.src srcMp4, HA.type_ "video/mp4" ] []
        , Html.source [ HA.src srcWebm, HA.type_ "video/webm" ] []
        , Html.text "Your browser does not support the video tag."
        ]
