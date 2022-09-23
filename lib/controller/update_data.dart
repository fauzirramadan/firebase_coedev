import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_coedev/utils/my_snackbar.dart';
import 'package:flutter/material.dart';

class UpdateData {
  TextEditingController foodNameC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController stockC = TextEditingController();

  // snackbar
  MySnackbar snackbar = MySnackbar();

  // firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // update function
  Future<void> updateFood(String id, String nameFood, String price,
      String stock, BuildContext context) {
    CollectionReference food = firestore.collection("food");
    return food.doc(id).update(
        {'name': nameFood, 'price': price, 'stock': stock}).then((value) {
      log("food updated");
      // back to home
      Navigator.pop(context);
      // show snackbar
      ScaffoldMessenger.of(context)
          .showSnackBar(snackbar.mySnackbar("food updated", Colors.green));
    }).catchError((error) {
      log("failed when update food : $error");
      // shpw snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        snackbar.mySnackbar("failed updating food", Colors.red),
      );
    });
  }
}
