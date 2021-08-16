module Main exposing (main)

import Browser exposing (Document)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Markdown.Parser as MD
import Markdown.Renderer as MDRenderer
import Json.Encode
import Browser.Navigation as Nav
import Url exposing (Url)
import Url.Parser exposing ((</>))


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
    , status : Status
    , key : Nav.Key
    , route : Maybe String
    }


type Status
    = Browsing
    | ViewingMedia String


parseUrl : Url -> Maybe String
parseUrl =
    Url.Parser.parse Url.Parser.string


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model "Alpha Café" Browsing key (parseUrl url)
    , Cmd.none
    )



-- UPDATE


type Msg
    = ClearMedia
    | ViewMedia String
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClearMedia ->
            ( { model | status = Browsing }, Cmd.none )

        ViewMedia name ->
            ( { model | status = ViewingMedia name }, Cmd.none )

        UrlChanged url ->
            ( { model | route = parseUrl url }, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )



-- VIEW


type alias FunctionAndTitle =
    { pageFunction : Status -> Html Msg
    , title : String
    }


view : Model -> Document Msg
view model =
    let
        {pageFunction, title} =
            case extractRoute model.route of
                "where_to_get" ->
                    FunctionAndTitle viewWhereToGet "Where to read Yokohama Kaidashi Kikou and buy its merch? - Alpha Café"

                "links" ->
                    FunctionAndTitle viewLinks "YKK-related links - Alpha Café"

                _ ->
                    FunctionAndTitle viewHome "Alpha Café, everything about YKK!"
    in
    { title = title
    , body =
        [ a [ id "top" ] []
        , viewHeader
        , pageFunction model.status
        , footer []
            [ p [] [ a [ href "#top", target "_self" ] [ text "Jump to top" ] ] ]
        ]
    }


viewHome : Status -> Html Msg
viewHome status =
    viewPageMain "Everything about Yokohama Kaidashi Kikou!"
        [ viewSection ( "what_is_this_site", "What's this site?" )
            [ viewVideoThumb status "home" "illus1" ""
            , md "Alpha.cafe is an old school Yokohama Kaidashi Kikou fan page! Since YKK is a very nostalgic story with \"return to low-tech\" themes, perhaps I will pique your interest with this tribute to the world wide web before social media, and wink to platforms where the fandom once thrived!"
            , md "I hope to recreate the feeling of stumbling upon a hidden corner of the web, a little like finding Café Alpha deep in the country, up and running despite the lack of customers..."
            ]
        , viewSection ( "what_is_ykk", "What's Yokohama Kaidashi Kikou?" )
            [ viewVideoThumb status "home" "illus2" ""
            , md "**Yokohama Kaidashi Kikou**, or YKK for short, is [Hitoshi Ashinano](https://en.wikipedia.org/wiki/Hitoshi_Ashinano)'s best-known **manga series**! It ran from **1994 to 2006** in **seinen magazine Afternoon**, alongside series like Mushishi, BLAME!, and Vinland Saga. YKK's fanbase has had an association and strong overlap with **Aria**'s, although the latter is more famous!"
            , md "One translation for the title would be **\"Yokohama Shopping Log.\"**"
            , viewVideoThumb status "home" "illus3" "pull_me_up"
            , md "YKK was adapted into two **short 2-episode OVAs**, in 1998 and 2002-3. They adapt a tiny section of the story, but are both a treat for fans of the manga, as well as a good introduction for those not familiar with the series!"
            , md "**Choro Club**, who authored Aria's OST, is also behind the second YKK OVAs' music! Listen to *Café Alpha ~Main Theme~* by using the player at the top or [clicking here!]()"
            ]
        , viewSection ( "what_is_ykk_about", "What's YKK about?" )
            [ viewVideoThumbNoThumbFile status "home" "illus4" ""
            , md "YKK is a **post-apocalyptic slice of life** following the daily life and travels of android Alpha Hatsuseno. Humanity is in gradual decline, and **sea levels have risen submerging much of Japan** as we know it."
            , md "In this Japan that has already accepted the twilight of humanity, Alpha lives her life peacefully, **watching the passing of time** in the **last age of mankind.**"
            , viewVideoThumb status "home" "illus5" "pull_me_up"
            , md "She befriends characters like Ojisan, who runs a gas station with infrequent customers; Takahiro and Makki, children growing up in a dwindling society; or Kokone, an android courier who ponders upon the nature of the robots' existence."
            ]
        , viewSection ( "why_read_ykk", "Why should I read/watch YKK?" )
            [ viewVideoThumb status "home" "illus6" "right"
            , md "If you enjoy **art-driven series**, or if want to read something **unique**, with the potential to move you deeply, you should definitely check out YKK! It's a story full of emotions primarily told through art. The panels recreate not just the *look* of a beautiful country road, but the *feeling* of strolling through one, using ethereal landscapes at times backlit shadows, at times shrouded by haze. Some panels underline thoughtfulness and solitude by artfully using empty space. The unhurried narrative and art gradually build an overwhelming mood of **wistful yet serene solitude.**"
            , viewImageThumb status "home" "ykkpage" "jpg" "Page from YKK" "large left"
            , md "The OVAs' creators understood Ashinano's mastery of manga and the **subdued yet powerful atmosphere** he crafted with it. They recreated this unique story, where **every pause is made meaningful**, with their own mastery of animation."
            , viewQuote "Hitoshi Ashinano" "Contemporary anime is in constant movement. Despite that, Director Annou carefully internalized the impression of spaces, pauses, and elements like that. So I believe I am lucky to have him as director."
            , md "In these OVAs the high-contrast stylized landscapes become gorgeous paintings in slow shots, carefully framed to convey the beauty in mundane details. Coffee in the morning. The shadow of a passing cloud. Nature swaying in the wind."
            , viewImageThumb status "home" "colorpage" "png" "Page from YKK" "large right pull_me_up"
            , md "Ashinano's **economy of style** applies also to the series' story. Loss and mourning are implied. If I had to compare YKK with existing media, I'd offer [Japanese haiku](https://en.wikipedia.org/wiki/Haiku) and [Ernest Hemingway](https://en.wikipedia.org/wiki/Ernest_Hemingway) for their technique and their conveying of strong feelings in deceptively few and understated words."
            , md "Don't know where to find YKK? Check out the [Where to get](/where_to_get) page!"
            ]
        ]


