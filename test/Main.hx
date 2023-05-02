package;

import urals.web.StaticHtmlInjectorTest;
import urals.web.StaticRenderTest;

using StringTools;

/**
    Unit-rest for StaticRender
**/
class Main
{
    public static function main() {
        StaticRenderTest.run();
        StaticHtmlInjectorTest.run();
    }    
}