package urals.web;

import htmlparser.HtmlNodeElement;
import htmlparser.HtmlDocument;

using StringTools;

class StaticHtmlInjector implements HtmlInjectorInterface 
{
    private var htmlDoc: HtmlDocument;

    public function new(htmlDoc: String) {
        this.htmlDoc = new HtmlDocument(htmlDoc);
    }

    public function append(
        targetSelector: String, 
        elemHtml: String,
        onlyFirst: Bool = false
    ): StaticHtmlInjector {
        var roots = htmlDoc.find(targetSelector);
        if(roots.length == 0) return this;
        if(onlyFirst == true) roots = [roots[0]];
        for (i in 0...roots.length) {
            roots[i].fastSetInnerHTML(roots[i].innerHTML + elemHtml);
        }
        return this;
    }

    public function prepend(
        targetSelector: String,
        elemHtml: String,
        onlyFirst: Bool = false
    ): StaticHtmlInjector {
        var roots = htmlDoc.find(targetSelector);
        if(roots.length == 0) return this;
        if(onlyFirst == true) roots = [roots[0]];
        for (i in 0...roots.length) {
            roots[i].fastSetInnerHTML(elemHtml + roots[i].innerHTML);
        }
        return this;
    }

    public function replaceInnerhtml(
        targetSelector: String,
        elemHtml: String,
        onlyFirst: Bool = false
    ): StaticHtmlInjector {
        var roots = htmlDoc.find(targetSelector);
        if(roots.length == 0) return this;
        if(onlyFirst == true) roots = [roots[0]];
        for (i in 0...roots.length) {
            roots[i].fastSetInnerHTML(elemHtml);
        }
        return this;
    }

    public function getResult(): String {
        return htmlDoc.toString();
    }

}