import 'package:flutter/material.dart';

SnackBar mySnackbar(String message, Color color) => SnackBar(
      content: Text(message),
      backgroundColor: color,
    );
