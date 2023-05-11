import Toybox.Application;
import Toybox.Application.Properties;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;
import Toybox.Math;

class SnoutView extends WatchUi.WatchFace {

    // state variables
    private var sleep = false;
    private var heartRate;
    private var steps;
    private var solarIntensity;
    private var notificationCount;
    private var doNotDisturb;
    private var battery;
    private var batteryInDays;
    private var batteryWidth;
    private var charging;
    private var pressure;
    private var altitude;

    private var dateCoordinate = new Coordinate(36, 0);
    private var dowCoordinate = new Coordinate(84, dateCoordinate.Y + 22);

    private var heartRateCoordinate = new Coordinate(146, 28);
    private var heartRateBitmapCoordinate = new Coordinate(138, 15);
    private var heartRateBitmap;

    private var clockCoordinate = new Coordinate(98, 38);
    private var secondsCoordinate = new Coordinate(100, 67);

    private var stepsCoordinate = new Coordinate(111, 88);
    private var stepsBitmapCoordinate = new Coordinate(stepsCoordinate.X - 20, stepsCoordinate.Y + 6);
    private var stepsBitmap;

    private var solarIntensityCoordinate = new Coordinate(144, 31);

    private var notificationCountCoordinate = new Coordinate(39, 20);
    private var notificationCountBitmapCoordinate = new Coordinate(
        notificationCountCoordinate.X - 25, 
        notificationCountCoordinate.Y + 7
    );
    private var notificationCountBitmap;
    private var doNotDisturbBitmap;

    private var batteryOutlineBitmapCoordinate = new Coordinate(80, 135);
    private var batteryCoordinate = new Coordinate(
        batteryOutlineBitmapCoordinate.X - 8, 
        batteryOutlineBitmapCoordinate.Y - 5
    );
    private var batteryInDaysCoordinate = new Coordinate(
        batteryOutlineBitmapCoordinate.X + 25, 
        batteryOutlineBitmapCoordinate.Y - 5
    );
    private var batteryOutlineBitmap;
    private var boltBitmap;

    private var pressureCoordinate = new Coordinate(18, 111);
    private var pressureBitmapCoordinate = new Coordinate(
        pressureCoordinate.X - 16, 
        pressureCoordinate.Y + 5
    );
    private var pressureBitmap;

    private var altitudeCoordinate = new Coordinate(108, 111);
    private var altitudeBitmapCoordinate = new Coordinate(
        altitudeCoordinate.X - 17, 
        altitudeCoordinate.Y + 5
    );
    private var altitudeBitmap;