viewWhereToGet : Status -> Html Msg
viewWhereToGet status =
    viewPageMain "Finding Yokohama Kaidashi Kikou and its merchandise"
        [ viewSection ( "read_and_watch", "Where to read and watch YKK?" )
            [ md "YKK was never officially translated, so we rely on fan translations. Read on to [the next section](#buy_merch) if you are interested in buying untranslated media!"
            , md "The current best English scanlation for the manga is Yugen's by far. You can [download the scanlation on Yugen's website](https://www.yugenykk.org/), or [read it online on MangaDex](https://mangadex.org/chapter/168339/1)."
            , md "For the anime, both OVAs are [conveniently viewable on YouTube](https://www.youtube.com/watch?v=C2HCVOH6DtA) at the moment. Higher-quality downloads can be found around the web -- feel free to ask on [Discord](/links) for guidance."
            ]
        , viewSection ( "buy_merch", "Where to buy YKK merchandise?" )
            [ viewImageThumb status "merch" "dangeresque_shelf" "jpg" "Danger's collection" "large right"
            , md "*This section summarizes [DangeresqueIII's reddit guide](https://www.reddit.com/r/YKK/comments/jfu1g6/a_list_of_ykk_merch_and_where_to_buy_it/) with his permission.*"
            , md "As you will be buying from Japanese websites, remember to search for the Japanese title ヨコハマ買い出し紀行."
            , md "Here are Danger's favourite sites to buy YKK merch."
            , ul []
                [ li []
                    [ link "https://ebay.com" "ebay.com"
                    , nestedLi [ text "Manga, art book, postcard book, DVDs. Other merch rare." ]
                    ]
                , li []
                    [ link "https://amazon.co.jp" "amazon.co.jp"
                    , nestedLi [ text "Sometimes cheaper than eBay and slightly more merch, e.g. OSTs, drama CDs, novel." ]
                    ]
                , li []
                    [ link "https://auctions.yahoo.co.jp" "auctions.yahoo.co.jp"
                    , nestedLi [ text "This is where you'll find most of the derivative merchandise as seen in the list below, e.g. cels, figurines, doujin, etc. Browse through Google Translate or a browser translation extension." ]
                    ]
                ]
            , md "Many items do not ship outside of Japan, so you will need to use a proxy service such as Jauce, Buyee.jp or Zenmarket.jp. Here are Danger's pointers for Jauce:"
            , ul []
                [ li [] [ text "Deposit money into your Jauce account. (As much as you're willing to bid on the item you're interested in)" ]
                , li [] [ text "Place your max bid and wait. If you win the auction with a lower amount than your maximum, you can get the difference refunded (with a fee) or keep it to bid on other items." ]
                , li [] [ text "As an example, shipping to California takes about a week." ]
                ]
            ]
        , viewSection ( "merch_list", "List of YKK merchandise" )
            [ md "*This section summarizes [DangeresqueIII's reddit guide](https://www.reddit.com/r/YKK/comments/jfu1g6/a_list_of_ykk_merch_and_where_to_buy_it/) with his permission. Click on the links for pictures.*"
            , ul []
                [ li [] [ text "Manga:", ul []
                    [ li [] [ text "14-volume ", link "https://i.imgur.com/6IfNyJ5.jpg" "original release" ]
                    , li [] [ text "10-volume ", link "https://i.imgur.com/n16FMii.jpg" "re-release" ]
                    , li [] [ text "10 ", link "https://imgur.com/a/pnwzLoH" "issues of the original Monthly Afternoon", text " that YKK was serialized in" ]
                    , li [] [ text "Kindle version available from Amazon.jp" ]
                    ]
                ]
                , li [] [ text "Novel:", ul []
                    [ li [] [ text "1 novel with ", link "https://i.imgur.com/cQlhblw.jpg" "a few illustrations from Ashinano", text ", called Yokohama Kaidashi Kikou Novel: Seeing, Walking, Being Glad 小説 ヨコハマ買い出し紀行―見て、歩き、よろこぶ者" ]
                    ]
                ]
                , li [] [ text "Anime:", ul []
                    [ li [] [ text "2 ", link "https://imgur.com/a/Fjkclzg" "VHS releases", text ", one for each episode of the first OVA" ]
                    , li [] [ text "1 ", link "https://i.imgur.com/8QIuqnv.jpg" "VHS release", text "for the second episode of the second OVA (extremely rare)" ]
                    , li [] [ text "2 ", link "https://imgur.com/a/FWjIFxE" "Laserdisc releases", text ", one for each episode of the first OVA" ]
                    , li [] [ text "3 ", link "https://i.imgur.com/qeGiGmt.jpg" "DVD releases", text ", one disc that contains both episodes of the first OVA, and two discs that contain one episode each of the second OVA" ]
                    ]
                ]
                , li [] [ text "Soundtracks:", ul []
                    [ li [] [ text "2 ", link "https://i.imgur.com/zhbb3RI.jpg" "CDs of OSTs", text ", one for each OVA series" ]
                    , li [] [ text "3 ", link "https://i.imgur.com/ikoFtwF.jpg" "CDs of Audio Dramas", text ". They feature the same voice actors from the anime, and cover parts of the manga the anime didn't" ] ]
                ]
                , li [] [ text "Art:", ul []
                    [ li [] [ text "1 ", link "https://i.imgur.com/7VAff4a.jpg" "artbook" ]
                    , li [] [ text "1 ", link "https://i.imgur.com/31TzBCS.jpg" "collection of postcards", text "in book form" ]
                    ]
                ]
                , li [] [ text "Calendars:", ul []
                    [ li [] [ link "https://imgur.com/a/COiBHT3" "6 different versions found so far.", text "5 traditional that you hang on your wall (one not pictured), and 1 that is more of a notebook style" ]
                    ]
                ]
                , li [] [ text "Figurines:", ul []
                    [ li [] [ text "2 official figs made, one of ", link "https://i.imgur.com/rYlwhdW.jpg" "Alpha", text ", one of ", link "https://i.imgur.com/43JmfQD.jpg" "Kokone" ]
                    , li [] [ text "Multiple ", link "https://imgur.com/a/1GVKikF" "garage kits", text "(fan made) available, I have seen 4 different ones but there probably is more." ]
                    ]
                ]
                , li [] [ text "Animation Sketches and Cels:", ul []
                    [ li [] [ text "These are hard to find ", link "https://imgur.com/a/b93ndc5" "but they do pop up once in a while.", text "But be prepared to spend some money, especially for cels from the first OVA." ]
                    ]
                ]
                , li [] [ text "Other:", ul []
                    [ li [] [ text "1 ", link "https://imgur.com/a/lYeo7H9" "key chain", text "that I've seen so far, it is of the iconic fish design." ]
                    , li [] [ text "1 ", link "https://i.imgur.com/7uGUwq3.jpg" "tea set", text "(cup, saucer, spoon)" ]
                    , li [] [ text "Phone cards: there are ", link "https://imgur.com/a/Rb4BBfD" "8 \"normal\" ones", text ", and 1 ", link "https://imgur.com/a/547KL" "special edition", text "that comes in fancy packaging, making 9 total." ]
                    , li [] [ text "Multiple doujinshi, with several containing ", link "https://imgur.com/a/EbRSC2Q" "sketches", text "and interviews from Ashinano" ]
                    , li [] [ text "1 tote bag" ]
                    , li [] [ text "3 coasters: ", link "https://imgur.com/a/roOtkeS" "2 which were available to the public", text "and ", link "https://i.imgur.com/FSCcxMK.jpg" "1 that was intended for promotional use only", text "." ]
                    , li [] [ text "1 mug (I've only seen ", link "https://imgur.com/a/NFKxDEO" "one of these", text "sold and it was last week for 24,300 yen)" ]
                    , li [] [ text "1 ", link "https://imgur.com/a/wMrTB07" "dakimakura", text "(this is extremely rare, be prepared to pay through the nose if you find one for sale)" ]
                    ]
                ]
                , li [] [ text "And lastly these are ", link "https://imgur.com/a/xpXfRAU" "the super rare items that I have never seen for sale", text ":", ul []
                    [ li [] [ text "1 Alpha stamp" ]
                    , li [] [ text "1 watch" ]
                    , li [] [ text "1 jacket" ]
                    , li [] [ text "1 backpack" ]
                    , li [] [ text "2 t-shirts" ]
                    ]
                ]
                ]
            ]
        ]


