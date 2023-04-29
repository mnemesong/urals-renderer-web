# urals-renderer-web


## Description
Functions for render web-element by template into html: 
- staticly in html text for SSR
- in browser by DOM with settings events after


## Requirements
Package tested for Haxe >= 4.0.
The functionality or it missing of the package for lesser versions has not been tested.


## Example of usage rendering in browser
```haxe
import js.html.Element;
import urals.web.BrowserRenderer.browserRender;

class Spa
{
    static var stor = [ //simple storage
        "Click on me!"
    ];

    //Getting all data from storage and wrap into Entity type
    private static function getAll(): Array<{id: Int, val: {s: String}}> {
        var result = [];
        for (i in 0...stor.length) {
            result.push({id: i, val: {s: stor[i]}});
        }
        return result;
    }

    // Rerendering function by template
    private static function rerender() {
        var renderId = (id: Int) -> "click_block_" + Std.string(id);
        browserRender(
            getAll(), 
            (el) -> "body", //root-selector
            { //Html template
                renderId: renderId,
                template: (m: {s: String}, id: Int) -> '<div id="${renderId(id)}">${m.s}</div>'
            },
            (elHtml: Element, el: {id: Int, val: {s: String}}) -> {
                elHtml.onclick = (event) -> { //Setting events after render
                    stor.push("Click on me!");
                    rerender();
                }
            }
        );
    }

    public static function main() {
        rerender(); //Main script
    }
}
```


## Example of usage Static rendering into html text
```haxe
package;

import urals.web.StaticRenderer.staticRender;
import sneaker.assertion.Asserter.*;

using StringTools;

class Ssr
{
    public static function main() {
        var html = "<body></body>"; // Init html text
        var renderId = (id: Int) -> "hello_block_" + Std.string(id);
        var renderBundle = { //Html element template
            template: (m: {s: String}, id: Int) 
                -> '<div id="${renderId(id)}">${m.s}</div>',
            renderId: renderId
        }
        html = staticRender( //Render function
            [{id: 2, val: {s: "Hello!"}}],
            (el) -> "body",
            renderBundle,
            html
        );
        trace(html); //Result:
        //<body><div id="hello_block_2">Hello!</div></body>
    }    
}
```


## Author
Anatoly Starodubtsev
Tostar74@mail.ru