package com.example.platform_chanel
import android.util.Base64
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.security.NoSuchAlgorithmException
import java.util.*
import javax.crypto.Cipher
import javax.crypto.NoSuchPaddingException
import javax.crypto.spec.IvParameterSpec
import javax.crypto.spec.SecretKeySpec

//class MainActivity : FlutterActivity() {
//    private val platform = "com.example.flutter/device_info" // Unique Channel
//
//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, platform).setMethodCallHandler {
//            // Note: this method is invoked on the main thread.
//            call, result ->
//            if (call.method == "getDeviceInfo") {
//                val deviceInfo: HashMap<String, String> = getDeviceInfo()
//                if (deviceInfo.isNotEmpty()) {
//                    result.success(deviceInfo)
//                } else {
//                    result.error("UNAVAILABLE", "Device info not available.", null)
//                }
//                 if (call.method.equals("encrypt")) {
//                    val data = call.argument<String>("data")
//                    val key = call.argument<String>("key")
//                    val cipher = CryptoHelper.encrypt(data, key)
//                    result.success(cipher)
//
//                } else if (call.method.equals("decrypt")) {
//                    val data = call.argument<String>("data")
//                    val key = call.argument<String>("key")
//                    val jsonString = CryptoHelper.decrypt(data, key)
//                    result.success(jsonString)
//                }
//            } else {
//                result.notImplemented()
//            }
//
//        }
//    }
//
//    private fun getDeviceInfo(): HashMap<String, String> {
//        var deviceInfo = HashMap<String, String>()
//        deviceInfo.put("version",System.getProperty("os.version").toString()  )
//
//
////        deviceInfo["version"] = System.getProperty("os.version").toString() // OS version
////        deviceInfo["device"] = android.os.Build.DEVICE     // Device
////        deviceInfo["model"] = android.os.Build.MODEL            // Model
////        deviceInfo["product"] = android.os.Build.PRODUCT          // Product
//        return deviceInfo
//    }
//}


class MainActivity : FlutterActivity() {

    private val platform = "com.example.flutter/device_info"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, platform).setMethodCallHandler { call, result ->
            if (call.method.equals("encrypt")) {
                val data = call.argument<String>("data")
                val key = call.argument<String>("key")
                val cipher = CryptoHelper.encrypt(data, key)
                result.success(cipher)
            } else if (call.method.equals("decrypt")) {
                val data = call.argument<String>("data")
                val key = call.argument<String>("key")
                val jsonString = CryptoHelper.decrypt(data, key)
                result.success(jsonString)
            } else {
                result.notImplemented()
            }
        }
    }
}


