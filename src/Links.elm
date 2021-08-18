module Links exposing (view)
import Html exposing (..)
import Html.Attributes exposing (..)
import Content exposing (..)

view : Status -> Html Msg
view _ =
    viewPageMain "Yokohama Kaidashi Kikou links and communities" [ section []
        [ ul [] [ li [] [ strong [] [ text "Active communities" ] ] , ul []
            [ li []
                [ text "Discord "
                , nestedLi [ link "https://discord.gg/CZmtgug" "YKK Discord server with reddit r/YKK users" ]
                , nestedLi [ link "https://discord.gg/G3UBJGq" "YKK Discord server with MAL users and /w/ posters" ]
                ]
            , liLink "https://www.reddit.com/r/YKK/" "Subreddit"
            ]
            , lineBreak
        ]
        , ul [] [ li [] [ strong [] [ text "Art and fan content" ] ] , ul []
            [ li [] [ link "https://danbooru.donmai.us/posts?page=1&tags=yokohama_kaidashi_kikou" "Danbooru" , text "(fanart and official art, may include NSFW)" ]
            , li [] [ link "https://www.fanfiction.net/anime/Yokohama-Kaidashi-Kikou" "FanFiction.net" , text " and " , link "https://archiveofourown.org/tags/%E3%83%A8%E3%82%B3%E3%83%8F%E3%83%9E%E8%B2%B7%E3%81%84%E5%87%BA%E3%81%97%E7%B4%80%E8%A1%8C%20%7C%20Yokohama%20Kaidashi%20Kikou%20%7C%20Record%20of%20a%20Yokohama%20Shopping%20Trip/works" "AO3" ]
            , li [] [ link "http://wakaba.c3.cx/ykk/misago/thread_4488.html" "Map of locations in YKK" , text ", you can use " , link "http://kmlviewer.nsspot.net" "this website" , text " to view it" ]
            , li [] [ link "https://www.nicovideo.jp/search/ヨコハマ買い出し紀行?ref=nicotop_search" "Nico Nico Douga" , text " (MMD, fanvideos)" ]
            , li [] [ link "https://www.pixiv.net/en/tags/%E3%83%A8%E3%82%B3%E3%83%8F%E3%83%9E%E8%B2%B7%E3%81%84%E5%87%BA%E3%81%97%E7%B4%80%E8%A1%8C/artworks?s_mode=s_tag" "Pixiv" , text "  (fanart, may include NSFW)" ]
            , li [] [ link "http://air.niu.ne.jp/yokohama/yokohama_ig.html" "Old school Japanese fan page" , text " (some fanart and fanfiction, mild NSFW)" ]
            ]
            , lineBreak
        ]
        , ul [] [ li [] [ strong [] [ text "Databases" ] , ul []
            [ li [] [ text "AniDB" , ul []
                [ liLink "https://anidb.net/anime/424" "OVA 1"
                , liLink "https://anidb.net/anime/468" "OVA 2"
                ]
            ]
            , li [] [ text "AniList" , ul []
                [ liLink "https://anilist.co/manga/30004/Yokohama-Kaidashi-Kikou/" "Manga"
                , liLink "https://anilist.co/anime/975/Yokohama-Kaidashi-Kikou" "OVA 1"
                , liLink "https://anilist.co/anime/976/Yokohama-Kaidashi-Kikou-Quiet-Country-Cafe/" "OVA 2"
                ]
            ]
            , li [] [ text "AnimeNewsNetwork" , ul []
                [ liLink "https://www.animenewsnetwork.com/encyclopedia/manga.php?id=3605" "Manga"
                , liLink "https://www.animenewsnetwork.com/encyclopedia/anime.php?id=1156" "OVA 1"
                , liLink "https://www.animenewsnetwork.com/encyclopedia/anime.php?id=2115" "OVA 2"
                ]
            ]
            , liLink "https://www.mangaupdates.com/series.html?id=586" "MangaUpdates"
            , li [] [ text "MyAnimeList" , ul []
                [ liLink "https://myanimelist.net/manga/4/Yokohama_Kaidashi_Kikou" "Manga"
                , liLink "https://myanimelist.net/anime/975/Yokohama_Kaidashi_Kikou" "OVA 1"
                , liLink "https://myanimelist.net/anime/976/Yokohama_Kaidashi_Kikou__Quiet_Country_Cafe" "OVA 2"
                ]
            ]
            , liLink "https://tvtropes.org/pmwiki/pmwiki.php/Manga/YokohamaKaidashiKikou" "TvTropes"
            , li [] [ text "Wikipedia" , ul []
                [ liLink "https://en.wikipedia.org/wiki/Yokohama_Kaidashi_Kik%C5%8D" "English"
                , liLink "https://ja.wikipedia.org/wiki/%E3%83%A8%E3%82%B3%E3%83%8F%E3%83%9E%E8%B2%B7%E3%81%84%E5%87%BA%E3%81%97%E7%B4%80%E8%A1%8C" "Japanese"
                ]
            ] ]
        ], lineBreak ]
        , ul [] [ li [] [ strong [] [ text "Inactive communities" ] , ul []
            [ liLink "http://wakaba.c3.cx/ykk/misago/Forum" "Archive of the 00s YKK scanlation forum"
            , li [] [ text "IRC: #ykkaria@irc.rizon.net" ]
            , liLink "https://myanimelist.net/clubs.php?cid=314" "MyAnimeList club"
            ]
            , lineBreak
        ] ]
        ]
    ]

