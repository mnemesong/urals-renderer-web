(function ($global) { "use strict";
var Spa = function() { };
Spa.getAll = function() {
	var result = [];
	var _g = 0;
	var _g1 = Spa.stor.length;
	while(_g < _g1) {
		var i = _g++;
		result.push({ id : i, val : { s : Spa.stor[i]}});
	}
	return result;
};
Spa.rerender = function() {
	var renderId = function(id) {
		return "click_block_" + (id == null ? "null" : "" + id);
	};
	urals_web_BrowserRenderer_browserRender(Spa.getAll(),function(el) {
		return "body";
	},{ renderId : renderId, template : function(m,id) {
		return "<div id=\"" + renderId(id) + "\">" + m.s + "</div>";
	}},function(elHtml,el) {
		elHtml.onclick = function(event) {
			Spa.stor.push("Click on me!");
			Spa.rerender();
		};
	});
};
Spa.main = function() {
	Spa.rerender();
};
var haxe_iterators_ArrayIterator = function(array) {
	this.current = 0;
	this.array = array;
};
haxe_iterators_ArrayIterator.prototype = {
	hasNext: function() {
		return this.current < this.array.length;
	}
	,next: function() {
		return this.array[this.current++];
	}
};
function urals_web_BrowserRenderer_browserRender(elements,getRootSelector,renderBundle,afterRender) {
	var doc = window.document;
	var group = urals_web_RenderHelper_renderRegroup(elements,getRootSelector);
	var _g = 0;
	var _g1 = group.length;
	while(_g < _g1) {
		var i = _g++;
		var el = doc.querySelector(group[i].assoc);
		if(el != null) {
			var _this = group[i].arrs;
			var result = new Array(_this.length);
			var _g2 = 0;
			var _g3 = _this.length;
			while(_g2 < _g3) {
				var i1 = _g2++;
				var el1 = _this[i1];
				result[i1] = renderBundle.template(el1.val,el1.id);
			}
			el.innerHTML = result.join("\n");
		}
	}
	window.setTimeout(function() {
		var _g = 0;
		var _g1 = elements.length;
		while(_g < _g1) {
			var i = _g++;
			var elHtml = doc.querySelector("#" + renderBundle.renderId(elements[i].id));
			if(elHtml != null) {
				afterRender(elHtml,elements[i]);
			}
		}
	},10);
}
function urals_web_RenderHelper_renderRegroup(arr,assoc) {
	var result = [];
	var _g = 0;
	var _g1 = arr.length;
	while(_g < _g1) {
		var i = _g++;
		var t = assoc(arr[i]);
		var _g2 = [];
		var _g3 = 0;
		var _g4 = result;
		while(_g3 < _g4.length) {
			var v = _g4[_g3];
			++_g3;
			if(v.assoc == t) {
				_g2.push(v);
			}
		}
		if(_g2.length == 0) {
			result.push({ assoc : t, arrs : []});
		}
		var result1 = new Array(result.length);
		var _g5 = 0;
		var _g6 = result.length;
		while(_g5 < _g6) {
			var i1 = _g5++;
			var el = result[i1];
			result1[i1] = el.assoc == t ? { assoc : t, arrs : el.arrs.concat([arr[i]])} : el;
		}
		result = result1;
	}
	return result;
}
Spa.stor = ["Click on me!"];
Spa.main();
})({});
