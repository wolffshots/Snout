import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class SnoutView extends WatchUi.WatchFace {

    private var sleep = false;

    private var clockCoordinate = new Coordinate(98, 38);
    private var secondsCoordinate = new Coordinate(100, 67);

    private var dowCoordinate = new Coordinate(64, 8);
    private var dateCoordinate = new Coordinate(36, 0);

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        System.println("Shown");
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout (just the background)
        View.onUpdate(dc);

        // Switch the drawing color to be the foreground setting
        dc.setColor(getApp().getProperty("ForegroundColor") as Number, Graphics.COLOR_TRANSPARENT);

        var moment = Time.now();
        var currentTime = Toybox.Time.Gregorian.info(moment, Time.FORMAT_SHORT);
        dc.drawText(dateCoordinate.X, dateCoordinate.Y, Graphics.FONT_XTINY, Lang.format("$1$/$2$/$3$", [currentTime.day.format("%02d"), currentTime.month.format("%02d"), currentTime.year.format("%02d").substring(2,4)]), Graphics.TEXT_JUSTIFY_LEFT);
        
        // divider
        dc.setPenWidth(1);
        dc.drawLine(16, dateCoordinate.Y + 22, 100, dateCoordinate.Y + 22);

        // Get the current time and format it correctly
        var timeFormat = "$1$:$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (getApp().getProperty("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);
        dc.drawText(clockCoordinate.X, clockCoordinate.Y, Graphics.FONT_NUMBER_THAI_HOT, timeString, Graphics.TEXT_JUSTIFY_RIGHT);
        if(!sleep)
        {
            var secondsTimeString = Lang.format(":$1$", [clockTime.sec.format("%02d")]);
            dc.drawText(secondsCoordinate.X, secondsCoordinate.Y, Graphics.FONT_SMALL, secondsTimeString, Graphics.TEXT_JUSTIFY_LEFT);
        }else
        {
            var secondsTimeString = "   ";
            dc.drawText(secondsCoordinate.X, secondsCoordinate.Y, Graphics.FONT_SMALL, secondsTimeString, Graphics.TEXT_JUSTIFY_LEFT);
        }

        // divider
        dc.setPenWidth(1);
        dc.drawLine(2, clockCoordinate.Y+8, 102, clockCoordinate.Y+8);
        
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
        System.println("Hidden");
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
        System.println("Exited sleep");
        sleep = false;
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
        System.println("Entered sleep");
        sleep = true;
    }

}
