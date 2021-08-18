module WhereToGet exposing (view)
import Html exposing (..)
import Html.Attributes exposing (..)
import Content exposing (..)

view : Status -> Html Content.Msg
view status =
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
                    , li [] [ text "1 ", link "https://i.imgur.com/8QIuqnv.jpg" "VHS release", text " for the second episode of the second OVA (extremely rare)" ]
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
                    , li [] [ text "1 ", link "https://i.imgur.com/31TzBCS.jpg" "collection of postcards", text " in book form" ]
                    ]
                ]
                , li [] [ text "Calendars:", ul []
                    [ li [] [ link "https://imgur.com/a/COiBHT3" "6 different versions found so far.", text " 5 traditional that you hang on your wall (one not pictured), and 1 that is more of a notebook style" ]
                    ]
                ]
                , li [] [ text "Figurines:", ul []
                    [ li [] [ text "2 official figs made, one of ", link "https://i.imgur.com/rYlwhdW.jpg" "Alpha", text ", one of ", link "https://i.imgur.com/43JmfQD.jpg" "Kokone" ]
                    , li [] [ text "Multiple ", link "https://imgur.com/a/1GVKikF" "garage kits", text " (fan made) available, I have seen 4 different ones but there probably is more." ]
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
                    , li [] [ text "1 ", link "https://imgur.com/a/wMrTB07" "dakimakura", text " (this is extremely rare, be prepared to pay through the nose if you find one for sale)" ]
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

