import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();
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
                  "Forget Password",
                  style: TextStyle(
                    color: Colors.black,
                    // color: Theme.of(context).colorScheme.secondary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Enter Email",
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
                      // if(emailController!=null)
                      //   {
                      try {
                        if (emailController.text.toString().length > 9) {
                          FirebaseAuth.instance
                              .sendPasswordResetEmail(
                                  email: emailController.text.trim())
                              .then((value) => {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const LoginPage();
                                    })),
                                  });
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Email Sent please check your email")));
                          log("Email Sent");
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Missing email")));
                        }
                      } on FirebaseAuthException catch (ex) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(ex.message.toString())));
                        log("Missing email${ex.message}");
                      }

                      // }
                      // else
                      //   {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //         const SnackBar(content: Text("Enter email"))
                      //     );
                      //     log("Enter email");
                      //   }
                    },
                    child: const Text("Submit")),
                /*
                    CupertinoButton(
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: (){
                          try{
                             FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim()).then((value) => {
                             Navigator.push(
                                   context,
                                   MaterialPageRoute(builder: (context){
                                     return const LoginPage();
                                   }
                                   )
                               ),
                             });
                           log("Email Sent");
                          }on FirebaseAuthException catch(ex){
                            ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(content: Text(ex.message.toString()))
                            );
                             log(ex.message.toString());
                          }

                          // checkValue();
                          // if(b) {
                          //   Navigator.popUntil(context, (route) => route.isFirst);
                          //   Navigator.pushReplacement(
                          //       context,
                          //       MaterialPageRoute(builder: (context){
                          //         return const HomePage();
                          //       }
                          //       )
                          //   );
                          // }

                        },
                        child:  const Text("Submit")
                    ),

                     */
              ],
            ),
          ),
        )),
      ),

      // bottomNavigationBar: Container(
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       const Text("Don't have an account",
      //         style: TextStyle(fontSize: 16),),
      //
      //       CupertinoButton(child: const Text("Sign Up",
      //         style: TextStyle(
      //             fontSize: 16
      //         ),
      //       ),
      //           onPressed: (){
      //             Navigator.push(
      //                 context,   // Current context
      //                 MaterialPageRoute(builder: (context){
      //                   return const SignUp();
      //                 }
      //                 )
      //             );
      //
      //           }),
      //
      //     ],
      //   ),
      // ),
    );
  }
}
