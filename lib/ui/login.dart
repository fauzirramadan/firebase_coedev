import 'package:firebase_coedev/auth/auth.dart';
import 'package:firebase_coedev/ui/home.dart';
import 'package:firebase_coedev/ui/register.dart';
import 'package:firebase_coedev/utils/my_snackbar.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // calll auth class
  Auth auth = Auth();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  // snackbar
  MySnackbar snackbar = MySnackbar();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: const Text("SIGN IN"),
      ),
      body: Form(
        key: keyForm,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: ListView(
              children: [
                SizedBox(
                  height: 200,
                  child: Image.asset("assets/images/login.png"),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    return email.value.text.isEmpty ? "Cannot be empty" : null;
                  },
                  controller: email,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.1),
                      prefixIcon: const Icon(
                        Icons.mail,
                        color: Colors.black,
                      ),
                      labelStyle: const TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.black)),
                      label: const Text("Email"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    return password.value.text.isEmpty
                        ? "Cannot be empty"
                        : null;
                  },
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.1),
                      prefixIcon: const Icon(
                        Icons.security_outlined,
                        color: Colors.black,
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.black)),
                      label: const Text("Password"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    if (keyForm.currentState!.validate()) {
                      auth.loginUser(email.text, password.text, context);
                    }
                  },
                  minWidth: double.infinity,
                  height: 55,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.yellow,
                  child: const Text(
                    "SIGN IN",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    if (email.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(snackbar
                          .mySnackbar("Please fill your email", Colors.red));
                    }
                    auth.resetPassword(email.text, context);
                  },
                  child: const Center(
                      child: Text(
                    "Forgot Password? klik here",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RegisterScreen())),
                  child: const Center(
                    child: Text(
                      "Dont have any account? sign up here",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
