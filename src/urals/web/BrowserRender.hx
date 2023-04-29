package urals.web;

import urals.web.RenderHelper.renderRegroup;
import js.Browser;
import js.html.Element;

private typedef TemplateFunc<M, Id> = (m: M, id: Id) -> String;

private typedef RenderBundle<M, Id> = {
    template: TemplateFunc<M, Id>,
    renderId: (id: Id) -> String
};

private typedef Entity<M, Id> = {val: M, id: Id};

function browserRender<M, Id>(
    elements: Array<Entity<M, Id>>, 
    getRootSelector: (el: Entity<M, Id>) -> String, //Селектор контейнера, а не родительского виджета
    renderBundle: RenderBundle<M, Id>,
    afterRender: (elHtml: Element, el: Entity<M, Id>) -> Void
): Void {
    var doc = Browser.document;
    var group = renderRegroup(elements, getRootSelector);
    for (i in 0...group.length) {
        var el = doc.querySelector(group[i].assoc);
        if(el != null) {
            el.innerHTML = group[i].arrs
                .map(el -> renderBundle.template(el.val, el.id))
                .join("\n");
        }
    }
    Browser.window.setTimeout(() -> {
        for (i in 0...elements.length) {
            var elHtml = doc.querySelector('#' + renderBundle.renderId(elements[i].id));
            if(elHtml != null) {
                afterRender(elHtml, elements[i]);
            }
        }
    }, 10);
}