viewLinks : Status -> Html Msg
viewLinks _ =
    viewPageMain "Yokohama Kaidashi Kikou links and communities" [ section []
        [ ul [] [ li [] [ strong [] [ text "Active communities" ] ] , ul []
            [ li []
                [ text "Discord "
                , nestedLi [ link "https://discord.gg/CZmtgug" "YKK Discord server with reddit r/YKK users" ]
                , nestedLi [ link "https://discord.gg/G3UBJGq" "YKK Discord server with MAL users and /w/ posters" ]
                ]
            , li [] [ link "https://www.reddit.com/r/YKK/" "Subreddit" ]
            ]
            , br [] []
        ]
        , ul [] [ li [] [ strong [] [ text "Art and fan content" ] ] , ul []
            [ li [] [ link "https://danbooru.donmai.us/posts?page=1&tags=yokohama_kaidashi_kikou" "Danbooru" , text "(fanart and official art, may include NSFW)" ]
            , li [] [ link "https://www.fanfiction.net/anime/Yokohama-Kaidashi-Kikou" "FanFiction.net" , text " and " , link "https://archiveofourown.org/tags/%E3%83%A8%E3%82%B3%E3%83%8F%E3%83%9E%E8%B2%B7%E3%81%84%E5%87%BA%E3%81%97%E7%B4%80%E8%A1%8C%20%7C%20Yokohama%20Kaidashi%20Kikou%20%7C%20Record%20of%20a%20Yokohama%20Shopping%20Trip/works" "AO3" ]
            , li [] [ link "http://wakaba.c3.cx/ykk/misago/thread_4488.html" "Map of locations in YKK" , text ", you can use " , link "http://kmlviewer.nsspot.net" "this website" , text " to view it" ]
            , li [] [ link "https://www.nicovideo.jp/search/ヨコハマ買い出し紀行?ref=nicotop_search" "Nico Nico Douga" , text " (MMD, fanvideos)" ]
            , li [] [ link "https://www.pixiv.net/en/tags/%E3%83%A8%E3%82%B3%E3%83%8F%E3%83%9E%E8%B2%B7%E3%81%84%E5%87%BA%E3%81%97%E7%B4%80%E8%A1%8C/artworks?s_mode=s_tag" "Pixiv" , text "  (fanart, may include NSFW)" ]
            , li [] [ link "http://air.niu.ne.jp/yokohama/yokohama_ig.html" "Old school Japanese fan page" , text " (some fanart and fanfiction, mild NSFW)" ]
            ]
            , br [] []
        ]
        , ul [] [ li [] [ strong [] [ text "Databases" ] , ul []
            [ li [] [ text "AniDB" , ul []
                [ li [] [ link "https://anidb.net/anime/424" "OVA 1" ]
                , li [] [ link "https://anidb.net/anime/468" "OVA 2" ]
                ]
            ]
            , li [] [ text "AniList" , ul []
                [ li [] [ link "https://anilist.co/manga/30004/Yokohama-Kaidashi-Kikou/" "Manga" ]
                , li [] [ link "https://anilist.co/anime/975/Yokohama-Kaidashi-Kikou" "OVA 1" ]
                , li [] [ link "https://anilist.co/anime/976/Yokohama-Kaidashi-Kikou-Quiet-Country-Cafe/" "OVA 2" ]
                ]
            ]
            , li [] [ text "AnimeNewsNetwork" , ul []
                [ li [] [ link "https://www.animenewsnetwork.com/encyclopedia/manga.php?id=3605" "Manga" ]
                , li [] [ link "https://www.animenewsnetwork.com/encyclopedia/anime.php?id=1156" "OVA 1" ]
                , li [] [ link "https://www.animenewsnetwork.com/encyclopedia/anime.php?id=2115" "OVA 2" ]
                ]
            ]
            , li [] [ link "https://www.mangaupdates.com/series.html?id=586" "MangaUpdates" ]
            , li [] [ text "MyAnimeList" , ul []
                [ li [] [ link "https://myanimelist.net/manga/4/Yokohama_Kaidashi_Kikou" "Manga" ]
                , li [] [ link "https://myanimelist.net/anime/975/Yokohama_Kaidashi_Kikou" "OVA 1" ]
                , li [] [ link "https://myanimelist.net/anime/976/Yokohama_Kaidashi_Kikou__Quiet_Country_Cafe" "OVA 2" ]
                ]
            ]
            , li [] [ link "https://tvtropes.org/pmwiki/pmwiki.php/Manga/YokohamaKaidashiKikou" "TvTropes" ]
            , li [] [ text "Wikipedia" , ul []
                [ li [] [ link "https://en.wikipedia.org/wiki/Yokohama_Kaidashi_Kik%C5%8D" "English" ]
                , li [] [ link "https://ja.wikipedia.org/wiki/%E3%83%A8%E3%82%B3%E3%83%8F%E3%83%9E%E8%B2%B7%E3%81%84%E5%87%BA%E3%81%97%E7%B4%80%E8%A1%8C" "Japanese" ]
                ]
            ] ]
        ], br [] [] ]
        , ul [] [ li [] [ strong [] [ text "Inactive communities" ] , ul []
            [ li [] [ link "http://wakaba.c3.cx/ykk/misago/Forum" "Archive of the 00s YKK scanlation forum" ]
            , li [] [ text "IRC: #ykkaria@irc.rizon.net" ]
            , li [] [ link "https://myanimelist.net/clubs.php?cid=314" "MyAnimeList club" ]
            ]
            , br [] []
        ] ]
        ]
    ]



