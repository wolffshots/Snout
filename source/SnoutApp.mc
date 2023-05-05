import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class SnoutApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        System.println("Start");
        System.println(state);
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        System.println("Stop");
        System.println(state);
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new SnoutView() ] as Array<Views or InputDelegates>;
    }
    
    // Return the settings menu
    function getSettingsView() as Array<Views or InputDelegates>? {
        return [ new SnoutSettingsMenu(), new SnoutSettingsMenuDelegate() ] as Array<Views or InputDelegates>;
    }

    // New app settings have been received so trigger a UI update
    function onSettingsChanged() as Void {
        WatchUi.requestUpdate();
    }

}

function getApp() as SnoutApp {
    return Application.getApp() as SnoutApp;
}