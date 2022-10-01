module Pages.WhereToGet exposing (page)

import Components
import Html exposing (Html, li, text, ul)
import ImageViewer
import Utils exposing (md)


page : ImageViewer.Model -> Components.PageData ImageViewer.Msg
page viewerStatus =
    { windowTitle = "Where to read Yokohama Kaidashi Kikou?"
    , h1Text = "Finding Yokohama Kaidashi Kikou and its merchandise"
    , view = view viewerStatus
    }


{-| TODO: Because the CSS was written when the site was just HTML+CSS,
this cannot fully use Markdown.
Long term, this should; however, migrating will take a lot of time.
-}
view : ImageViewer.Model -> List (Html ImageViewer.Msg)
view viewerStatus =
    List.map Components.pageSection
        [ whereToReadAndWatch
        , whereToBuyMerch viewerStatus
        , merchList
        ]


whereToReadAndWatch : Components.ArticleSection msg
whereToReadAndWatch =
    { title = "Where to read and watch YKK?"
    , htmlId = "read_and_watch"
    , content =
        [ md "[Seven Seas has announced](https://sevenseasentertainment.com/2022/02/16/seven-seas-licenses-yokohama-kaidashi-kikou-manga-omnibus-series/) on February 16, 2022 that they have acquired the license to YKK and will publish oversized omnibus editions! Read on to [the next section](#buy_merch) if you are interested in buying untranslated media!"
        , md "For the anime, both OVAs are [conveniently viewable on YouTube](https://www.youtube.com/watch?v=C2HCVOH6DtA) at the moment. Higher-quality downloads can be found around the web -- feel free to ask on [Discord](/links) for guidance."
        , md "Non-English official translations exist in:"
        , ul []
            [ Utils.liLink "Korean (카페 알파)" "https://www.aladin.co.kr/shop/wproduct.aspx?ItemId=123521546"
            , Utils.liLink "Indonesian (Yokohama Shopping Blog)" "https://shopee.co.id/Komik-M-C-Yokohama-Shopping-Blog-(Hitoshi-Ashinano)-1-14-(End)-i.18501247.2214024072"
            , Utils.liLink "Traditional Chinese (橫濱購物紀行)" "https://www.tongli.com.tw/BooksDetail.aspx?BD=KC31610"
            , Utils.liLink "French (Escale à Yokohama)" "https://www.meian-editions.fr/meian/produit/escale-a-yokohama-tome-1-livre-manga/3153"
            ]
        ]
    }


whereToBuyMerch : ImageViewer.Model -> Components.ArticleSection ImageViewer.Msg
whereToBuyMerch viewerStatus =
    { title = "Where to buy YKK merchandise?"
    , htmlId = "buy_merch"
    , content =
        [ ImageViewer.imgThumb viewerStatus "merch" "dangeresque_shelf" "jpg" "Danger's collection" "large right"
        , md "*This section summarizes [DangeresqueIII's reddit guide](https://www.reddit.com/r/YKK/comments/jfu1g6/a_list_of_ykk_merch_and_where_to_buy_it/) with his permission.*"
        , md "As you will be buying from Japanese websites, remember to search for the Japanese title ヨコハマ買い出し紀行."
        , md "Here are Danger's favourite sites to buy YKK merch."
        , ul []
            [ li []
                [ Utils.link "ebay.com" "https://ebay.com"
                , Utils.nestedLi [ text "Manga, art book, postcard book, DVDs. Other merch rare." ]
                ]
            , li []
                [ Utils.link "amazon.co.jp" "https://amazon.co.jp"
                , Utils.nestedLi [ text "Sometimes cheaper than eBay and slightly more merch, e.g. OSTs, drama CDs, novel." ]
                ]
            , li []
                [ Utils.link "auctions.yahoo.co.jp" "https://auctions.yahoo.co.jp"
                , Utils.nestedLi [ text "This is where you'll find most of the derivative merchandise as seen in the list below, e.g. cels, figurines, doujin, etc. Browse through Google Translate or a browser translation extension." ]
                ]
            ]
        , md "Many items do not ship outside of Japan, so you will need to use a proxy service such as Jauce, Buyee.jp or Zenmarket.jp. Here are Danger's pointers for Jauce:"
        , ul []
            [ li [] [ text "Deposit money into your Jauce account. (As much as you're willing to bid on the item you're interested in)" ]
            , li [] [ text "Place your max bid and wait. If you win the auction with a lower amount than your maximum, you can get the difference refunded (with a fee) or keep it to bid on other items." ]
            , li [] [ text "As an example, shipping to California takes about a week." ]
            ]
        ]
    }


