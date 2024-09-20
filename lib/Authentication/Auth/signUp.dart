// ignore_for_file: prefer_final_fields, use_build_context_synchronously

import 'package:alert_us/responsive/mobile_screen_layout.dart';
import 'package:alert_us/utils/location.dart';
import 'package:alert_us/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import 'login.dart';
import 'package:alert_us/resources/auth_methods.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _locationNickname = TextEditingController();

  // ignore: unused_field
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ignore: unused_field
  bool _isLoading = false;
  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: emailController.text,
      password: passwordController.text,
      username: _username.text,
      cPassword: cPasswordController.text,
      locationNickname: _locationNickname.text,
    );
    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MobileScreenLayout()),
      );
    }
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
                  "Create new account",
                  style: TextStyle(
                    // color: Theme.of(context).colorScheme.secondary,
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
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
                  controller: _username,
                  obscureText: false,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    prefixIcon: Icon(
                      Icons.verified_user,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _locationNickname,
                  decoration: const InputDecoration(
                    labelText: "Enter your location nickname",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    prefixIcon: Icon(
                      Icons.location_city,
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
                    labelText: "Password",
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
                  height: 15,
                ),
                TextField(
                  controller: cPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    prefixIcon: Icon(
                      Icons.password_rounded,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    // Navigator.pop(context);
                    onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LocationPage()))
                        .then((result) {}),

                    child: const Text('Set your location')),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
  backgroundColor: Colors.black,
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  onPressed: () {
                    signUpUser();
                    if(result){
                      Navigator.pop(context);
                      Navigator.push(context, // Current context
                          MaterialPageRoute(builder: (context) {
                            return const MobileScreenLayout();
                          }));

                    }
                  },
                  child: const Text("Sign Up"),
                ),
              ],
            ),
          ),
        )),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Already have an account?",
            style: TextStyle(fontSize: 16),
          ),
          CupertinoButton(
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.push(context, // Current context
                    MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }));
              }),
        ],
      ),
    );
  }
}


