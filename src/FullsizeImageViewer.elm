module FullsizeImageViewer exposing
    ( Model
    , Msg
    , imgThumb
    , init
    , update
    , videoThumb
    , videoThumbOnlyOneSize
    )

import Components as C
import Helpers as Hlp
import Html as H exposing (Html)
import Html.Attributes as HA
import Html.Events as HE
import Html.Extra as H
import Json.Encode as JE



-- MODEL


type Model
    = NotDisplayingMedia
    | DisplayingMedia String


type Msg
    = MediaCleared
    | MediaOpened String


init : Model
init =
    NotDisplayingMedia



-- UPDATE


update : Msg -> Model
update msg =
    case msg of
        MediaCleared ->
            NotDisplayingMedia

        MediaOpened name ->
            DisplayingMedia name



-- VIEW


videoThumb : Model -> String -> String -> String -> Html Msg
videoThumb model folder name classes =
    let
        file ext =
            path folder name ext
    in
    togglableFigure model name classes <|
        [ H.div [ HA.class "thumbnail" ]
            [ thumbVid
                (file "_thumb.mp4")
                (file "_thumb.webm")
            , C.loadingAnim
            ]
        , H.viewIf (model == DisplayingMedia name) <|
            H.div [ HA.class "fullsize visible" ]
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
        [ H.div [ HA.class "thumbnail" ]
            [ thumbVid
                (file ".mp4")
                (file ".webm")
            , C.loadingAnim
            ]
        , H.viewIf (model == DisplayingMedia name) <|
            H.div [ HA.class "fullsize visible" ]
                [ fullVid
                    (file ".mp4")
                    (file ".webm")
                    Nothing
                ]
        ]


imgThumb : Model -> String -> String -> String -> String -> String -> Html Msg
imgThumb model folder name ext altName classes =
    togglableFigure model name classes <|
        [ H.div [ HA.class "thumbnail" ]
            [ Hlp.lazyImg (path folder name ("_thumb." ++ ext)) altName
            , C.loadingAnim
            ]
        , H.viewIf (model == DisplayingMedia name) <|
            H.div [ HA.class "fullsize visible" ]
                [ Hlp.lazyImg (path folder name ext) altName ]
        ]



-- PRIVATE


togglableFigure : Model -> String -> String -> List (Html Msg) -> Html Msg
togglableFigure model name classes children =
    let
        clickAction =
            if model == DisplayingMedia name then
                MediaCleared

            else
                MediaOpened name
    in
    H.figure
        [ HA.class ("thumb_enlarger " ++ classes)
        , HE.onClick clickAction
        ]
        children


path : String -> String -> String -> String
path folder name ext =
    "./" ++ folder ++ "/" ++ name ++ ext


thumbVid : String -> String -> Html msg
thumbVid srcMp4 srcWebm =
    H.video
        [ HA.property "loop" (JE.bool True)
        , HA.attribute "playsinline" ""
        , HA.autoplay True
        , HA.attribute "muted" ""
        ]
        [ H.source [ HA.src srcMp4, HA.type_ "video/mp4" ] []
        , H.source [ HA.src srcWebm, HA.type_ "video/webm" ] []
        , H.text "Your browser does not support the video tag."
        ]


fullVid : String -> String -> Maybe String -> Html msg
fullVid srcMp4 srcWebm vidPoster =
    H.video
        [ HA.property "loop" (JE.bool True)
        , HA.controls True
        , HA.poster (Maybe.withDefault "" vidPoster)
        ]
        [ H.source [ HA.src srcMp4, HA.type_ "video/mp4" ] []
        , H.source [ HA.src srcWebm, HA.type_ "video/webm" ] []
        , H.text "Your browser does not support the video tag."
        ]
