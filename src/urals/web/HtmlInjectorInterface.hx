package urals.web;

import haxe.Exception;

interface HtmlInjectorInterface 
{
    public function append(
        targetSelector: String, 
        elemHtml: String,
        onlyFirst: Bool = false
    ): HtmlInjectorInterface;

    public function prepend(
        targetSelector: String,
        elemHtml: String,
        onlyFirst: Bool = false
    ): HtmlInjectorInterface;

    public function replaceInnerhtml(
        targetSelector: String,
        elemHtml: String,
        onlyFirst: Bool = false
    ): HtmlInjectorInterface;

}