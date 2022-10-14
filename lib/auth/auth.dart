// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_coedev/ui/login.dart';
import 'package:firebase_coedev/utils/my_alert.dart';
import 'package:firebase_coedev/utils/my_snackbar.dart';
import 'package:flutter/material.dart';

import '../ui/home.dart';
import '../utils/navigator_helper.dart';

class Auth {
  // alert class
  MyAlertDialog alert = MyAlertDialog();

  // firebase instance
  FirebaseAuth auth = FirebaseAuth.instance;

  // Stream user status
  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  // sign up/ register function
  Future<void> registerUser(
      String email, String password, BuildContext context) async {
    try {
      UserCredential myUser = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // send email verification
      await myUser.user!.sendEmailVerification();
      // show alert dialog
      alert.myAlertDialog(
        context,
        "Email verification has send to $email",
        TextButton(
          onPressed: () {
            // show snackbar
            ScaffoldMessenger.of(context)
                .showSnackBar(mySnackbar("Register Success", Colors.green));
            // go to login
            navigateRemoveUntil(context, const LoginScreen());
          },
          child: const Text("Ok, I'll check it"),
        ),
      );
      // catch an error
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
        // show snackbar
        ScaffoldMessenger.of(context).showSnackBar(
            mySnackbar("The password provided is too weak", Colors.red));
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        // show snackbar
        ScaffoldMessenger.of(context).showSnackBar(mySnackbar(
            "The account already exists for that email", Colors.red));
      } else {
        log(e.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(mySnackbar("$e", Colors.red));
      }
    }
  }

  // login function
  Future<void> loginUser(
      String email, String password, BuildContext context) async {
    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (myUser.user!.emailVerified) {
        // show snackbar
        ScaffoldMessenger.of(context)
            .showSnackBar(mySnackbar("Login Success", Colors.green));
        // go to home
        navigateRemoveUntil(context, const Home());
      } else {
        // show alert
        alert.myAlertDialog(
          context,
          "Your email has not been verified, please check your mail box",
          TextButton(
            onPressed: () async {
              await myUser.user!.sendEmailVerification();
              // back
              Navigator.pop(context);
              // show snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                  mySnackbar("Email verification has been send", Colors.green));
            },
            child: const Text(
              "Resend email verification",
              style: TextStyle(color: Colors.black),
            ),
          ),
        );
      }
      // catch an error
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
        // show snackbar
        ScaffoldMessenger.of(context).showSnackBar(
            mySnackbar("No user found for that email", Colors.red));
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
        // show snackbar
        ScaffoldMessenger.of(context).showSnackBar(
            mySnackbar("Wrong password provided for that user", Colors.red));
      } else {
        // show snackbar
        ScaffoldMessenger.of(context)
            .showSnackBar(mySnackbar(e.toString(), Colors.red));
      }
    }
  }

  // logout function
  Future<void> logoutUser(BuildContext context) async {
    await auth.signOut();
    // go to login screen
    navigateRemoveUntil(context, const LoginScreen());
  }

  // reset password
  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(mySnackbar(
          "Reset password email has been send to $email", Colors.green));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(mySnackbar(e.toString(), Colors.red));
    }
  }
}
