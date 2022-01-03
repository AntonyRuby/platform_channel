package com.example.platform_chanel

import io.flutter.embedding.android.FlutterActivity

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "flutter.native/help";
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodChannel.MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                if (call.method.equals("helloFromNativeCode")) {
                  String greetings = helloFromNativeCode();
                  result.success(greetings);
                }
              }});
  }
private String helloFromNativeCode() {
    return "Hello from Native Android Code";
  }
}
