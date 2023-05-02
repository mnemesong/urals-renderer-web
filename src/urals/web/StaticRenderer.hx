package urals.web;

class StaticRenderer<M, Id> extends AbstractRenderer<M, Id> 
{
    private var template: String;

    public function new(template: String) {
        this.template = template;
    }

    public function render<M, Id>(
        elements: Array<{id: Id, val: M}>, 
        getRootSelector: (el: {id: Id, val: M}) -> String,
        renderBundle: {
            template: (m: M, id: Id) -> String,
            renderId: (id: Id) -> String
        }
    ): StaticRenderer<M, Id> {
        function renderEl(el: {id: Id, val: M}) {
            return renderBundle.template(
                el.val, 
                el.id
            );
        }
        var groupedElements = AbstractRenderer.groupBySelector(elements, getRootSelector);
        var groupedWidgets: Array<{sel: String, arr: Array<String>}> = groupedElements
            .map(el -> {sel: el.assoc, arr: el.arrs.map(renderEl)});
        var injector = new StaticHtmlInjector(template);
        for (s in 0...groupedWidgets.length) {
            var injector =  injector
                .replaceInnerhtml(groupedWidgets[s].sel, groupedWidgets[s].arr.join("\n"));
        }
        return new StaticRenderer(injector.getResult());
    }

    public function getHtml() {
        return template;
    }
}