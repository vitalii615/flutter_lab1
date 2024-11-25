import 'package:flutter/material.dart';
import 'package:light_plugin/light_plugin.dart';

class LightUtils {
  static Future<void> turnLightOn(BuildContext context) async {
    try {
      await LightPlugin.toggleLight(true);
    } catch (e) {
      _showUnsupportedFeatureDialog(context);
    }
  }

  static Future<void> turnLightOff() async {
    try {
      await LightPlugin.toggleLight(false);
    } catch (e) {}
  }

  static void _showUnsupportedFeatureDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ліхтарик не увімкнеться'),
          content: const Text('Функціонал не підтримується на iOS.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Закрити'),
              onPressed: () {
                Navigator.of(context).pop(); // Закриваємо діалог
              },
            ),
          ],
        );
      },
    );
  }
}
