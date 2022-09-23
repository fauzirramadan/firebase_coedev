import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_coedev/auth/auth.dart';
import 'package:firebase_coedev/ui/home.dart';
import 'package:firebase_coedev/ui/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  // make sure to initialized firebase here
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Auth auth = Auth();
    return StreamBuilder<User?>(
        stream: auth.streamAuthStatus,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            log(snapshot.data.toString());
            return MaterialApp(
              title: 'Firebase Coedev',
              theme: ThemeData(
                primarySwatch: Colors.yellow,
              ),
              home:
                  snapshot.data != null && snapshot.data!.emailVerified == true
                      ? const Home()
                      : const LoginScreen(),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
