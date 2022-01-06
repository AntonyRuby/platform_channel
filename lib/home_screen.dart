import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const platform = MethodChannel('com.example.flutter/device_info');
  String deviceInfo = "";
  String encryptedData = '';
  String decryptedData = '';

  @override
  void initState() {
    _getDeviceInfo();

    super.initState();
  }

  Future<void> _getDeviceInfo() async {
    String result;
    try {
      platform.invokeMethod('getDeviceInfo').then((value) {
        result = value.toString();
        setState(() {
          deviceInfo = result;
        });
      });
    } on PlatformException catch (e) {
      print("_getDeviceInfo==>${e.message}");
    }
  }

  Future<void> getPrint() async {
    String value = '';

    try {
      value = await platform.invokeMethod('Print');
    } catch (e) {
      print(e);
    }

    print(value);
  }

  Future<void> encryption(String encrypted, String key) async {
    try {
      var result = await platform
          .invokeMethod('encrypt', {'data': encrypted, 'key': key});

      setState(() {
        encryptedData = result;
      });
    } on PlatformException catch (e) {
      print('${e.message}');
    }
  }

  Future<void> decryption(String encrypted, String key) async {
    try {
      var result = await platform.invokeMethod('decrypt', {
        'data': encrypted,
        'key': key,
      });

      setState(() {
        decryptedData = result;
      });
    } on PlatformException catch (e) {
      print('${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Device info')),
      ),
      body: Column(
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(deviceInfo),
          )),
          ElevatedButton(
              onPressed: () {
                getPrint();
              },
              child: const Text('Click Here')),
          ElevatedButton(
              onPressed: () {
                encryption('hello', 'hertllertoerdgfh');
              },
              child: const Text('Encryption')),
          const SizedBox(
            height: 10,
          ),
          Text(encryptedData),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                decryption(encryptedData, 'hertllertoerdgfh');
              },
              child: const Text('Decryption')),
          const SizedBox(
            height: 10,
          ),
          Text(decryptedData),
        ],
      ),
    );
  }
}
