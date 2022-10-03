module Pages.Home exposing (page)

import Components
import Html exposing (Html)
import ImageViewer
import Page exposing (Page)
import Utils exposing (md)


page : ImageViewer.Model -> Page ImageViewer.Msg
page viewer =
    { windowTitle = "Alpha Café, everything about YKK!"
    , h1Text = "Everything about Yokohama Kaidashi Kikou!"
    , content =
        [ whatIsThisSite viewer
        , whatIsYkk viewer
        , whatIsYkkAbout viewer
        , whyReadYkk viewer
        ]
    }



-- PRIVATE


whatIsThisSite : ImageViewer.Model -> Html ImageViewer.Msg
whatIsThisSite viewer =
    Components.section "What's this site?" { id = "what_is_this_site" } <|
        [ ImageViewer.videoThumb viewer
            { folder = "home", name = "illus1", classes = "" }
        , md "Alpha.cafe is an old school Yokohama Kaidashi Kikou fan page! Since YKK is a very nostalgic story with \"return to low-tech\" themes, perhaps I will pique your interest with this tribute to the world wide web before social media, and wink to platforms where the fandom once thrived!"
        , md "I hope to recreate the feeling of stumbling upon a hidden corner of the web, a little like finding Café Alpha deep in the country, up and running despite the lack of customers..."
        ]


whatIsYkk : ImageViewer.Model -> Html ImageViewer.Msg
whatIsYkk viewer =
    Components.section "What's Yokohama Kaidashi Kikou?" { id = "what_is_ykk" } <|
        [ ImageViewer.videoThumb viewer
            { folder = "home", name = "illus2", classes = "" }
        , md "**Yokohama Kaidashi Kikou**, or YKK for short, is [Hitoshi Ashinano](https://en.wikipedia.org/wiki/Hitoshi_Ashinano)'s best-known **manga series**! It ran from **1994 to 2006** in **seinen magazine Afternoon**, alongside series like Mushishi, BLAME!, and Vinland Saga. YKK's fanbase has had an association and strong overlap with **Aria**'s, although the latter is more famous!"
        , md "One translation for the title would be **\"Yokohama Shopping Log.\"**"
        , ImageViewer.videoThumb viewer
            { folder = "home", name = "illus3", classes = "pull_me_up" }
        , md "YKK was adapted into two **short 2-episode OVAs**, in 1998 and 2002-3. They adapt a tiny section of the story, but are both a treat for fans of the manga, as well as a good introduction for those not familiar with the series!"
        , md "**Choro Club**, who authored Aria's OST, is also behind the second YKK OVAs' music! Listen to *Café Alpha ~Main Theme~* by using the player at the top!"
        ]


whatIsYkkAbout : ImageViewer.Model -> Html ImageViewer.Msg
whatIsYkkAbout viewer =
    Components.section "What's YKK about?" { id = "what_is_ykk_about" } <|
        [ ImageViewer.videoThumbOnlyOneSize viewer
            { folder = "home", name = "illus4", classes = "" }
        , md "YKK is a **post-apocalyptic slice of life** following the daily life and travels of android Alpha Hatsuseno. Humanity is in gradual decline, and **sea levels have risen submerging much of Japan** as we know it."
        , md "In this Japan that has already accepted the twilight of humanity, Alpha lives her life peacefully, **watching the passing of time** in the **last age of mankind.**"
        , ImageViewer.videoThumb viewer
            { folder = "home", name = "illus5", classes = "pull_me_up" }
        , md "She befriends characters like Ojisan, who runs a gas station with infrequent customers; Takahiro and Makki, children growing up in a dwindling society; or Kokone, an android courier who ponders upon the nature of the robots' existence."
        ]


whyReadYkk : ImageViewer.Model -> Html ImageViewer.Msg
whyReadYkk viewer =
    Components.section "Why should I read/watch YKK?" { id = "why_read_ykk" } <|
        [ ImageViewer.videoThumb viewer
            { folder = "home", name = "illus6", classes = "right" }
        , md "If you enjoy **art-driven series**, or if want to read something **unique**, with the potential to move you deeply, you should definitely check out YKK! It's a story full of emotions primarily told through art. The panels recreate not just the *look* of a beautiful country road, but the *feeling* of strolling through one, using ethereal landscapes at times backlit shadows, at times shrouded by haze. Some panels underline thoughtfulness and solitude by artfully using empty space. The unhurried narrative and art gradually build an overwhelming mood of **wistful yet serene solitude.**"
        , ImageViewer.imgThumb viewer
            { folder = "home"
            , name = "ykkpage"
            , ext = "jpg"
            , altName = "Page from YKK"
            , classes = "large left"
            }
        , md "The OVAs' creators understood Ashinano's mastery of manga and the **subdued yet powerful atmosphere** he crafted with it. They recreated this unique story, where **every pause is made meaningful**, with their own mastery of animation."
        , Components.blockquote "Hitoshi Ashinano" "Contemporary anime is in constant movement. Despite that, Director Annou carefully internalized the impression of spaces, pauses, and elements like that. So I believe I am lucky to have him as director."
        , md "In these OVAs the high-contrast stylized landscapes become gorgeous paintings in slow shots, carefully framed to convey the beauty in mundane details. Coffee in the morning. The shadow of a passing cloud. Nature swaying in the wind."
        , ImageViewer.imgThumb viewer
            { folder = "home"
            , name = "colorpage"
            , ext = "png"
            , altName = "Page from YKK"
            , classes = "large right pull_me_up"
            }
        , md "Ashinano's **economy of style** applies also to the series' story. Loss and mourning are implied. If I had to compare YKK with existing media, I'd offer [Japanese haiku](https://en.wikipedia.org/wiki/Haiku) and [Ernest Hemingway](https://en.wikipedia.org/wiki/Ernest_Hemingway) for their technique and their conveying of strong feelings in deceptively few and understated words."
        , md "Don't know where to find YKK? Check out the [Where to get](/where_to_get) page!"
        ]
