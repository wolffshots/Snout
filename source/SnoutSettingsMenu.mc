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
        Menu2.addItem(new WatchUi.ToggleMenuItem(Rez.Strings.DarkModeTitle, Rez.Strings.DarkModeSubtitle, "DarkMode", darkMode, null));

        var militaryTime = Properties.getValue("UseMilitaryFormat") as Boolean;
        Menu2.addItem(new WatchUi.ToggleMenuItem(Rez.Strings.MilitaryFormatTitle, Rez.Strings.MilitaryFormatSubtitle, "UseMilitaryFormat", militaryTime, null));
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
        System.println("selecting: " + menuItem);
        if (menuItem instanceof ToggleMenuItem) {
            // Storage.setValue(menuItem.getId() as Number, menuItem.isEnabled());
            Properties.setValue(menuItem.getId(), menuItem.isEnabled());
        }
    }
}

