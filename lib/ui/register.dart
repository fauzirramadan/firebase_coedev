import 'package:firebase_coedev/ui/login.dart';
import 'package:flutter/material.dart';

import '../auth/auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text("SIGN UP"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Form(
        key: keyForm,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: ListView(
              children: [
                SizedBox(
                  height: 230,
                  child: Image.asset("assets/images/register.png"),
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
                      fillColor: Colors.black.withOpacity(0.2),
                      filled: true,
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
                  controller: password,
                  decoration: InputDecoration(
                      fillColor: Colors.black.withOpacity(0.1),
                      filled: true,
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
                      auth.registerUser(email.text, password.text, context);
                    }
                  },
                  minWidth: double.infinity,
                  height: 55,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.yellow,
                  child: const Text(
                    "REGISTER",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false),
                  child: const Center(
                    child: Text(
                      "Already have an account? login here",
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
