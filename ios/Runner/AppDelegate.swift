import UIKit
import Flutter
import Foundation
import CryptoSwift

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let controller: FlutterViewController = window?.rootViewController as! FlutterViewController

      let platform = FlutterMethodChannel(name: "com.example.flutter/device_info", binaryMessenger: controller.binaryMessenger)

      platform.setMethodCallHandler({
        [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
//          if call.method == "getDeviceInfo" {
//                     self?.deviceInfo(result: result)
//                 }
//         else
             if(call.method == "encrypt"){
                guard let args = call.arguments as? [String : Any] else {return}
                let data = args["data"] as! String
                let key = args["key"] as! String
                let encryptedString = CryptoHelper.encrypt(dataFromFlutter: data, keyFromFlutter: key)
                self?.encrypt(result: result, encrypted: encryptedString!)
                return
            }else if(call.method == "decrypt"){
                             guard let args = call.arguments as? [String : Any] else {return}
                             let data = args["data"] as! String
                             let key = args["key"] as! String
                             let decryptedString = CryptoHelper.decrypt(dataFromFlutter: data, keyFromFlutter: key)
                             self?.decrypt(result: result, decrypted: decryptedString!)
                             return
                         }else {
                             result(FlutterMethodNotImplemented)
                             return
                           }
             
             
          
      });

//      GeneratedPluginRegistrant.register(with: self)

      return super.application(application, didFinishLaunchingWithOptions: launchOptions)

      }
    
    private func encrypt(result: FlutterResult, encrypted: String) {
            result(encrypted)
        }

        private func decrypt(result: FlutterResult, decrypted: String) {
            result(decrypted)
        }
}

var keyValue :String!

class CryptoHelper{
    private static let iv = "hertllertoer";
    // ENCRYPTION
    public static func encrypt(dataFromFlutter :String, keyFromFlutter :String) -> String? {
        
        
        print(dataFromFlutter);
        print(keyFromFlutter);
        
        do{
            let encrypted: Array<UInt8> = try AES(key: keyFromFlutter, iv: iv, padding: .pkcs5).encrypt(Array(dataFromFlutter.utf8))
            return encrypted.toBase64()
        }catch{
            return "DATA ERROR"
        }
    }

    // DECRYPTION
    public static func decrypt(dataFromFlutter :String, keyFromFlutter :String) -> String? {
        do{
            let data = Data(base64Encoded: dataFromFlutter)
            let decrypted = try AES(key: keyFromFlutter, iv: iv, padding: .pkcs5).decrypt(data!.bytes)
            return String(data: Data(decrypted), encoding: .utf8)
        }catch{
            return "DATA ERROR"
        }
    }
}