-- VIEW HELPERS


viewLoading : Html Msg
viewLoading =
    div [ class "loading_ring" ] [ div [] [], div [] [], div [] [], div [] [] ]


viewQuote : String -> String -> Html Msg
viewQuote signature content =
    blockquote [] [ md content, footer [] [ md ("— " ++ signature) ] ]


viewSection : ( String, String ) -> List (Html Msg) -> Html Msg
viewSection title children =
    section [] (viewHeading (Tuple.first title) (Tuple.second title) :: children)


viewHeader : Html Msg
viewHeader =
    header [] [ viewMusicButton, viewNav ]


viewMusicButton : Html Msg
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


viewNav : Html Msg
viewNav =
    nav []
        [ link "/" "Home"
        , link "/where_to_get" "Where to get YKK (& merch)"
        , link "/links" "YKK communities & links"
        ]


viewVideoThumb : Status -> String -> String -> String -> Html Msg
viewVideoThumb status folder name classes =
    let mp4Thumb   = "./" ++ folder ++ "/" ++ name ++ "_thumb.mp4"
        webmThumb  = "./" ++ folder ++ "/" ++ name ++ "_thumb.webm"
        mp4Full    = "./" ++ folder ++ "/" ++ name ++ ".mp4"
        webmFull   = "./" ++ folder ++ "/" ++ name ++ ".webm"
        vidPoster  = "./" ++ folder ++ "/" ++ name ++ ".jpg"
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
    let mp4Full    = "./" ++ folder ++ "/" ++ name ++ ".mp4"
        webmFull   = "./" ++ folder ++ "/" ++ name ++ ".webm"
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
            [ viewLazyImg ("./"++ folder ++"/"++ name ++"_thumb."++ ext) altName
            , viewLoading
            ]
        , htmlIf (status == ViewingMedia name) <|
            div [ class "fullsize visible" ]
                [ viewLazyImg ("./"++ folder ++"/"++ name ++"."++ ext) altName ]
        ]


