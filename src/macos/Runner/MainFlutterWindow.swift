import Cocoa
import FlutterMacOS

import desktop_multi_window
import device_info_plus
import flutter_local_notifications
import flutter_webrtc
import livekit_client
import package_info_plus
import path_provider_foundation
import screen_retriever
import shared_preferences_foundation
import wakelock_plus
import window_manager
import connectivity_plus
import share_plus

class MainFlutterWindow: NSWindow {
    override func awakeFromNib() {
        let flutterViewController = FlutterViewController()
        let windowFrame = self.frame
        self.contentViewController = flutterViewController
        self.setFrame(windowFrame, display: true)
        
        RegisterGeneratedPlugins(registry: flutterViewController)
        
        FlutterMultiWindowPlugin.setOnWindowCreatedCallback { controller in
            // Register the plugin which you want access from other isolate.
            ConnectivityPlusPlugin.register(with: controller.registrar(forPlugin: "ConnectivityPlusPlugin"))
            DeviceInfoPlusMacosPlugin.register(with: controller.registrar(forPlugin: "DeviceInfoPlusMacosPlugin"))
            FlutterLocalNotificationsPlugin.register(with: controller.registrar(forPlugin: "FlutterLocalNotificationsPlugin"))
            FlutterWebRTCPlugin.register(with: controller.registrar(forPlugin: "FlutterWebRTCPlugin"))
            LiveKitPlugin.register(with: controller.registrar(forPlugin: "LiveKitPlugin"))
            FPPPackageInfoPlusPlugin.register(with: controller.registrar(forPlugin: "FPPPackageInfoPlusPlugin"))
            PathProviderPlugin.register(with: controller.registrar(forPlugin: "PathProviderPlugin"))
            ScreenRetrieverPlugin.register(with: controller.registrar(forPlugin: "ScreenRetrieverPlugin"))
            SharePlusMacosPlugin.register(with: controller.registrar(forPlugin: "SharePlusMacosPlugin"))
            SharedPreferencesPlugin.register(with: controller.registrar(forPlugin: "SharedPreferencesPlugin"))
            WakelockPlusMacosPlugin.register(with: controller.registrar(forPlugin: "WakelockPlusMacosPlugin"))
        }
        super.awakeFromNib()
    }
    
    override public func order(_ place: NSWindow.OrderingMode, relativeTo otherWin: Int) {
        super.order(place, relativeTo: otherWin)
        hiddenWindowAtLaunch()
    }
    
    public func setWindowInterfaceMode(window: NSWindow, themeName: String) {
        window.appearance = NSAppearance(named: themeName == "light" ? .aqua : .darkAqua)
    }
}