    function initialize() {
        WatchFace.initialize();
        heartRateBitmap = Application.loadResource( 
            Properties.getValue("DarkMode") as Boolean
            ? Rez.Drawables.heartDark
            : Rez.Drawables.heartLight ) as BitmapResource;

        notificationCountBitmap = Application.loadResource( 
            Properties.getValue("DarkMode") as Boolean
            ? Rez.Drawables.notificationsDark
            : Rez.Drawables.notificationsLight ) as BitmapResource;
        
        doNotDisturbBitmap = Application.loadResource( 
            Properties.getValue("DarkMode") as Boolean
            ? Rez.Drawables.doNotDisturbDark
            : Rez.Drawables.doNotDisturbLight ) as BitmapResource;

        stepsBitmap = Application.loadResource( 
            Properties.getValue("DarkMode") as Boolean
            ? Rez.Drawables.stepsDark
            : Rez.Drawables.stepsLight ) as BitmapResource;

        batteryOutlineBitmap = Application.loadResource( 
            Properties.getValue("DarkMode") as Boolean
            ? Rez.Drawables.batteryOutlineDark
            : Rez.Drawables.batteryOutlineLight ) as BitmapResource;

        boltBitmap = Application.loadResource( 
            Properties.getValue("DarkMode") as Boolean
            ? Rez.Drawables.boltDark
            : Rez.Drawables.boltLight ) as BitmapResource;

        pressureBitmap = Application.loadResource( 
            Properties.getValue("DarkMode") as Boolean
            ? Rez.Drawables.pressureDark
            : Rez.Drawables.pressureLight ) as BitmapResource;

        altitudeBitmap = Application.loadResource( 
            Properties.getValue("DarkMode") as Boolean
            ? Rez.Drawables.altitudeDark
            : Rez.Drawables.batteryOutlineLight ) as BitmapResource;
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        System.println("onLayout");
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        System.println("Shown");
        heartRateBitmap = Application.loadResource( 
            Properties.getValue("DarkMode") as Boolean
            ? Rez.Drawables.heartDark
            : Rez.Drawables.heartLight ) as BitmapResource;
        notificationCountBitmap = Application.loadResource( 
            Properties.getValue("DarkMode") as Boolean
            ? Rez.Drawables.notificationsDark
            : Rez.Drawables.notificationsLight ) as BitmapResource;
        doNotDisturbBitmap = Application.loadResource( 
            Properties.getValue("DarkMode") as Boolean
            ? Rez.Drawables.doNotDisturbDark
            : Rez.Drawables.doNotDisturbLight ) as BitmapResource;
        stepsBitmap = Application.loadResource( 
            Properties.getValue("DarkMode") as Boolean
            ? Rez.Drawables.stepsDark
            : Rez.Drawables.stepsLight ) as BitmapResource;
        batteryOutlineBitmap = Application.loadResource( 
            Properties.getValue("DarkMode") as Boolean
            ? Rez.Drawables.batteryOutlineDark
            : Rez.Drawables.batteryOutlineLight ) as BitmapResource;
        boltBitmap = Application.loadResource( 
            Properties.getValue("DarkMode") as Boolean
            ? Rez.Drawables.boltDark
            : Rez.Drawables.boltLight ) as BitmapResource;
        pressureBitmap = Application.loadResource( 
            Properties.getValue("DarkMode") as Boolean
            ? Rez.Drawables.pressureDark
            : Rez.Drawables.pressureLight ) as BitmapResource;
        altitudeBitmap = Application.loadResource( 
            Properties.getValue("DarkMode") as Boolean
            ? Rez.Drawables.altitudeDark
            : Rez.Drawables.batteryOutlineLight ) as BitmapResource;
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout (just the background)
        View.onUpdate(dc);

        dc.drawBitmap(heartRateBitmapCoordinate.X, heartRateBitmapCoordinate.Y, heartRateBitmap);
        dc.drawBitmap(stepsBitmapCoordinate.X, stepsBitmapCoordinate.Y, stepsBitmap);

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
            if(activityInfo.ambientPressure == null){
                pressure = "--";
            } else {
                if(activityInfo.ambientPressure >= 1000){
                    pressure = (activityInfo.ambientPressure/1000).format("%0.1f") + "kPa";
                } else{
                    pressure = (activityInfo.ambientPressure).format("%0.2f") + "Pa";
                }
            }
            if(activityInfo.altitude == null){
                altitude = "--";
            } else {
                if(activityInfo.altitude >= 10000){
                    altitude = (activityInfo.altitude/1000).format("%0.2f") + "km";
                }else{
                    altitude = activityInfo.altitude.format("%0.1f") + "m";
                }
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
                var stepsThousands = activityMonitorInfo.steps / 1000;
                if (stepsThousands > 0){
                    var stepsRemainder = activityMonitorInfo.steps.toString().substring(
                        activityMonitorInfo.steps.toString().length() - 3, 
                        activityMonitorInfo.steps.toString().length()
                    );
                    steps = Lang.format("$1$ $2$", [stepsThousands, stepsRemainder]);
                } else{
                    steps = Lang.format("$1$", [activityMonitorInfo.steps]);
                }
            }
        }

        // get system stats
        var systemStats = System.getSystemStats();
        if(systemStats == null)
        {
            System.println("systemStats is null");
        } else {
            if(systemStats.solarIntensity == null){
                solarIntensity = 0;
            } else {
                solarIntensity = systemStats.solarIntensity;
            }

            if(systemStats.battery == null){
                battery = 0;
            } else {
                battery = systemStats.battery.format("%0.1f") + "%";
                batteryWidth = systemStats.battery/10;
            }

            if(systemStats.batteryInDays == null){
                batteryInDays = 0;
            } else {
                batteryInDays = systemStats.batteryInDays.format("%d") + " days";
            }
            
            charging = systemStats.charging;
        }

