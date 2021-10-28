module Pages.WhereToGet exposing (page)

import Components as C
import FullsizeImageViewer as V
import Helpers as Hlp exposing (md)
import Html as H exposing (Html)


page : C.PageData V.Model V.Msg
page =
    { windowTitle = "Where to read Yokohama Kaidashi Kikou?"
    , h1Text = "Finding Yokohama Kaidashi Kikou and its merchandise"
    , view = view
    }


{-| TODO: Because the CSS was written when the site was just HTML+CSS,
this cannot fully use Markdown.
Long term, this should, however migrating will take a lot of time.
If you want to see a page with Markdown, check out Home.elm
-}
view : V.Model -> List (Html V.Msg)
view viewerStatus =
    [ whereToReadAndWatch
    , whereToBuyMerch viewerStatus
    , merchList
    ]
        |> List.map C.pageSection


whereToReadAndWatch : C.PageSection V.Msg
whereToReadAndWatch =
    { title = "Where to read and watch YKK?"
    , htmlId = "read_and_watch"
    , content =
        [ md "YKK was never officially translated, so we rely on fan translations. Read on to [the next section](#buy_merch) if you are interested in buying untranslated media!"
        , md "The current best English scanlation for the manga is Yugen's by far. You can [download the scanlation on Yugen's website](https://www.yugenykk.org/), or [read it online on MangaDex](https://mangadex.org/chapter/168339/1)."
        , md "For the anime, both OVAs are [conveniently viewable on YouTube](https://www.youtube.com/watch?v=C2HCVOH6DtA) at the moment. Higher-quality downloads can be found around the web -- feel free to ask on [Discord](/links) for guidance."
        ]
    }


whereToBuyMerch : V.Model -> C.PageSection V.Msg
whereToBuyMerch viewerStatus =
    { title = "Where to buy YKK merchandise?"
    , htmlId = "buy_merch"
    , content =
        [ V.imgThumb viewerStatus "merch" "dangeresque_shelf" "jpg" "Danger's collection" "large right"
        , md "*This section summarizes [DangeresqueIII's reddit guide](https://www.reddit.com/r/YKK/comments/jfu1g6/a_list_of_ykk_merch_and_where_to_buy_it/) with his permission.*"
        , md "As you will be buying from Japanese websites, remember to search for the Japanese title ヨコハマ買い出し紀行."
        , md "Here are Danger's favourite sites to buy YKK merch."
        , H.ul []
            [ H.li []
                [ Hlp.link "ebay.com" "https://ebay.com"
                , Hlp.nestedLi [ H.text "Manga, art book, postcard book, DVDs. Other merch rare." ]
                ]
            , H.li []
                [ Hlp.link "amazon.co.jp" "https://amazon.co.jp"
                , Hlp.nestedLi [ H.text "Sometimes cheaper than eBay and slightly more merch, e.g. OSTs, drama CDs, novel." ]
                ]
            , H.li []
                [ Hlp.link "auctions.yahoo.co.jp" "https://auctions.yahoo.co.jp"
                , Hlp.nestedLi [ H.text "This is where you'll find most of the derivative merchandise as seen in the list below, e.g. cels, figurines, doujin, etc. Browse through Google Translate or a browser translation extension." ]
                ]
            ]
        , md "Many items do not ship outside of Japan, so you will need to use a proxy service such as Jauce, Buyee.jp or Zenmarket.jp. Here are Danger's pointers for Jauce:"
        , H.ul []
            [ H.li [] [ H.text "Deposit money into your Jauce account. (As much as you're willing to bid on the item you're interested in)" ]
            , H.li [] [ H.text "Place your max bid and wait. If you win the auction with a lower amount than your maximum, you can get the difference refunded (with a fee) or keep it to bid on other items." ]
            , H.li [] [ H.text "As an example, shipping to California takes about a week." ]
            ]
        ]
    }


