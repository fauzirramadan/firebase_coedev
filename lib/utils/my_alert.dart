import 'package:flutter/material.dart';

class MyAlertDialog {
  myAlertDialog(BuildContext context, String message, TextButton button,
      {TextButton? cancelButton}) {
    // setup the button
    Widget okButton = button;
    Widget? noButton = cancelButton;

    AlertDialog alert = AlertDialog(
      title: const Text("Information"),
      content: Text(message),
      actions: [okButton, noButton!],
    );

    // show the dialog
    showDialog(context: context, builder: (_) => alert);
  }
}
