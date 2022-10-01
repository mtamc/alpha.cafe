module Main exposing (main)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Components
import Html
import ImageViewer
import Pages.Home
import Pages.Links
import Pages.WhereToGet
import Url
import Utils



-- MAIN


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
    , imageViewer : ImageViewer.Model
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { title = "Alpha Café"
      , key = key
      , route = Utils.parseUrl url
      , imageViewer = ImageViewer.init
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | ImageViewerMsg ImageViewer.Msg


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

        ImageViewerMsg viewerMsg ->
            ( { model | imageViewer = ImageViewer.update viewerMsg }
            , Cmd.none
            )



-- VIEW


routeToPage : String -> ImageViewer.Model -> Components.PageData ImageViewer.Msg
routeToPage route viewerStatus =
    case route of
        "where_to_get" ->
            Pages.WhereToGet.page viewerStatus

        "links" ->
            Pages.Links.page

        _ ->
            Pages.Home.page viewerStatus


view : Model -> Document Msg
view model =
    let
        page =
            routeToPage model.route model.imageViewer
    in
    { title = page.windowTitle
    , body =
        [ Components.pageHeader
        , Components.pageMain page.h1Text page.view |> Html.map ImageViewerMsg
        , Components.pageFooter
        ]
    }
