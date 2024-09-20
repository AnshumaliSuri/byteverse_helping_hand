// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:alert_us/Authentication/Auth/signUp.dart';
import 'package:alert_us/main.dart';
import 'package:alert_us/responsive/mobile_screen_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'forget_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool? value = false;
  bool checkValue() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email == "" || password == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill all the field")));
      log("Please fill all the field");
      return false;
    } else {
      logIn(email, password);
      return true;
    }
  }

  UserCredential? credential;
  bool b = false;
  void logIn(String email, String password) async {
    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential?.user != null) {
        b = true;
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Login successful")));
    } on FirebaseAuthException catch (ex) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(ex.message.toString())));
      log(ex.message.toString());
    }
  }

  Future<void> getDeviceTokenToSendNotification()async{
    final firebaseMessaging  = FirebaseMessaging.instance;
    final token = await firebaseMessaging.getToken();
    deviceToken=token.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.pink.shade50, Colors.white],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
          stops: const [0.0, 1.0],
          tileMode: TileMode.clamp,
        )),
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: (Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Login",
                  style: TextStyle(
                    // color: Theme.of(context).colorScheme.secondary,
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CupertinoButton(
                    child: const Text(
                      "Create an account",
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      getDeviceTokenToSendNotification();
                      Navigator.push(context, // Current context
                          MaterialPageRoute(builder: (context) {
                        return const SignUp();
                      }));
                    }),
                // const Text("User Email",style: TextStyle(color: Colors.black,leadingDistribution: TextLeadingDistribution.proportional),),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Enter your email",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Enter your password",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size.fromHeight(50), // NEW
                    ),
                    onPressed: () {
                      checkValue();
                      if (b) {
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const MobileScreenLayout();
                        }));
                      }
                    },
                    child: const Text("Login")),
                const SizedBox(
                  height: 15,
                ),

                const SizedBox(
                  height: 40,
                ),
                CupertinoButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ForgetPassword();
                    }));
                  },
                  child: const Text("Forget Password"),
                ),
              ],
            ),
          ),
        )),
      ),
      bottomNavigationBar: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "©2022 - 2023 All Rights Reserved",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
