import Toybox.Application;
import Toybox.Application.Properties;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;

class SnoutView extends WatchUi.WatchFace {

    // state variables
    private var sleep = false;
    private var heartRate;
    private var steps;
    private var solarIntensity;

    private var dateCoordinate = new Coordinate(36, 0);
    private var dowCoordinate = new Coordinate(84, dateCoordinate.Y + 22);

    private var heartRateCoordinate = new Coordinate(145, 28);

    private var clockCoordinate = new Coordinate(98, 38);
    private var secondsCoordinate = new Coordinate(100, 67);

    private var stepsCoordinate = new Coordinate(128, 88);

    private var solarIntensityCoordinate = new Coordinate(144, 108);

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

        // activity info
        var activityInfo = Activity.getActivityInfo();
        if(activityInfo == null)
        {
            System.println("activityInfo is null");
        } else {
            if(activityInfo.currentHeartRate == null){
                heartRate = "--";
            } else {
                heartRate = Lang.format("$1$", [activityInfo.currentHeartRate]);
            }
        }

        // activity monitor info
        var activityMonitorInfo = ActivityMonitor.getInfo();
        if(activityMonitorInfo == null)
        {
            System.println("activityMonitorInfo is null");
        } else {
            if(activityMonitorInfo.steps == null){
                steps = "-";
            } else {
                steps = Lang.format("$1$", [activityMonitorInfo.steps]);
            }
        }

        // get system stats
        var systemStats = System.getSystemStats();
        if(systemStats == null)
        {
            System.println("systemStats is null");
        } else {
            if(systemStats.solarIntensity == null){
                solarIntensity = "n/a";
            } else {
                solarIntensity = systemStats.solarIntensity;
            }
        }

        // Switch the drawing color to be the foreground setting
        dc.setColor(Properties.getValue("DarkMode") as Boolean ? 0xFFFFFF : 0x000000, Graphics.COLOR_TRANSPARENT);

        var moment = Time.now();
        var currentTime = Toybox.Time.Gregorian.info(moment, Time.FORMAT_SHORT);
        dc.drawText(dateCoordinate.X, dateCoordinate.Y, Graphics.FONT_XTINY, Lang.format("$1$/$2$/$3$", [currentTime.day.format("%02d"), currentTime.month.format("%02d"), currentTime.year.format("%02d").substring(2,4)]), Graphics.TEXT_JUSTIFY_LEFT);
        
        // horizontal divider below date
        dc.setPenWidth(1);
        dc.drawLine(16, dateCoordinate.Y + 22, 100, dateCoordinate.Y + 22);

        // vertical divider before dow
        dc.setPenWidth(1);
        dc.drawLine(65, dateCoordinate.Y + 22, 65, clockCoordinate.Y+8);

        currentTime = Toybox.Time.Gregorian.info(moment, Time.FORMAT_MEDIUM);
        dc.drawText(dowCoordinate.X, dowCoordinate.Y, Graphics.FONT_XTINY, Lang.format("$1$", [currentTime.day_of_week]), Graphics.TEXT_JUSTIFY_CENTER);

        // draw HR in circle
        dc.drawText(heartRateCoordinate.X, heartRateCoordinate.Y, Graphics.FONT_LARGE, Lang.format("$1$", [heartRate]), Graphics.TEXT_JUSTIFY_CENTER);

        // horizontal divider before clock
        dc.setPenWidth(1);
        dc.drawLine(2, clockCoordinate.Y+8, 102, clockCoordinate.Y+8);

        // Get the current time and format it correctly
        var timeFormat = "$1$:$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (Properties.getValue("UseMilitaryFormat")) {
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

        // horizontal divider after clock
        dc.setPenWidth(1);
        dc.drawLine(2, clockCoordinate.Y + 52, 174, clockCoordinate.Y + 52);

        // vertical divider before steps
        dc.setPenWidth(1);
        dc.drawLine(stepsCoordinate.X - 3, stepsCoordinate.Y +3, stepsCoordinate.X - 3, stepsCoordinate.Y + 22);

        var stepsString = Lang.format("$1$", [steps]);
        dc.drawText(stepsCoordinate.X, stepsCoordinate.Y, Graphics.FONT_XTINY, stepsString, Graphics.TEXT_JUSTIFY_LEFT);

        // horizontal divider after steps
        dc.setPenWidth(1);
        dc.drawLine(stepsCoordinate.X-3, stepsCoordinate.Y + 22, 174, stepsCoordinate.Y + 22);

         // vertical divider before solar intensity
        dc.setPenWidth(1);
        dc.drawLine(solarIntensityCoordinate.X - 3, solarIntensityCoordinate.Y + 3, solarIntensityCoordinate.X - 3, solarIntensityCoordinate.Y + 22);

        var solarIntensityString = Lang.format("$1$", [solarIntensity]);
        dc.drawText(solarIntensityCoordinate.X, solarIntensityCoordinate.Y, Graphics.FONT_XTINY, solarIntensityString, Graphics.TEXT_JUSTIFY_LEFT);

        // horizontal divider after solar intensity
        dc.setPenWidth(1);
        dc.drawLine(solarIntensityCoordinate.X-3, solarIntensityCoordinate.Y + 22, 174, solarIntensityCoordinate.Y + 22);

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
