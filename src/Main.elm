module Main exposing (main)

import Browser exposing (Document)
import Html exposing (..)
import Html.Attributes exposing (..)
import Browser.Navigation as Nav
import Url exposing (Url)
import Url.Parser exposing ((</>))
import Content exposing (viewHeader, Status, Msg)
import Home
import WhereToGet
import Links


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


type alias TitleAndView =
    { pageFunction : Status -> Html Content.Msg
    , title : String
    }


view : Model -> Document Msg
view model =
    let
        {pageFunction, title} =
            case extractRoute model.route of
                "where_to_get" ->
                    TitleAndView WhereToGet.view "Where to read Yokohama Kaidashi Kikou and buy its merch? - Alpha Café"

                "links" ->
                    TitleAndView Links.view "YKK-related links - Alpha Café"

                _ ->
                    TitleAndView Home.view "Alpha Café, everything about YKK!"
    in
    { title = title
    , body =
        [ a [ id "top" ] []
        , viewHeader
        , Html.map ContentMsg (pageFunction model.content.status)
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