        // device settings
        var deviceSettings = System.getDeviceSettings();
        doNotDisturb = deviceSettings.doNotDisturb;
        if (deviceSettings.notificationCount != null && !doNotDisturb) {
            notificationCount = deviceSettings.notificationCount;
        }
        
        // Switch the drawing color to be the foreground setting
        dc.setColor(
            Properties.getValue("DarkMode") as Boolean 
                ? 0xFFFFFF 
                : 0x000000, 
            Graphics.COLOR_TRANSPARENT
        );

        var moment = Time.now();
        var currentTime = Toybox.Time.Gregorian.info(moment, Time.FORMAT_SHORT);
        dc.drawText(
            dateCoordinate.X, 
            dateCoordinate.Y, 
            Graphics.FONT_XTINY, 
            Lang.format(
                "$1$/$2$/$3$", 
                [
                    currentTime.day.format("%02d"), 
                    currentTime.month.format("%02d"), 
                    currentTime.year.format("%02d").substring(2,4)
                ]
            ), 
            Graphics.TEXT_JUSTIFY_LEFT
        );
        
        // horizontal divider below date
        dc.drawLine(16, dateCoordinate.Y + 22, 100, dateCoordinate.Y + 22);

        // vertical divider before dow
        dc.drawLine(65, dateCoordinate.Y + 22, 65, clockCoordinate.Y+8);

        currentTime = Toybox.Time.Gregorian.info(moment, Time.FORMAT_MEDIUM);
        dc.drawText(
            dowCoordinate.X, 
            dowCoordinate.Y, 
            Graphics.FONT_XTINY, 
            Lang.format(
                "$1$", 
                [currentTime.day_of_week]
            ), 
            Graphics.TEXT_JUSTIFY_CENTER
        );

        // draw HR in circle
        dc.drawText(
            heartRateCoordinate.X, 
            heartRateCoordinate.Y, 
            Graphics.FONT_LARGE, 
            Lang.format(
                "$1$", 
                [heartRate]
            ), 
            Graphics.TEXT_JUSTIFY_CENTER
        );

        // horizontal divider before clock
        dc.drawLine(2, clockCoordinate.Y+8, 102, clockCoordinate.Y+8);

        // Get the current time and format it correctly
        var timeFormat = "$1$:$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        if (!deviceSettings.is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (Properties.getValue("UseMilitaryFormat") as Boolean) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);
        dc.drawText(
            clockCoordinate.X, 
            clockCoordinate.Y, 
            Graphics.FONT_NUMBER_THAI_HOT, 
            timeString, 
            Graphics.TEXT_JUSTIFY_RIGHT
        );

        if(!sleep && Properties.getValue("ShowSeconds") as Boolean)
        {
            var secondsTimeString = Lang.format(":$1$", [clockTime.sec.format("%02d")]);
            dc.drawText(
                secondsCoordinate.X, 
                secondsCoordinate.Y, 
                Graphics.FONT_SMALL, 
                secondsTimeString, 
                Graphics.TEXT_JUSTIFY_LEFT
            );
        }else
        {
            var secondsTimeString = "   ";
            dc.drawText(
                secondsCoordinate.X, 
                secondsCoordinate.Y, 
                Graphics.FONT_SMALL, 
                secondsTimeString, 
                Graphics.TEXT_JUSTIFY_LEFT
            );
        }

        // horizontal divider after clock
        dc.drawLine(2, clockCoordinate.Y + 52, 174, clockCoordinate.Y + 52);

        // vertical divider before steps
        dc.drawLine(
            stepsCoordinate.X - 23, 
            stepsCoordinate.Y + 3,  
            stepsCoordinate.X - 23, 
            stepsCoordinate.Y + 25
        );

        var stepsString = Lang.format("$1$", [steps]);
        dc.drawText(
            stepsCoordinate.X, 
            stepsCoordinate.Y, 
            Graphics.FONT_MEDIUM, 
            stepsString, 
            Graphics.TEXT_JUSTIFY_LEFT
        );

        // horizontal divider after steps
        dc.drawLine(
            2, 
            stepsCoordinate.Y + 25, 
            174, 
            stepsCoordinate.Y + 25
        );

