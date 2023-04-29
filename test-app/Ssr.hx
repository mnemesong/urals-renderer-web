package;

import urals.web.StaticRender.staticRender;
import sneaker.assertion.Asserter.*;
import js.Browser;

using StringTools;

class Ssr
{
    public static function main() {
        var html = Browser.document.body.outerHTML;
        var renderId = (id: Int) -> "hello_block_" + Std.string(id);
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
        Browser.document.body.outerHTML = html;
    }    
}