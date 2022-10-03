module Pages.Links exposing (page)

import Html exposing (Html, li, strong, text, ul)
import Page exposing (Page)
import Utils


page : Page msg
page =
    { windowTitle = "YKK-related links"
    , h1Text = "Yokohama Kaidashi Kikou links and communities"
    , content =
        [ Html.section []
            [ activeCommunities
            , otherFansites
            , artAndFanContent
            , databases
            , inactiveCommunities
            ]
        ]
    }



-- PRIVATE


listSection : String -> List (Html msg) -> Html msg
listSection title content =
    ul []
        [ li [] [ strong [] [ text title ] ]
        , ul [] content
        , Utils.lineBreak
        ]


item : List (Html msg) -> Html msg
item content =
    li [] content


activeCommunities : Html msg
activeCommunities =
    listSection "Active communities"
        [ item
            [ text "Discord "
            , Utils.nestedLi [ Utils.link "YKK Discord server with reddit r/YKK users" "https://discord.gg/CZmtgug" ]
            , Utils.nestedLi [ Utils.link "YKK Discord server with MAL users and /w/ posters" "https://discord.gg/G3UBJGq" ]
            ]
        , Utils.liLink "https://www.reddit.com/r/YKK/" "Subreddit"
        ]


otherFansites : Html msg
otherFansites =
    listSection "Other fansites"
        [ Utils.liLink "YKK - Behind the Panels. Old English fansite with fascinating trivia" "http://kimoto.cc/ykk/"
        , Utils.liLink "http://uheei.yu-nagi.com/main_000.html" "http://uheei.yu-nagi.com/main_000.html"
        , Utils.liLink "http://www.din.or.jp/~ems/ms_index.htm (slightly NSFW)" "http://www.din.or.jp/~ems/ms_index.htm"
        , Utils.liLink "https://cafe-alpha.org/cafealpha/index.htm" "https://cafe-alpha.org/cafealpha/index.htm"
        ]


artAndFanContent : Html msg
artAndFanContent =
    listSection "Art and fan content"
        [ item
            [ Utils.link "Danbooru" "https://danbooru.donmai.us/posts?page=1&tags=yokohama_kaidashi_kikou"
            , text " (fanart and official art, may include NSFW)"
            ]
        , item
            [ Utils.link "FanFiction.net" "https://www.fanfiction.net/anime/Yokohama-Kaidashi-Kikou"
            , text " and "
            , Utils.link "AO3" "https://archiveofourown.org/tags/%E3%83%A8%E3%82%B3%E3%83%8F%E3%83%9E%E8%B2%B7%E3%81%84%E5%87%BA%E3%81%97%E7%B4%80%E8%A1%8C%20%7C%20Yokohama%20Kaidashi%20Kikou%20%7C%20Record%20of%20a%20Yokohama%20Shopping%20Trip/works"
            ]
        , item
            [ Utils.link "Map of locations in YKK" "http://wakaba.c3.cx/ykk/misago/thread_4488.html"
            , text ", you can use "
            , Utils.link "this website" "http://kmlviewer.nsspot.net"
            , text " to view it"
            ]
        , item
            [ Utils.link "Nico Nico Douga" "https://www.nicovideo.jp/search/ヨコハマ買い出し紀行?ref=nicotop_search"
            , text " (MMD, fanvideos)"
            ]
        , item
            [ Utils.link "Pixiv" "https://www.pixiv.net/en/tags/%E3%83%A8%E3%82%B3%E3%83%8F%E3%83%9E%E8%B2%B7%E3%81%84%E5%87%BA%E3%81%97%E7%B4%80%E8%A1%8C/artworks?s_mode=s_tag"
            , text "  (fanart, may include NSFW)"
            ]
        , item
            [ Utils.link "Old school Japanese fan page" "http://air.niu.ne.jp/yokohama/yokohama_ig.html"
            , text " (some fanart and fanfiction, mild NSFW)"
            ]
        ]


databases : Html msg
databases =
    listSection "Databases"
        [ item
            [ text "AniDB"
            , ul []
                [ Utils.liLink "OVA 1" "https://anidb.net/anime/424"
                , Utils.liLink "OVA 2" "https://anidb.net/anime/468"
                ]
            ]
        , item
            [ text "AniList"
            , ul []
                [ Utils.liLink "Manga" "https://anilist.co/manga/30004/Yokohama-Kaidashi-Kikou/"
                , Utils.liLink "OVA 1" "https://anilist.co/anime/975/Yokohama-Kaidashi-Kikou"
                , Utils.liLink "OVA 2" "https://anilist.co/anime/976/Yokohama-Kaidashi-Kikou-Quiet-Country-Cafe/"
                ]
            ]
        , item
            [ text "AnimeNewsNetwork"
            , ul []
                [ Utils.liLink "https://www.animenewsnetwork.com/encyclopedia/manga.php?id=3605" "Manga"
                , Utils.liLink "https://www.animenewsnetwork.com/encyclopedia/anime.php?id=1156" "OVA 1"
                , Utils.liLink "https://www.animenewsnetwork.com/encyclopedia/anime.php?id=2115" "OVA 2"
                ]
            ]
        , Utils.liLink "MangaUpdates" "https://www.mangaupdates.com/series.html?id=586"
        , item
            [ text "MyAnimeList"
            , ul []
                [ Utils.liLink "Manga" "https://myanimelist.net/manga/4/Yokohama_Kaidashi_Kikou"
                , Utils.liLink "OVA 1" "https://myanimelist.net/anime/975/Yokohama_Kaidashi_Kikou"
                , Utils.liLink "OVA 2" "https://myanimelist.net/anime/976/Yokohama_Kaidashi_Kikou__Quiet_Country_Cafe"
                ]
            ]
        , Utils.liLink "https://tvtropes.org/pmwiki/pmwiki.php/Manga/YokohamaKaidashiKikou" "TvTropes"
        , item
            [ text "Wikipedia"
            , ul []
                [ Utils.liLink "English" "https://en.wikipedia.org/wiki/Yokohama_Kaidashi_Kik%C5%8D"
                , Utils.liLink "Japanese" "https://ja.wikipedia.org/wiki/%E3%83%A8%E3%82%B3%E3%83%8F%E3%83%9E%E8%B2%B7%E3%81%84%E5%87%BA%E3%81%97%E7%B4%80%E8%A1%8C"
                ]
            ]
        ]


inactiveCommunities : Html msg
inactiveCommunities =
    listSection "Inactive communities"
        [ Utils.liLink "Archive of the 00s YKK scanlation forum" "http://wakaba.c3.cx/ykk/misago/Forum"
        , item [ text "IRC: #ykkaria@irc.rizon.net" ]
        , Utils.liLink "MyAnimeList club" "https://myanimelist.net/clubs.php?cid=314"
        ]
