// import Toybox.Application.Storage;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application.Properties;

//! The app settings menu
class SnoutSettingsMenu extends WatchUi.Menu2 {

    //! Constructor
    function initialize() {
        Menu2.initialize(null);
        Menu2.setTitle("Settings");
        var darkMode = Properties.getValue("DarkMode") as Boolean;
        Menu2.addItem(
            new WatchUi.ToggleMenuItem(
                Rez.Strings.DarkModeTitle, 
                Rez.Strings.DarkModeSubtitle, 
                "DarkMode", 
                darkMode, 
                null
            )
        );

        var militaryTime = Properties.getValue("UseMilitaryFormat") as Boolean;
        Menu2.addItem(
            new WatchUi.ToggleMenuItem(
                Rez.Strings.MilitaryFormatTitle, 
                Rez.Strings.MilitaryFormatSubtitle, 
                "UseMilitaryFormat", 
                militaryTime, 
                null
            )
        );

        var showSeconds = Properties.getValue("ShowSeconds") as Boolean;
        Menu2.addItem(
            new WatchUi.ToggleMenuItem(
                Rez.Strings.SecondsDisplayTitle, 
                Rez.Strings.SecondsDisplaySubtitle, 
                "ShowSeconds", 
                showSeconds, 
                null
            )
        );

        var useFarenheit = Properties.getValue("UseFarenheit") as Boolean;
        Menu2.addItem(
            new WatchUi.ToggleMenuItem(
                Rez.Strings.UseFarenheitTitle, 
                Rez.Strings.UseFarenheitSubtitle, 
                "UseFarenheit", 
                useFarenheit, 
                null
            )
        );

        var showLines = Properties.getValue("ShowLines") as Boolean;
        Menu2.addItem(
            new WatchUi.ToggleMenuItem(
                Rez.Strings.ShowLinesTitle, 
                Rez.Strings.ShowLinesSubtitle, 
                "ShowLines", 
                showLines, 
                null
            )
        );

        var showEnvironment = Properties.getValue("ShowEnvironment") as Boolean;
        Menu2.addItem(
            new WatchUi.ToggleMenuItem(
                Rez.Strings.ShowEnvironmentTitle, 
                Rez.Strings.ShowEnvironmentSubtitle, 
                "ShowEnvironment", 
                showEnvironment, 
                null
            )
        );
    }    
}

//! Input handler for the app settings menu
class SnoutSettingsMenuDelegate extends WatchUi.Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
        System.println("initialize settings menu delegate");
    }
  	
  	function onBack() {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }

    function onDone() {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }

    //! Handle a menu item being selected
    //! @param menuItem The menu item selected
    public function onSelect(menuItem as MenuItem) as Void {
        if (menuItem instanceof ToggleMenuItem) {
            System.println("selecting: " + menuItem.getId() + " - " + menuItem.isEnabled());
            Properties.setValue(menuItem.getId(), menuItem.isEnabled());
        } else {
            System.println("selecting item that isn't a toggle" + menuItem.getId());
        }
    }
}

