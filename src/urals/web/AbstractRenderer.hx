package urals.web;

abstract class AbstractRenderer<M, Id>
{
    abstract public function render(
        elements: Array<{id: Id, val: M}>, 
        getRootSelector: (el: {id: Id, val: M}) -> String,
        renderBundle: {
            template: (m: M, id: Id) -> String,
            renderId: (id: Id) -> String
        }
    ): AbstractRenderer<M, Id>;

    /**
        Group elements by selector
    **/
    @:pure
    public static function groupBySelector<M, Id>(
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
}