viewTogglableFigure : Status -> String -> String -> List (Html Msg) -> Html Msg
viewTogglableFigure status name classes children =
    let
        clickAction =
            if status == ViewingMedia name then ClearMedia else ViewMedia name
    in
    figure [ class ("thumb_enlarger " ++ classes), onClick clickAction ] children


viewLazyImg : String -> String -> Html Msg
viewLazyImg source altName =
    img [ src source, alt altName, attribute "importance" "low", attribute "loading" "lazy" ] []


viewThumbVid : String -> String -> Html Msg
viewThumbVid srcMp4 srcWebm =
    video [ property "loop" (Json.Encode.bool True), attribute "playsinline" "", autoplay True, attribute "muted" "" ]
        [ source [ src srcMp4, type_ "video/mp4" ] []
        , source [ src srcWebm, type_ "video/webm" ] []
        , text "Your browser does not support the video tag."
        ]


viewFullVid : String -> String -> String -> Html Msg
viewFullVid srcMp4 srcWebm vidPoster =
    let thumb = if String.length vidPoster > 0 then [ poster vidPoster ] else []
    in
    video ([ property "loop" (Json.Encode.bool True), controls True ] ++ thumb)
        [ source [ src srcMp4, type_ "video/mp4" ] []
        , source [ src srcWebm, type_ "video/webm" ] []
        , text "Your browser does not support the video tag."
        ]


viewHeading : String -> String -> Html Msg
viewHeading id_ title =
    a [ href ("#" ++ id_), class "heading", target "_self" ]
        [ h2 [ id id_ ] [ text title ] ]


viewPageMain : String -> List (Html Msg) -> Html Msg
viewPageMain mainTitle children =
    main_ [] (h1 [] [ text mainTitle ] :: children)


md : String -> Html Msg
md markdownBody =
    case List.head (mdParser markdownBody) of
        Just parag -> parag
        Nothing    -> p [] []


nestedLi : List (Html Msg) -> Html Msg
nestedLi content =
    ul [] [ li [] content ]


mdParser : String -> List (Html Msg)
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


extractRoute : Maybe String -> String
extractRoute maybeRoute =
    case maybeRoute of
        Just route -> route
        Nothing -> ""


link : String -> String -> Html msg
link url displayedText =
    a [ href url ] [ text displayedText ]
