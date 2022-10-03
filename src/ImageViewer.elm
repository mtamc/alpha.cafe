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
import Html exposing (Html, div, text)
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


{-| This function assumes the provided folder has:

  - a `.jpg` fullsize still
  - a `_thumb.mp4` small version
  - a `_thumb.webm` small version
  - a `.mp4` full video
  - a `.webm` full video

This weird setup originates from when this site was just HTML & CSS.
I forgot why I originally provided both an mp4 and webm fallback exactly;
something to do with a codec with lighter filesizes only working
on certain browsers.

-}
videoThumb : Model -> { folder : String, name : String, classes : String } -> Html Msg
videoThumb model { folder, name, classes } =
    let
        file ext =
            path folder name ext
    in
    togglableFigure model name classes <|
        [ div [ HA.class "thumbnail" ]
            [ thumbVid (file "_thumb.mp4") (file "_thumb.webm")
            , Components.loadingAnim
            ]
        , Html.viewIf (model == DisplayingMedia name) <|
            div [ HA.class "fullsize visible" ]
                [ fullVid (file ".mp4") (file ".webm") (Just (file ".jpg")) ]
        ]


{-| This function assumes the provided folder has:

  - a `.mp4` full video
  - a `.webm` full video

This weird setup originates from when this site was just HTML & CSS.
I forgot why I originally provided both an mp4 and webm fallback exactly;
something to do with a codec with lighter filesizes only working
on certain browsers.

-}
videoThumbOnlyOneSize : Model -> { folder : String, name : String, classes : String } -> Html Msg
videoThumbOnlyOneSize model { folder, name, classes } =
    let
        file ext =
            path folder name ext
    in
    togglableFigure model name classes <|
        [ div [ HA.class "thumbnail" ]
            [ thumbVid (file ".mp4") (file ".webm")
            , Components.loadingAnim
            ]
        , Html.viewIf (model == DisplayingMedia name) <|
            div [ HA.class "fullsize visible" ]
                [ fullVid (file ".mp4") (file ".webm") Nothing ]
        ]


{-| This function assumes the provided folder has:

  - a `.{ext}` full image
  - a `_thumb.{ext}`

This weird setup originates from when this site was just HTML & CSS.

-}
imgThumb :
    Model
    ->
        { folder : String
        , name : String
        , ext : String
        , altName : String
        , classes : String
        }
    -> Html Msg
imgThumb model { folder, name, ext, altName, classes } =
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
        , text "Your browser does not support the video tag."
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
        , text "Your browser does not support the video tag."
        ]
