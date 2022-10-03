module Main exposing (main)

import Browser exposing (Document)
import Browser.Navigation as Nav
import ImageViewer
import Page exposing (Page)
import Pages.Home
import Pages.Links
import Pages.WhereToGet
import Url exposing (Url)
import Url.Parser as UP


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- MODEL


type alias Model =
    { title : String
    , key : Nav.Key
    , route : Maybe Route
    , viewer : ImageViewer.Model
    }


type Route
    = Home
    | WhereToGet
    | Links


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { title = "Alpha Café"
      , key = key
      , route = UP.parse urlToRoute url
      , viewer = ImageViewer.init
      }
    , Cmd.none
    )


urlToRoute : UP.Parser (Route -> a) a
urlToRoute =
    UP.oneOf
        [ UP.map Home UP.top
        , UP.map WhereToGet <| UP.s "where_to_get"
        , UP.map Links <| UP.s "links"
        ]



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url
    | ImageViewerChanged ImageViewer.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChanged url ->
            ( { model | route = UP.parse urlToRoute url }, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        ImageViewerChanged viewerMsg ->
            ( { model | viewer = ImageViewer.update viewerMsg }, Cmd.none )



-- VIEW


view : Model -> Document Msg
view { route, viewer } =
    Page.toDocument
        { menu =
            [ { label = "Home", link = "/" }
            , { label = "Where to get YKK (& merch)", link = "/where_to_get" }
            , { label = "YKK communities & links", link = "/links" }
            ]
        , page =
            case Maybe.withDefault Home route of
                Home ->
                    Pages.Home.page viewer
                        |> Page.toParentMsg ImageViewerChanged

                WhereToGet ->
                    Pages.WhereToGet.page viewer
                        |> Page.toParentMsg ImageViewerChanged

                Links ->
                    Pages.Links.page
        }
