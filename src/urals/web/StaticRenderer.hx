package urals.web;

import htmlparser.HtmlDocument;

private typedef TemplateFunc<M, Id> = (m: M, id: Id) -> String;

private typedef RenderBundle<M, Id> = {
    template: TemplateFunc<M, Id>,
    renderId: (id: Id) -> String
};

private typedef Entity<M, Id> = {val: M, id: Id};

/**
    Group elements by selector
**/
@:pure
function groupBySelector<M>(
    arr: Array<M>, 
    selector: (m: M) -> String
): Array<{assoc: String, arrs: Array<M>}> {
    var result: Array<{assoc: String, arrs: Array<M>}> = [];
    for (i in 0...arr.length) {
        var t = selector(arr[i]);
        if(result.filter(el -> el.assoc == t).length == 0) {
            result.push({assoc: t, arrs: []});
        }
        result = result.map(el 
            -> (el.assoc == t) ? {assoc: t, arrs: el.arrs.concat([arr[i]])} : el);
    }
    return result;
}

/**
    Renders element, created by RenderBundle into html-string by selector and
    returns result as string
**/
@:pure
function staticRender<M, Id>(
    elements, 
    getRootSelector: (el: Entity<M, Id>) -> String, //Where host new elem
    renderBundle: RenderBundle<M, Id>,
    template: String
): String {
    function renderEl(el: Entity<M, Id>) {
        return renderBundle.template(
            el.val, 
            el.id
        );
    }
    var groupedElements = groupBySelector(elements, getRootSelector);
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