merchList : C.PageSection V.Msg
merchList =
    { title = "List of YKK merchandise"
    , htmlId = "merch_list"
    , content =
        [ md "*This section summarizes [DangeresqueIII's reddit guide](https://www.reddit.com/r/YKK/comments/jfu1g6/a_list_of_ykk_merch_and_where_to_buy_it/) with his permission. Click on the links for pictures.*"
        , H.ul []
            [ H.li []
                [ H.text "Manga:"
                , H.ul []
                    [ H.li [] [ H.text "14-volume ", Hlp.link "original release" "https://i.imgur.com/6IfNyJ5.jpg" ]
                    , H.li [] [ H.text "10-volume ", Hlp.link "re-release" "https://i.imgur.com/n16FMii.jpg" ]
                    , H.li [] [ H.text "10 ", Hlp.link "issues of the original Monthly Afternoon" "https://imgur.com/a/pnwzLoH", H.text " that YKK was serialized in" ]
                    , H.li [] [ H.text "Kindle version available from Amazon.jp" ]
                    ]
                ]
            , H.li []
                [ H.text "Novel:"
                , H.ul []
                    [ H.li [] [ H.text "1 novel with ", Hlp.link "a few illustrations from Ashinano" "https://i.imgur.com/cQlhblw.jpg", H.text ", called Yokohama Kaidashi Kikou Novel: Seeing, Walking, Being Glad 小説 ヨコハマ買い出し紀行―見て、歩き、よろこぶ者" ]
                    ]
                ]
            , H.li []
                [ H.text "Anime:"
                , H.ul []
                    [ H.li [] [ H.text "2 ", Hlp.link "VHS releases" "https://imgur.com/a/Fjkclzg", H.text ", one for each episode of the first OVA" ]
                    , H.li [] [ H.text "1 ", Hlp.link "VHS release" "https://i.imgur.com/8QIuqnv.jpg", H.text " for the second episode of the second OVA (extremely rare)" ]
                    , H.li [] [ H.text "2 ", Hlp.link "Laserdisc releases" "https://imgur.com/a/FWjIFxE", H.text ", one for each episode of the first OVA" ]
                    , H.li [] [ H.text "3 ", Hlp.link "DVD releases" "https://i.imgur.com/qeGiGmt.jpg", H.text ", one disc that contains both episodes of the first OVA, and two discs that contain one episode each of the second OVA" ]
                    ]
                ]
            , H.li []
                [ H.text "Soundtracks:"
                , H.ul []
                    [ H.li [] [ H.text "2 ", Hlp.link "CDs of OSTs" "https://i.imgur.com/zhbb3RI.jpg", H.text ", one for each OVA series" ]
                    , H.li [] [ H.text "3 ", Hlp.link "CDs of Audio Dramas" "https://i.imgur.com/ikoFtwF.jpg", H.text ". They feature the same voice actors from the anime, and cover parts of the manga the anime didn't" ]
                    ]
                ]
            , H.li []
                [ H.text "Art:"
                , H.ul []
                    [ H.li [] [ H.text "1 ", Hlp.link "artbook" "https://i.imgur.com/7VAff4a.jpg" ]
                    , H.li [] [ H.text "1 ", Hlp.link "collection of postcards" "https://i.imgur.com/31TzBCS.jpg", H.text " in book form" ]
                    ]
                ]
            , H.li []
                [ H.text "Calendars:"
                , H.ul []
                    [ H.li [] [ Hlp.link "6 different versions found so far." "https://imgur.com/a/COiBHT3", H.text " 5 traditional that you hang on your wall (one not pictured), and 1 that is more of a notebook style" ]
                    ]
                ]
            , H.li []
                [ H.text "Figurines:"
                , H.ul []
                    [ H.li [] [ H.text "2 official figs made, one of ", Hlp.link "Alpha" "https://i.imgur.com/rYlwhdW.jpg", H.text ", one of ", Hlp.link "https://i.imgur.com/43JmfQD.jpg" "Kokone" ]
                    , H.li [] [ H.text "Multiple ", Hlp.link "garage kits" "https://imgur.com/a/1GVKikF", H.text " (fan made) available, I have seen 4 different ones but there probably is more." ]
                    ]
                ]
            , H.li []
                [ H.text "Animation Sketches and Cels:"
                , H.ul []
                    [ H.li [] [ H.text "These are hard to find ", Hlp.link "but they do pop up once in a while." "https://imgur.com/a/b93ndc5", H.text "But be prepared to spend some money, especially for cels from the first OVA." ]
                    ]
                ]
            , H.li []
                [ H.text "Other:"
                , H.ul []
                    [ H.li [] [ H.text "1 ", Hlp.link "key chain" "https://imgur.com/a/lYeo7H9", H.text "that I've seen so far, it is of the iconic fish design." ]
                    , H.li [] [ H.text "1 ", Hlp.link "tea set" "https://i.imgur.com/7uGUwq3.jpg", H.text "(cup, saucer, spoon)" ]
                    , H.li [] [ H.text "Phone cards: there are ", Hlp.link "8 \"normal\" ones" "https ://imgur.com/a/Rb4BBfD", H.text ", and 1 ", Hlp.link "special edition" "https://imgur.com/a/547KL", H.text "that comes in fancy packaging, making 9 total." ]
                    , H.li [] [ H.text "Multiple doujinshi, with several containing ", Hlp.link "sketches" "https://imgur.com/a/EbRSC2Q", H.text "and interviews from Ashinano" ]
                    , H.li [] [ H.text "1 tote bag" ]
                    , H.li [] [ H.text "3 coasters: ", Hlp.link "2 which were available to the public" "https://imgur.com/a/roOtkeS", H.text "and ", Hlp.link "1 that was intended for promotional use only" "https://i.imgur.com/FSCcxMK.jpg", H.text "." ]
                    , H.li [] [ H.text "1 mug (I've only seen ", Hlp.link "one of these" "https://imgur.com/a/NFKxDEO", H.text "sold and it was last week for 24,300 yen)" ]
                    , H.li [] [ H.text "1 ", Hlp.link "dakimakura" "https://imgur.com/a/wMrTB07", H.text " (this is extremely rare, be prepared to pay through the nose if you find one for sale)" ]
                    ]
                ]
            , H.li []
                [ H.text "And lastly these are "
                , Hlp.link "the super rare items that I have never seen for sale" "https://imgur.com/a/xpXfRAU"
                , H.text ":"
                , H.ul []
                    [ H.li [] [ H.text "1 Alpha stamp" ]
                    , H.li [] [ H.text "1 watch" ]
                    , H.li [] [ H.text "1 jacket" ]
                    , H.li [] [ H.text "1 backpack" ]
                    , H.li [] [ H.text "2 t-shirts" ]
                    ]
                ]
            ]
        ]
    }
