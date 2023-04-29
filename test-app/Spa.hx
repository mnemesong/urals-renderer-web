import js.html.Element;
import urals.IntIdRenderer;

class Main 
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
        rend.rerenderInSpa(
            getAll(), 
            (el) -> "body", 
            (elHtml: Element, el: {id: Int, val: {s: String}}) -> {
                elHtml.onclick = (event) -> {
                    stor.push("Click on me!");
                    rerender();
                }
            }
        );
    }

    public static function main() {
        rend = new SpaWidgetRenderer(
            new WebWidgetStub("w", new IntIdRenderer("w_")));
        rerender();
    }
}