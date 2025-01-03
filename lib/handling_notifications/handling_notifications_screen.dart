import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_api_availability/google_api_availability.dart';

class HandlingNotificationsScreen extends StatefulWidget {
  final String title;
  HandlingNotificationsScreen({required this.title, super.key});

  @override
  State<HandlingNotificationsScreen> createState() => _HandlingNotificationsScreenState();
}

class _HandlingNotificationsScreenState extends State<HandlingNotificationsScreen> {
  @override
  void initState() {
    super.initState();
    requestForNotificationPermission();
  }

  Future<void> requestForNotificationPermission() async {
    var token =await FirebaseMessaging.instance.getToken();
    print("FCM Token : $token");
    await GoogleApiAvailability.instance.makeGooglePlayServicesAvailable();
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    bool isGranted = await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.title),
      ),
    );
  }
}
