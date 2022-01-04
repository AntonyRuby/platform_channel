import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let controller: FlutterViewController = window?.rootViewController as! FlutterViewController

      let CHANNEL = FlutterMethodChannel(name: "com.example.flutter/device_info", binaryMessenger: controller.binaryMessenger)

      CHANNEL.setMethodCallHandler { (methodCall, result)in

      if methodCall.method == "Print"{

      result("Hi")

      }

      }

//      GeneratedPluginRegistrant.register(with: self)

      return super.application(application, didFinishLaunchingWithOptions: launchOptions)



      }

      }
      
