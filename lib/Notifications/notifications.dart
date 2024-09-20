import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class NotificationPage {
  static void sendNotifications(String token) async {
    var data = {
      'to': token,
      'priority': 'high',
      'notification': {
        'title': 'akk notification title',
        'body': 'body of kartik..',
      }
    };
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'key=AAAA6TYmOT4:APA91bGYUOVvsOjT5L85oduaS82De-MNS49BFRdC8eI0cK4U995u7fmMdIBueNLjO2ioBF-X9Mh5DUqfMTJDKJWYIn6Mk-xXwwWKQs6LZKwhlYqzZNbnYLpvc6ND4DHXp1jO3t59SkbM',
        });
    print("message send");
  }

  static double userLatitude = 0;
  static double userLongitude = 0;
  static Future<Object?> fetchLocationData() async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        // .doc('t6ES3mRL6XRyp47WlPTs91JGTlv1')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (docSnapshot.exists) {
      userLatitude = docSnapshot['address'][0];
      userLongitude = docSnapshot['address'][1];
      return docSnapshot.data();
    } else {
      print("nothing");
      return null;
    }
  }

  static Future<void> fetchAllUsersData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        double radius = DistanceCalculator.calculateDistance(
            userLatitude,
            userLongitude,
            double.parse(doc['address'][0]),
            double.parse(doc['address'][1]));
        if (radius <= 1000) {
          sendNotifications(doc['uid']);
        }
      }
    } else {
      print("No users found.");
    }
  }
}

class DistanceCalculator {
  static const double earthRadius = 6371; // Earth's radius in kilometers
  static double calculateDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLon) {
    double dLat = _degreesToRadians(endLatitude - startLatitude);
    double dLon = _degreesToRadians(endLon - startLongitude);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(startLatitude)) *
            cos(_degreesToRadians(endLatitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;
    return distance;
  }

  static double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }
}




//
// class Notifications extends StatefulWidget {
//   const Notifications({Key? key}) : super(key: key);
//   @override
//   State<Notifications> createState() => _NotificationsState();
// }
// class _NotificationsState extends State<Notifications> {
//   void sendNotifications(String token) async{
//     var data={
//       'to':token,
//       'priority':'high',
//       'notification':{
//         'title':'akk notification title',
//         'body':'body of kartik..',
//       }
//     };
//     await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
//         body:jsonEncode(data),
//         headers: {
//           'Content-Type':'application/json; charset=UTF-8',
//           'Authorization':'key=AAAA6TYmOT4:APA91bGYUOVvsOjT5L85oduaS82De-MNS49BFRdC8eI0cK4U995u7fmMdIBueNLjO2ioBF-X9Mh5DUqfMTJDKJWYIn6Mk-xXwwWKQs6LZKwhlYqzZNbnYLpvc6ND4DHXp1jO3t59SkbM',
//         }
//     );
//     print("message send");
//   }
//   double userLatitude=0;
//   double userLongitude=0;
//   Future<Object?> fetchLocationData() async {
//     DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
//         .collection('users')
//         // .doc('t6ES3mRL6XRyp47WlPTs91JGTlv1')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .get();
//     if (docSnapshot.exists) {
//       userLatitude=docSnapshot['address'][0];
//       userLongitude=docSnapshot['address'][1];
//       return docSnapshot.data();
//     } else {
//       print("nothing");
//       return null;
//     }
//   }
//
//   Future<void> fetchAllUsersData() async {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('users')
//         .get();
//      if (querySnapshot.docs.isNotEmpty) {
//       querySnapshot.docs.forEach((doc) {
//         double radius=DistanceCalculator.calculateDistance(userLatitude, userLongitude, double.parse(doc['address'][0]) , double.parse(doc['address'][1]));
//         if(radius<=1000){
//           sendNotifications(doc['uid']);
//         }
//       });
//     } else {
//       print("No users found.");
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(onPressed: (){
//         // sendPushNotification("aaa","Title","Body");
//         fetchAllUsersData();
//          fetchLocationData();
//         //  print(DistanceCalculator.calculateDistance(37.4219999, -112.0840, 25.4358, 81.846311000));
//         // getDeviceTokenToSendNotification();
//         // sendNotifications();
//         // showNotifications();
//         print("notification send");
//        },
//         child: const Icon(Icons.notifications_active_sharp),),
//     );
//   }
// }






