import 'package:alert_us/utils/location.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Authentication/Auth/forget_password.dart';
import '../Authentication/Auth/login.dart';

class DashboardScreen extends StatefulWidget {
  final String uid;

  // const DashboardScreen({super.key, required this.uid});

  const DashboardScreen({super.key, required this.uid});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    // TODO: initialize profile image URL from user data using widget.uid
  }

  void _onChooseProfilePicturePressed() {
    // TODO: implement choosing a profile picture
    setState(() {
      // Simulate setting the profile image to a chosen image
      _profileImageUrl = 'https://example.com/profile.jpg';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: const Text('Dashboard'),
        backgroundColor: Colors.black,
        shadowColor: Colors.cyan,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _onChooseProfilePicturePressed,
              child: CircleAvatar(
                backgroundImage: _profileImageUrl != null
                    ? NetworkImage(_profileImageUrl!)
                    : null,
                radius: 60,
                child: _profileImageUrl == null
                    ? const Icon(Icons.add_a_photo)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            const Text('Profile',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
            const SizedBox(height: 20),
            Text(
              '\n Name:  ${FirebaseAuth.instance.currentUser!.displayName} \n\n Email:  ${FirebaseAuth.instance.currentUser!.email} ',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              // Navigator.pop(context);
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LocationPage()))
                    .then((result) {}),
                // onPressed: () => Navigator.of(context).pushReplacement(
                //         MaterialPageRoute(builder: (context) {
                //       return LocationPage();
                //     })),
                child: const Text('Update your location')
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return const ForgetPassword();
                    }));
              },
              child: const Text("Change your Password"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed:(){
              FirebaseAuth.instance.signOut();
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context){
                  return  const LoginPage();
                }
                ));
              },
              child: const Text('LOGOUT'),
            ),
          ],
        ),
      ),
    );
  }
}