        // solar intensity arc
        if(solarIntensity != 0){
            dc.setPenWidth(
                solarIntensity > 0
                    ? 5
                    : 10
            );
            dc.drawArc(
                solarIntensityCoordinate.X, 
                solarIntensityCoordinate.Y, 
                31, 
                solarIntensity > 0
                    ? Graphics.ARC_CLOCKWISE
                    : Graphics.ARC_COUNTER_CLOCKWISE, 
                90, 
                ((100 - solarIntensity) * 3.6) + 90
            );
        }
        dc.setPenWidth(1);

        // notification count and do not disturb
        if(doNotDisturb){
            dc.drawBitmap(
                notificationCountBitmapCoordinate.X, 
                notificationCountBitmapCoordinate.Y, 
                doNotDisturbBitmap
            );
            dc.drawText(
                notificationCountCoordinate.X, 
                notificationCountCoordinate.Y, 
                Graphics.FONT_MEDIUM, 
                "--", 
                Graphics.TEXT_JUSTIFY_LEFT
            );
        } else {
            var notificationCountString = Lang.format("$1$", [notificationCount]);
            dc.drawBitmap(
                notificationCountBitmapCoordinate.X, 
                notificationCountBitmapCoordinate.Y, 
                notificationCountBitmap
            );
            dc.drawText(
                notificationCountCoordinate.X, 
                notificationCountCoordinate.Y, 
                Graphics.FONT_MEDIUM, 
                notificationCountString, 
                Graphics.TEXT_JUSTIFY_LEFT
            );
        }

        // battery display
        dc.drawLine(
            2, batteryOutlineBitmapCoordinate.Y - 3, 
            174, batteryOutlineBitmapCoordinate.Y - 3
        );
        dc.drawLine(
            16, batteryOutlineBitmapCoordinate.Y + 17, 
            160, batteryOutlineBitmapCoordinate.Y + 17
        );
        dc.drawBitmap(
            batteryOutlineBitmapCoordinate.X, 
            batteryOutlineBitmapCoordinate.Y, 
            batteryOutlineBitmap
        );
        if(charging){
            dc.setColor(
                Properties.getValue("DarkMode") as Boolean 
                    ? 0x000000
                    : 0xFFFFFF, 
                 Properties.getValue("DarkMode") as Boolean 
                    ? 0xFFFFFF 
                    : 0x000000
            );
            dc.fillRectangle(
                batteryOutlineBitmapCoordinate.X + 4, 
                batteryOutlineBitmapCoordinate.Y + 2, 
                8, 
                11
            );
            dc.setColor(
                Properties.getValue("DarkMode") as Boolean 
                    ? 0xFFFFFF 
                    : 0x000000, 
                Graphics.COLOR_TRANSPARENT
            );
            dc.drawBitmap(
                batteryOutlineBitmapCoordinate.X + 1, 
                batteryOutlineBitmapCoordinate.Y, 
                boltBitmap
            );
        }else{
            dc.fillRectangle(
                batteryOutlineBitmapCoordinate.X + 3, 
                batteryOutlineBitmapCoordinate.Y + 6, 
                batteryWidth, 
                3
            );
        }


        dc.drawText(
            batteryCoordinate.X, 
            batteryCoordinate.Y, 
            Graphics.FONT_XTINY, 
            battery, 
            Graphics.TEXT_JUSTIFY_RIGHT
        );
        dc.drawText(
            batteryInDaysCoordinate.X, 
            batteryInDaysCoordinate.Y, 
            Graphics.FONT_XTINY, 
            batteryInDays, 
            Graphics.TEXT_JUSTIFY_LEFT
        );

        dc.drawBitmap(
            pressureBitmapCoordinate.X, 
            pressureBitmapCoordinate.Y, 
            pressureBitmap
        );
        dc.drawText(
            pressureCoordinate.X, 
            pressureCoordinate.Y, 
            Graphics.FONT_XTINY, 
            pressure, 
            Graphics.TEXT_JUSTIFY_LEFT
        );

        dc.drawLine(88, 114, 88, 133);

        dc.drawBitmap(
            altitudeBitmapCoordinate.X, 
            altitudeBitmapCoordinate.Y, 
            altitudeBitmap
        );
        dc.drawText(
            altitudeCoordinate.X, 
            altitudeCoordinate.Y, 
            Graphics.FONT_XTINY, 
            altitude, 
            Graphics.TEXT_JUSTIFY_LEFT
        );
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
