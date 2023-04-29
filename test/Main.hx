package;

import urals.web.StaticRender.staticRender;
import sneaker.assertion.Asserter.*;

using StringTools;

class Main
{
    public static function main() {
        var html = '
            <!DOCTYPE html>
            <html lang="en">
                <head>
                    <meta charset="utf-8">
                    <title></title>
                </head>
                <body>
                </body>
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
        var clearHtml = html
            .replace("\n", "")
            .replace("\r", "")
            .replace(" ", "")
            .replace("\t", "");
        var nominal = '
            <!DOCTYPE html>
            <html lang="en">
                <head>
                    <meta charset="utf-8"/>
                    <title></title>
                </head>
                <body><div id="hb_2">Hello!</div></body>
            </html>';
        var clearNominal = nominal
            .replace("\n", "")
            .replace("\r", "")
            .replace(" ", "")
            .replace("\t", "");
        assert(clearHtml == clearNominal);
    }    
}