merchList : Components.ArticleSection msg
merchList =
    { title = "List of YKK merchandise"
    , htmlId = "merch_list"
    , content =
        [ md "*This section summarizes [DangeresqueIII's reddit guide](https://www.reddit.com/r/YKK/comments/jfu1g6/a_list_of_ykk_merch_and_where_to_buy_it/) with his permission. Click on the links for pictures.*"
        , ul []
            [ li []
                [ text "Manga:"
                , ul []
                    [ li [] [ text "14-volume ", Utils.link "original release" "https://i.imgur.com/6IfNyJ5.jpg" ]
                    , li [] [ text "10-volume ", Utils.link "re-release" "https://i.imgur.com/n16FMii.jpg" ]
                    , li [] [ text "10 ", Utils.link "issues of the original Monthly Afternoon" "https://imgur.com/a/pnwzLoH", text " that YKK was serialized in" ]
                    , li [] [ text "Kindle version available from Amazon.jp" ]
                    ]
                ]
            , li []
                [ text "Novel:"
                , ul []
                    [ li [] [ text "1 novel with ", Utils.link "a few illustrations from Ashinano" "https://i.imgur.com/cQlhblw.jpg", text ", called Yokohama Kaidashi Kikou Novel: Seeing, Walking, Being Glad 小説 ヨコハマ買い出し紀行―見て、歩き、よろこぶ者" ]
                    ]
                ]
            , li []
                [ text "Anime:"
                , ul []
                    [ li [] [ text "2 ", Utils.link "VHS releases" "https://imgur.com/a/Fjkclzg", text ", one for each episode of the first OVA" ]
                    , li [] [ text "1 ", Utils.link "VHS release" "https://i.imgur.com/8QIuqnv.jpg", text " for the second episode of the second OVA (extremely rare)" ]
                    , li [] [ text "2 ", Utils.link "Laserdisc releases" "https://imgur.com/a/FWjIFxE", text ", one for each episode of the first OVA" ]
                    , li [] [ text "3 ", Utils.link "DVD releases" "https://i.imgur.com/qeGiGmt.jpg", text ", one disc that contains both episodes of the first OVA, and two discs that contain one episode each of the second OVA" ]
                    ]
                ]
            , li []
                [ text "Soundtracks:"
                , ul []
                    [ li [] [ text "2 ", Utils.link "CDs of OSTs" "https://i.imgur.com/zhbb3RI.jpg", text ", one for each OVA series" ]
                    , li [] [ text "3 ", Utils.link "CDs of Audio Dramas" "https://i.imgur.com/ikoFtwF.jpg", text ". They feature the same voice actors from the anime, and cover parts of the manga the anime didn't" ]
                    ]
                ]
            , li []
                [ text "Art:"
                , ul []
                    [ li [] [ text "1 ", Utils.link "artbook" "https://i.imgur.com/7VAff4a.jpg" ]
                    , li [] [ text "1 ", Utils.link "collection of postcards" "https://i.imgur.com/31TzBCS.jpg", text " in book form" ]
                    ]
                ]
            , li []
                [ text "Calendars:"
                , ul []
                    [ li [] [ Utils.link "6 different versions found so far." "https://imgur.com/a/COiBHT3", text " 5 traditional that you hang on your wall (one not pictured), and 1 that is more of a notebook style" ]
                    ]
                ]
            , li []
                [ text "Figurines:"
                , ul []
                    [ li [] [ text "2 official figs made, one of ", Utils.link "Alpha" "https://i.imgur.com/rYlwhdW.jpg", text ", one of ", Utils.link "https://i.imgur.com/43JmfQD.jpg" "Kokone" ]
                    , li [] [ text "Multiple ", Utils.link "garage kits" "https://imgur.com/a/1GVKikF", text " (fan made) available, I have seen 4 different ones but there probably is more." ]
                    ]
                ]
            , li []
                [ text "Animation Sketches and Cels:"
                , ul []
                    [ li [] [ text "These are hard to find ", Utils.link "but they do pop up once in a while." "https://imgur.com/a/b93ndc5", text "But be prepared to spend some money, especially for cels from the first OVA." ]
                    ]
                ]
            , li []
                [ text "Other:"
                , ul []
                    [ li [] [ text "1 ", Utils.link "key chain" "https://imgur.com/a/lYeo7H9", text "that I've seen so far, it is of the iconic fish design." ]
                    , li [] [ text "1 ", Utils.link "tea set" "https://i.imgur.com/7uGUwq3.jpg", text "(cup, saucer, spoon)" ]
                    , li [] [ text "Phone cards: there are ", Utils.link "14 \"normal\" ones" "https ://imgur.com/a/Rb4BBfD", text ", and 2 ", Utils.link "special edition" "https://imgur.com/a/547KL", text "that comes in fancy packaging, making 9 total." ]
                    , li [] [ text "Multiple doujinshi, with several containing ", Utils.link "sketches" "https://imgur.com/a/EbRSC2Q", text "and interviews from Ashinano" ]
                    , li [] [ text "1 tote bag" ]
                    , li [] [ text "3 coasters: ", Utils.link "2 which were available to the public" "https://imgur.com/a/roOtkeS", text "and ", Utils.link "1 that was intended for promotional use only" "https://i.imgur.com/FSCcxMK.jpg", text "." ]
                    , li [] [ text "1 mug (I've only seen ", Utils.link "one of these" "https://imgur.com/a/NFKxDEO", text "sold and it was last week for 24,300 yen)" ]
                    , li [] [ text "1 ", Utils.link "dakimakura" "https://imgur.com/a/wMrTB07", text " (this is extremely rare, be prepared to pay through the nose if you find one for sale)" ]
                    ]
                ]
            , li []
                [ text "And lastly these are "
                , Utils.link "the super rare items that I have never seen for sale" "https://imgur.com/a/xpXfRAU"
                , text ":"
                , ul []
                    [ li [] [ text "1 Alpha stamp" ]
                    , li [] [ text "1 watch" ]
                    , li [] [ text "1 jacket" ]
                    , li [] [ text "1 backpack" ]
                    , li [] [ text "2 t-shirts" ]
                    ]
                ]
            ]
        ]
    }
