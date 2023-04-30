# urals-renderer-web


## Description
Functions for render web-element by template into html staticly for SSR


## Requirements
Package tested for Haxe >= 4.0.
The functionality or it missing of the package for lesser versions has not been tested.


## Example of usage rendering in browser
```haxe
import urals.web.StaticRenderer.staticRender;

var html = '
    <!DOCTYPE html>
    <html lang="en">
        <head><meta charset="utf-8"></head>
        <body></body>
    </html>';
var renderId = (id: Int) -> "hb_" + Std.string(id);
var renderBundle = {
    template: (m: {s: String}, id: Int) 
        -> '<div id="${renderId(id)}">${m.s}</div>',
    renderId: renderId
}
html = staticRender(
    [{id: 2, val: {s: "Hello!"}}],
    (el) -> "body",
    renderBundle,
    html
);
trace(html);
//<!DOCTYPE html>
//<html lang="en">
//    <head><meta charset="utf-8"/></head>
//    <body><div id="hb_2">Hello!</div></body>
//</html>
```


## Example of usage StaticHtmlInjector
```haxe
var template = '<body>' 
    + '<h1>Header</h1>' 
    + '<div id="container">' 
    + '<div class="elem">Text 1</div>'
    + '<div class="elem">Text 2</div>'
    + '</div>'
    + '</body>';
var injector = new StaticHtmlInjector(template);
var result = injector
    .append('.elem', '<h2>Preheader</h2>')
    .getResult();
trace(result);
//<body>
//<h1>Header</h1>
//<div id="container">
//<div class="elem">Text 1<h2>Preheader</h2></div>
//<div class="elem">Text 2<h2>Preheader</h2></div>
//</div>
//</body>
```


## Notice!
For Client-side rendering use `package urals-renderer-web-js`


## Author
Anatoly Starodubtsev
Tostar74@mail.ru