module Main exposing (main)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Content exposing (Msg, Status, viewHeader)
import Home
import Html exposing (..)
import Html.Attributes exposing (..)
import Links
import Url exposing (Url)
import Url.Parser exposing ((</>))
import WhereToGet



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
    , route : Maybe String
    , content : Content.Model
    }


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | ContentMsg Content.Msg


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model "Alpha Café" key (parseUrl url) { status = Content.init }
    , Cmd.none
    )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChanged url ->
            ( { model | route = parseUrl url }, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        ContentMsg contentMsg ->
            ( { model | content = Content.update contentMsg model.content }
            , Cmd.none
            )



-- VIEW


type alias ViewAndTitle =
    { viewPage : Status -> Html Content.Msg
    , title : String
    }


view : Model -> Document Msg
view model =
    let
        { viewPage, title } =
            case extractRoute model.route of
                "where_to_get" ->
                    ViewAndTitle WhereToGet.view "Where to read Yokohama Kaidashi Kikou and buy its merch? - Alpha Café"

                "links" ->
                    ViewAndTitle Links.view "YKK-related links - Alpha Café"

                _ ->
                    ViewAndTitle Home.view "Alpha Café, everything about YKK!"
    in
    { title = title
    , body =
        [ a [ id "top" ] []
        , viewHeader
        , viewPage model.content.status |> Html.map ContentMsg
        , footer []
            [ p [] [ a [ href "#top", target "_self" ] [ text "Jump to top" ] ] ]
        ]
    }



-- HELPERS


extractRoute : Maybe String -> String
extractRoute maybeRoute =
    case maybeRoute of
        Just route ->
            route

        Nothing ->
            ""


parseUrl : Url -> Maybe String
parseUrl =
    Url.Parser.parse Url.Parser.string
