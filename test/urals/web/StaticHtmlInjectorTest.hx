package urals.web;

import sneaker.assertion.Asserter.*;

class StaticHtmlInjectorTest 
{
    static function getHtmlTemplate(): String {
        return '<body>' 
            + '<h1>Header</h1>' 
            + '<div id="container">' 
            + '<div class="elem">Text 1</div>'
            + '<div class="elem">Text 2</div>'
            + '</div>'
            + '</body>';
    }

    static function testAppend1() {
        var injector = new StaticHtmlInjector(getHtmlTemplate());
        var result = injector
            .append('.elem', '<h2>Preheader</h2>')
            .getResult();
        var nominal = '<body>' 
            + '<h1>Header</h1>' 
            + '<div id="container">' 
            + '<div class="elem">Text 1<h2>Preheader</h2></div>'
            + '<div class="elem">Text 2<h2>Preheader</h2></div>'
            + '</div>'
            + '</body>';
        assert(result == nominal);
    }

    static function testAppend2() {
        var injector = new StaticHtmlInjector(getHtmlTemplate());
        var result = injector
            .append('.elem', '<h2>Preheader</h2>', true)
            .getResult();
        var nominal = '<body>' 
            + '<h1>Header</h1>' 
            + '<div id="container">' 
            + '<div class="elem">Text 1<h2>Preheader</h2></div>'
            + '<div class="elem">Text 2</div>'
            + '</div>'
            + '</body>';
        assert(result == nominal);
    }

    static function testPrepend1() {
        var injector = new StaticHtmlInjector(getHtmlTemplate());
        var result = injector
            .prepend('.elem', '<h2>Preheader</h2>')
            .getResult();
        var nominal = '<body>' 
            + '<h1>Header</h1>' 
            + '<div id="container">' 
            + '<div class="elem"><h2>Preheader</h2>Text 1</div>'
            + '<div class="elem"><h2>Preheader</h2>Text 2</div>'
            + '</div>'
            + '</body>';
        assert(result == nominal);
    }

    static function testPrepend2() {
        var injector = new StaticHtmlInjector(getHtmlTemplate());
        var result = injector
            .prepend('.elem', '<h2>Preheader</h2>', true)
            .getResult();
        var nominal = '<body>' 
            + '<h1>Header</h1>' 
            + '<div id="container">' 
            + '<div class="elem"><h2>Preheader</h2>Text 1</div>'
            + '<div class="elem">Text 2</div>'
            + '</div>'
            + '</body>';
        assert(result == nominal);
    }

    static function testInnerHtml1() {
        var injector = new StaticHtmlInjector(getHtmlTemplate());
        var result = injector
            .replaceInnerhtml('.elem', '<h2>Preheader</h2>')
            .getResult();
        var nominal = '<body>' 
            + '<h1>Header</h1>' 
            + '<div id="container">' 
            + '<div class="elem"><h2>Preheader</h2></div>'
            + '<div class="elem"><h2>Preheader</h2></div>'
            + '</div>'
            + '</body>';
        assert(result == nominal);
    }

    static function testInnerHtml2() {
        var injector = new StaticHtmlInjector(getHtmlTemplate());
        var result = injector
            .replaceInnerhtml('.elem', '<h2>Preheader</h2>', true)
            .getResult();
        var nominal = '<body>' 
            + '<h1>Header</h1>' 
            + '<div id="container">' 
            + '<div class="elem"><h2>Preheader</h2></div>'
            + '<div class="elem">Text 2</div>'
            + '</div>'
            + '</body>';
        assert(result == nominal);
    }

    public static function run() {
        testAppend1();
        testAppend2();
        testPrepend1();
        testPrepend2();
        testInnerHtml1();
        testInnerHtml2();
    }
}