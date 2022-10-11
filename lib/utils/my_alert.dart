import 'package:flutter/material.dart';

class MyAlertDialog {
  myAlertDialog(BuildContext context, String message, TextButton button) {
    // setup the button
    Widget okButton = button;

    AlertDialog alert = AlertDialog(
      title: const Text("Information"),
      content: Text(message),
      actions: [okButton],
    );

    // show the dialog
    showDialog(context: context, builder: (_) => alert);
  }
}
