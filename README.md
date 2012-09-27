This is a <a href="http://lab.hakim.se/reveal-js/#/" target="_blank">reveal.js</a> presentation which uses <a href="http://html.adobe.com/webstandards/csscustomfilters" target="_blank">CSS Custom Filters</a> for transitions between slides.

At present you must use <a href="https://tools.google.com/dlpage/chromesxs" target="_blank">Google Chrome Canary</a> to view the CSS Custom Filters. Navigate to <a href="about://flags">about://flags</a> and then enabled CSS Shaders.

If you are using Google Chrome Canary with CSS Shaders enabled, you can view the atual presentation <a href="http://awgreenblatt.github.com/reveal-shaders/" target="_blank">here</a>.

Right now, the custom filter transitions are only used for the top level navigation.  When you want to navigate down a stack and one of the CSS Custom Filter transitions is acive, the box transition is used instead to differentiate.

If you want to see what this looks like, check out this Youtube video: <a href="http://youtu.be/s2p512eVsmE" target="_blank">http://youtu.be/5ja_CcM4his</a>

Check out my other experiments on <http://blattchat.com>.

If you want simply want to add these extensions to your existing reveal.js presentation, all you need to do is add the css/shaders folder and the shader-specific css files (burn.css, dissolve.css & tile-flip.css) to your existing css folder and then include the css files from index.html.

Enjoy!

