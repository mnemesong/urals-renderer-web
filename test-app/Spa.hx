import js.html.Element;
import urals.IntIdRenderer;
import urals.web.BrowserRender.browserRender;

class Spa
{
    static var stor = [
        "Click on me!"
    ];

    private static function getAll(): Array<{id: Int, val: {s: String}}> {
        var result = [];
        for (i in 0...stor.length) {
            result.push({id: i, val: {s: stor[i]}});
        }
        return result;
    }

    private static function rerender() {
        var renderId = (id: Int) -> "click_block_" + Std.string(id);
        browserRender(
            getAll(), 
            (el) -> "body",
            {
                renderId: renderId,
                template: (m: {s: String}, id: Int) -> '<div id="${renderId(id)}">${m.s}</div>'
            },
            (elHtml: Element, el: {id: Int, val: {s: String}}) -> {
                elHtml.onclick = (event) -> {
                    stor.push("Click on me!");
                    rerender();
                }
            }
        );
    }

    public static function main() {
        rerender();
    }
}