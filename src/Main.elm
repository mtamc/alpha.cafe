module Main exposing (main)

import Browser exposing (Document)
import Browser.Navigation as Nav
import ImageViewer
import Page exposing (Page)
import Pages.Home
import Pages.Links
import Pages.WhereToGet
import Url
import Utils


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- MODEL


type alias Model =
    { title : String
    , key : Nav.Key
    , route : String
    , viewer : ImageViewer.Model
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { title = "Alpha Café"
      , key = key
      , route = Utils.parseUrl url
      , viewer = ImageViewer.init
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | ImageViewerChanged ImageViewer.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChanged url ->
            ( { model | route = Utils.parseUrl url }
            , Cmd.none
            )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Nav.pushUrl model.key (Url.toString url)
                    )

                Browser.External href ->
                    ( model
                    , Nav.load href
                    )

        ImageViewerChanged viewerMsg ->
            ( { model | viewer = ImageViewer.update viewerMsg }
            , Cmd.none
            )



-- VIEW


view : Model -> Document Msg
view model =
    Page.toDocument
        { menu =
            [ { label = "Home", link = "/" }
            , { label = "Where to get YKK (& merch)", link = "/where_to_get" }
            , { label = "YKK communities & links", link = "/links" }
            ]
        , page =
            case model.route of
                "where_to_get" ->
                    Pages.WhereToGet.page model.viewer
                        |> Page.toParentMsg ImageViewerChanged

                "links" ->
                    Pages.Links.page

                _ ->
                    Pages.Home.page model.viewer
                        |> Page.toParentMsg ImageViewerChanged
        }
