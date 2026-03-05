import 'dart:io';

import 'package:flutter/material.dart';

class Utils {
  static Future<bool> isConnected() async {
    try {
      List<InternetAddress> result = await InternetAddress.lookup(
          'google.com') /*.timeout(Duration(seconds: 5))*/;

      //
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      //
      else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static void onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                new CircularProgressIndicator(),
                SizedBox(
                  width: 10,
                ),
                new Text("Loading"),
              ],
            ),
          ),
        );
      },
    );
  }
  static void showToast(
      BuildContext context, {
        required String message,
        Color backgroundColor = Colors.black87,
        Color textColor = Colors.white,
        int durationSeconds = 2,
      }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: backgroundColor,
        duration: Duration(seconds: durationSeconds),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}