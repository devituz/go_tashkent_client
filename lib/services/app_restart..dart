import 'package:flutter/services.dart';

class AppRestart {
  static const _channel = MethodChannel("app/restart");

  static Future<void> restartApp() async {
    try {
      await _channel.invokeMethod("restartApp");
    } on PlatformException catch (e) {
      print("Restart xatolik: $e");
    }
  }
}
