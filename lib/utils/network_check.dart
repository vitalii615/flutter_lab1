import 'dart:io';
import 'package:flutter/material.dart';

class NetworkCheck {
  static Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }
}

void showNoInternetDialog(BuildContext context, String title, String content) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title, style: const TextStyle(color: Colors.red)),
        content: Text(content, style: const TextStyle(color: Colors.black),),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              final bool isConnected = await NetworkCheck.isConnected();
              if (isConnected) {
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Інтернет досі недоступний!')),
                );
              }
            },
            child: const Text('Refresh'),
          ),
        ],
      );
    },
  );
}
