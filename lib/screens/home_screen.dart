// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:alert_us/Notifications/notifications.dart';
import 'package:alert_us/screens/All_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void call(String number) async {
    final Uri url = Uri(
      scheme: 'tel',
      path: number,
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("can not launch url");
    }
  }

  void theft() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("There is theft"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    NotificationPage.fetchAllUsersData();
                  },
                  leading: const Icon(
                    Icons.add_alert,
                    color: Colors.red,
                  ),
                  title: const Text(
                      "Click here for sending message to your neighbour"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    call("100");
                  },
                  leading: const Icon(
                    Icons.local_police,
                    color: Colors.green,
                  ),
                  title: const Text("Call to Police"),
                  trailing: Icon(
                    Icons.call,
                    color: Colors.green,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AlertOptions()));
                  },
                  leading: const Icon(
                    Icons.numbers,
                    color: Colors.blue,
                  ),
                  title: const Text("Emergency Numbers"),
                  trailing: Icon(
                    Icons.format_list_numbered,
                    color: Colors.pinkAccent,
                  ),
                ),
              ],
            ),
          );
        });
  }

  void fire() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("There is fire in house"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    NotificationPage.fetchAllUsersData();
                    const Text("Fire");
                  },
                  leading: const Icon(
                    Icons.fireplace_outlined,
                    color: Colors.red,
                  ),
                  title: const Text(
                      "Click here for sending message to your neighbour"),
                ),
                ListTile(
                  onTap: () async {
                    Navigator.pop(context);
                    call("101");
                  },
                  leading: const Icon(
                    Icons.fire_extinguisher,
                    color: Colors.red,
                  ),
                  title: const Text("Call to Fire Brigade"),
                  trailing: Icon(
                    Icons.call,
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AlertOptions()));
                  },
                  leading: const Icon(
                    Icons.numbers,
                    color: Colors.blue,
                  ),
                  title: const Text("Emergency Numbers"),
                  trailing: Icon(
                    Icons.format_list_numbered,
                    color: Colors.pinkAccent,
                  ),
                ),
              ],
            ),
          );
        });
  }

  void showOptions() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Send Alert message"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    fire();
                  },
                  leading: const Icon(
                    Icons.fireplace_outlined,
                    color: Colors.red,
                  ),
                  title: const Text("There is fire in house"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    theft();
                    // const Text("Theft");
                  },
                  leading: const Icon(Icons.man),
                  title: const Text("Theft has happened"),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/alert_image.jpeg'),
                    maxRadius: 65,
                    minRadius: 20,
                  ),
                ]),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    showOptions();
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.red),
                  ),
                  icon: Icon(Icons.warning_amber_outlined),
                  label: Text(
                    'ALERT',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              'Recent Alerts',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
