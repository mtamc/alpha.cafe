# alpha.cafe

![Latest screenshot.](./img/screenshot.png)

Old school fansite for the manga **Yokohama Kaidashi Kikou**. 

## Borrows elements from late-00s websites:

- Compact design using small fonts and minimal empty space between elements.
- Narrow max width (relative to modern resolutions).
- Emphasis on copy over slogans, titles, and images.

This is both purposeful nostalgia and genuine personal preference. 

## Modern webdesign is still used, e.g.:

- CSS3 properties such as box-shadow, border-radius, transition, and even flexbox.
- CSS functions (var(), calc(), rgba(), linear-gradient()...)
- Fonts.
- Full responsiveness using media queries.
- Webm.
- SCSS.
- HTML5 with semantic elements.

Principles kept in mind:

### Loading times
- Fast loading time is crucial for user experience. Images and videos are compressed as much as possible.
- Home page size is only **320KB** as measured by Lighthouse -- includes images, fonts, stylesheets, thumbnails, etc. 
- Fullsize animations (loaded individually and on demand only) total 360KB. 

### Clean code
- Simple HTML with emphasis on separation of concerns.
- Meaningless non-semantic markup such as "wrapper" elements must be employed as a last resort.
- Amply commented stylesheet easily maintainable by third parties.
- Elements higher on the page are located higher in the stylesheet. Properties are sorted alphabetically. 
- Minimize repetition and maximize themability using Sass and CSS variables.

### Appealing prose
- Simple vocabulary and concise phrasing.
- Staying interesting is more important than being comprehensive. 
- Thematic sections must follow crisp headings so users can easily find information relevant to them. 
- Emphasize key words and phrases(?)

### CSS full-size image viewer
- Figure thumbnails can be enlarged with a click. The full version will appear in the center of the screen above a black overlay. This can be closed by clicking anywhere.
  - This is achieved without JS by wrapping the image in a checkbox label. While initial testing showed no glaring accessibility issue, further tests are desirable.
- Before thumbnails are loaded, a nice CSS-only loading animation shows in their stead.

TBC
