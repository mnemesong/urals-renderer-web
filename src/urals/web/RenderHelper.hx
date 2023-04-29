package urals.web;

function renderRegroup<M>(
    arr: Array<M>, 
    assoc: (m: M) -> String
): Array<{assoc: String, arrs: Array<M>}> {
    var result: Array<{assoc: String, arrs: Array<M>}> = [];
    for (i in 0...arr.length) {
        var t = assoc(arr[i]);
        if(result.filter(el -> el.assoc == t).length == 0) {
            result.push({assoc: t, arrs: []});
        }
        result = result.map(el 
            -> (el.assoc == t) ? {assoc: t, arrs: el.arrs.concat([arr[i]])} : el);
    }
    return result;
}