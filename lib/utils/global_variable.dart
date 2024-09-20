import 'package:alert_us/screens/dash_screen.dart';
import 'package:alert_us/screens/home_screen.dart';
import 'package:alert_us/screens/news_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

List<Widget> homeScreenItems = [const HomeScreen(), const NewsScreen(), DashboardScreen(uid: FirebaseAuth.instance.currentUser!.uid)];

List<String> address = ['latitude', 'longitude', 'fullAddress'];

late String username;

late String uid;
