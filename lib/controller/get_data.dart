import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_coedev/utils/my_snackbar.dart';
import 'package:flutter/material.dart';

class GetDataController {
  // firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // snackbar
  MySnackbar snackbar = MySnackbar();

  // get data function
  Stream<QuerySnapshot<Object?>> getData() {
    CollectionReference dataFood = firestore.collection("food");
    return dataFood.snapshots();
  }

  // delete data
  Future<void> deleteFood(String id, BuildContext context) async {
    CollectionReference food = firestore.collection("food");
    return await food.doc(id).delete().then((value) {
      log("food deleted");
      // show snackbar
      ScaffoldMessenger.of(context)
          .showSnackBar(snackbar.mySnackbar("Food deleted", Colors.green));
    }).catchError((error) {
      log("Failed to delete food: $error");
      // show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
          snackbar.mySnackbar("Failed to delete food: $error", Colors.red));
    });
  }
}
