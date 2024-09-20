import 'package:alert_us/provider/user_provider.dart';
import 'package:alert_us/responsive/mobile_screen_layout.dart';

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Authentication/Auth/login.dart';
import 'firebase_options.dart';
String deviceToken="token";
bool result=false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const  MobileScreenLayout();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            }
            return  const LoginPage();
          },
        ),
      ),
    );
  }
}

// class StartingPage extends StatelessWidget {
//   const StartingPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         // child: Image.asset('assets/images/Ecommerce.jpg'),
//         // child: Image.asset('images/Ecommerce.jpg',fit: BoxFit.cover,scale: 1.0,),
//         child: const Icon(
//           Icons.start,
//           size: 50,
//           color: Colors.lightGreen,
//         ),
//       ),
//     );
//   }
// }
