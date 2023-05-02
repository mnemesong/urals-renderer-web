package urals.web;

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