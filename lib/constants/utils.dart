import 'package:flutter/material.dart';

class Utils {
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