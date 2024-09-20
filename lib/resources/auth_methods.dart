import 'package:alert_us/main.dart';
import 'package:alert_us/utils/global_variable.dart';
import 'package:alert_us/models/user.dart' as app_user;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<app_user.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return app_user.User.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String cPassword,
    required String username,
    required String locationNickname,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          cPassword.isNotEmpty ||
          locationNickname.isNotEmpty) {
        // Register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        // Add user to database
        app_user.User user = app_user.User(
          locationNickname: locationNickname,
          address: address,
          username: username,
          uid: deviceToken,
          // deviceToken: deviceToken,
        );

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "success";
        result = true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        res = 'The email address is badly formatted.';
      } else if (e.code == 'weak-password') {
        res = 'Password should be at least 6 characters';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}