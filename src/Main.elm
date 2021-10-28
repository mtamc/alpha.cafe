module Main exposing (main)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Components as C
import FullsizeImageViewer as V
import Helpers as Hlp
import Html
import Pages.Home
import Pages.Links
import Pages.WhereToGet
import Url



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
    , imageViewer : V.Model
    }


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | ImageViewerUpdated V.Msg


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { title = "Alpha Café"
      , key = key
      , route = Hlp.parseUrl url
      , imageViewer = V.init
      }
    , Cmd.none
    )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChanged url ->
            ( { model | route = Hlp.parseUrl url }
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

        ImageViewerUpdated viewerMsg ->
            ( { model | imageViewer = V.update viewerMsg }
            , Cmd.none
            )



-- VIEW


routeToPage : String -> C.PageData V.Model V.Msg
routeToPage route =
    case route of
        "where_to_get" ->
            Pages.WhereToGet.page

        "links" ->
            Pages.Links.page

        _ ->
            Pages.Home.page


view : Model -> Document Msg
view model =
    let
        page =
            routeToPage model.route
    in
    { title = page.windowTitle
    , body =
        [ C.pageHeader
        , C.pageMain page.h1Text (page.view model.imageViewer)
            |> Html.map ImageViewerUpdated
        , C.pageFooter
        ]
    }
