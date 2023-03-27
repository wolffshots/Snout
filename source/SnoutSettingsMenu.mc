import Toybox.Application.Storage;
import Toybox.Lang;
import Toybox.WatchUi;

//! The app settings menu
class SnoutSettingsMenu extends WatchUi.Menu2 {

    //! Constructor
    public function initialize() {
        Menu2.initialize({:title=>"Settings"});
    }
}

//! Input handler for the app settings menu
class SnoutSettingsMenuDelegate extends WatchUi.Menu2InputDelegate {

    //! Constructor
    public function initialize() {
        Menu2InputDelegate.initialize();
    }

    //! Handle a menu item being selected
    //! @param menuItem The menu item selected
    public function onSelect(menuItem as MenuItem) as Void {
        if (menuItem instanceof ToggleMenuItem) {
            Storage.setValue(menuItem.getId() as Number, menuItem.isEnabled());
        }
    }
}

