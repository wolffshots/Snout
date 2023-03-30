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
        dc.setColor(Properties.getValue("ForegroundColor") as Number, Properties.getValue("BackgroundColor") as Number);
        dc.clear();
    }

}
