import Toybox.Application;
import Toybox.Application.Properties;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class Background extends WatchUi.Drawable {

    function initialize() {
        var dictionary = {
            :identifier => "Background"
        };

        Drawable.initialize(dictionary);
    }

    function draw(dc as Dc) as Void {
        // Set the background color then call to clear the screen
        dc.setColor(Properties.getValue("DarkMode") as Boolean ? 0xFFFFFF : 0x000000, Properties.getValue("DarkMode") as Boolean ? 0x000000 : 0xFFFFFF);
        dc.clear();
    }

}
