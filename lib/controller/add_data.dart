import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_coedev/utils/my_snackbar.dart';
import 'package:flutter/material.dart';

class AddDataController {
  TextEditingController foodNameC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController stockC = TextEditingController();

  void dispose() {
    foodNameC.dispose();
    priceC.dispose();
    stockC.dispose();
  }

  // my snackbar
  MySnackbar snackbar = MySnackbar();

  // firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // add data function
  Future<void> addDataFood(
      String name, String price, String stock, BuildContext context) async {
    // collection reference
    CollectionReference dataFood = firestore.collection("food");
    return dataFood
        .add({'name': name, 'price': price, 'stock': stock}).then((value) {
      log("Food Added");
      // clear text field
      foodNameC.clear();
      priceC.clear();
      stockC.clear();
      // back to main page
      Navigator.pop(context);
      // show snackbar
      ScaffoldMessenger.of(context)
          .showSnackBar(snackbar.mySnackbar("Food Added", Colors.green));
    }).catchError((error) {
      log("Failed to add food: $error");
      // show snackbar
      ScaffoldMessenger.of(context)
          .showSnackBar(snackbar.mySnackbar("$error", Colors.red));
    });
  }
}
