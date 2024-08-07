import 'package:fcmdemo/src/domain/firebase_services/notification_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  const HomeScreen({super.key, required this.name});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    FirebaseNotificationServices().requestPermission();
    FirebaseNotificationServices().getDeviceToken();
    FirebaseNotificationServices().initLocalNotification();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FCM DEMO")),
      body: Center(
        child: Text("Check this out ${widget.name}"),
      ),
    );
  }
}
