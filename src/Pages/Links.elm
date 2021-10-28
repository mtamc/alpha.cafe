module Pages.Links exposing (page)

import Components as C
import Helpers as Hlp
import Html as H exposing (Html)


page : C.PageData model msg
page =
    { windowTitle = "YKK-related links"
    , h1Text = "Yokohama Kaidashi Kikou links and communities"
    , view = \_ -> view
    }


{-| TODO: Because the CSS was written when the site was just HTML+CSS,
this cannot yet use Markdown.
Long term, this should, however migrating will take a lot of time.
If you want to see a page with Markdown, check out Home.elm
-}
view : List (Html msg)
view =
    [ H.section []
        [ activeCommunities
        , artAndFanContent
        , databases
        , inactiveCommunities
        ]
    ]


listSection : String -> List (Html msg) -> Html msg
listSection title content =
    H.ul []
        [ H.li [] [ H.strong [] [ H.text title ] ]
        , H.ul [] content
        , Hlp.lineBreak
        ]


item : List (Html msg) -> Html msg
item content =
    H.li [] content


activeCommunities : Html msg
activeCommunities =
    listSection "Active communities"
        [ item
            [ H.text "Discord "
            , Hlp.nestedLi [ Hlp.link "YKK Discord server with reddit r/YKK users" "https://discord.gg/CZmtgug" ]
            , Hlp.nestedLi [ Hlp.link "YKK Discord server with MAL users and /w/ posters" "https://discord.gg/G3UBJGq" ]
            ]
        , Hlp.liLink "https://www.reddit.com/r/YKK/" "Subreddit"
        ]


artAndFanContent : Html msg
artAndFanContent =
    listSection "Art and fan content"
        [ item
            [ Hlp.link "Danbooru" "https://danbooru.donmai.us/posts?page=1&tags=yokohama_kaidashi_kikou"
            , H.text "(fanart and official art, may include NSFW)"
            ]
        , item
            [ Hlp.link "FanFiction.net" "https://www.fanfiction.net/anime/Yokohama-Kaidashi-Kikou"
            , H.text " and "
            , Hlp.link "AO3" "https://archiveofourown.org/tags/%E3%83%A8%E3%82%B3%E3%83%8F%E3%83%9E%E8%B2%B7%E3%81%84%E5%87%BA%E3%81%97%E7%B4%80%E8%A1%8C%20%7C%20Yokohama%20Kaidashi%20Kikou%20%7C%20Record%20of%20a%20Yokohama%20Shopping%20Trip/works"
            ]
        , item
            [ Hlp.link "Map of locations in YKK" "http://wakaba.c3.cx/ykk/misago/thread_4488.html"
            , H.text ", you can use "
            , Hlp.link "this website" "http://kmlviewer.nsspot.net"
            , H.text " to view it"
            ]
        , item
            [ Hlp.link "Nico Nico Douga" "https://www.nicovideo.jp/search/ヨコハマ買い出し紀行?ref=nicotop_search"
            , H.text " (MMD, fanvideos)"
            ]
        , item
            [ Hlp.link "Pixiv" "https://www.pixiv.net/en/tags/%E3%83%A8%E3%82%B3%E3%83%8F%E3%83%9E%E8%B2%B7%E3%81%84%E5%87%BA%E3%81%97%E7%B4%80%E8%A1%8C/artworks?s_mode=s_tag"
            , H.text "  (fanart, may include NSFW)"
            ]
        , item
            [ Hlp.link "Old school Japanese fan page" "http://air.niu.ne.jp/yokohama/yokohama_ig.html"
            , H.text " (some fanart and fanfiction, mild NSFW)"
            ]
        ]


databases : Html msg
databases =
    listSection "Databases"
        [ item
            [ H.text "AniDB"
            , H.ul []
                [ Hlp.liLink "OVA 1" "https://anidb.net/anime/424"
                , Hlp.liLink "OVA 2" "https://anidb.net/anime/468"
                ]
            ]
        , item
            [ H.text "AniList"
            , H.ul []
                [ Hlp.liLink "Manga" "https://anilist.co/manga/30004/Yokohama-Kaidashi-Kikou/"
                , Hlp.liLink "OVA 1" "https://anilist.co/anime/975/Yokohama-Kaidashi-Kikou"
                , Hlp.liLink "OVA 2" "https://anilist.co/anime/976/Yokohama-Kaidashi-Kikou-Quiet-Country-Cafe/"
                ]
            ]
        , item
            [ H.text "AnimeNewsNetwork"
            , H.ul []
                [ Hlp.liLink "https://www.animenewsnetwork.com/encyclopedia/manga.php?id=3605" "Manga"
                , Hlp.liLink "https://www.animenewsnetwork.com/encyclopedia/anime.php?id=1156" "OVA 1"
                , Hlp.liLink "https://www.animenewsnetwork.com/encyclopedia/anime.php?id=2115" "OVA 2"
                ]
            ]
        , Hlp.liLink "MangaUpdates" "https://www.mangaupdates.com/series.html?id=586"
        , item
            [ H.text "MyAnimeList"
            , H.ul []
                [ Hlp.liLink "Manga" "https://myanimelist.net/manga/4/Yokohama_Kaidashi_Kikou"
                , Hlp.liLink "OVA 1" "https://myanimelist.net/anime/975/Yokohama_Kaidashi_Kikou"
                , Hlp.liLink "OVA 2" "https://myanimelist.net/anime/976/Yokohama_Kaidashi_Kikou__Quiet_Country_Cafe"
                ]
            ]
        , Hlp.liLink "https://tvtropes.org/pmwiki/pmwiki.php/Manga/YokohamaKaidashiKikou" "TvTropes"
        , item
            [ H.text "Wikipedia"
            , H.ul []
                [ Hlp.liLink "English" "https://en.wikipedia.org/wiki/Yokohama_Kaidashi_Kik%C5%8D"
                , Hlp.liLink "Japanese" "https://ja.wikipedia.org/wiki/%E3%83%A8%E3%82%B3%E3%83%8F%E3%83%9E%E8%B2%B7%E3%81%84%E5%87%BA%E3%81%97%E7%B4%80%E8%A1%8C"
                ]
            ]
        ]


inactiveCommunities : Html msg
inactiveCommunities =
    listSection "Inactive communities"
        [ Hlp.liLink "Archive of the 00s YKK scanlation forum" "http://wakaba.c3.cx/ykk/misago/Forum"
        , item [ H.text "IRC: #ykkaria@irc.rizon.net" ]
        , Hlp.liLink "MyAnimeList club" "https://myanimelist.net/clubs.php?cid=314"
        ]
