package urals.web;

import htmlparser.HtmlDocument;
import urals.web.RenderHelper;

private typedef TemplateFunc<M, Id> = (m: M, id: Id) -> String;

private typedef RenderBundle<M, Id> = {
    template: TemplateFunc<M, Id>,
    renderId: (id: Id) -> String
};

private typedef Entity<M, Id> = {val: M, id: Id};

@:pure
function staticRender<M, Id>(
    elements, 
    getRootSelector: (el: Entity<M, Id>) -> String, 
    renderBundle: RenderBundle<M, Id>,
    template: String
): String {
    function renderEl(el: Entity<M, Id>) {
        return renderBundle.template(
            el.val, 
            el.id
        );
    }
    var groupedElements = renderRegroup(elements, getRootSelector);
    var groupedWidgets: Array<{sel: String, arr: Array<String>}> = groupedElements
        .map(el -> {sel: el.assoc, arr: el.arrs.map(renderEl)});
    
    var html = new HtmlDocument(template);
    for (s in 0...groupedWidgets.length) {
        var targets = html.find(groupedWidgets[s].sel);
        for (i in 0...targets.length) {
            targets[i].innerHTML = groupedWidgets[s].arr.join("\n");
        }
    }
    return html.toString();
}