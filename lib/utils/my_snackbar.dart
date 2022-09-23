import 'package:flutter/material.dart';

class MySnackbar {
  SnackBar mySnackbar(String message, Color color) => SnackBar(
        content: Text(message),
        backgroundColor: color,
      );
}
