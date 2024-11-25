import 'package:light_plugin/light_plugin.dart';

class LightUtils {
  static Future<void> turnLightOn() async {
    try {
      await LightPlugin.toggleLight(true);
    } catch (e) {
    
    }
  }

  static Future<void> turnLightOff() async {
    try {
      await LightPlugin.toggleLight(false);
    } catch (e) {
      
    }
  }
}
