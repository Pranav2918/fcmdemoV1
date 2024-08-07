import 'dart:io';

import 'package:fcmdemo/src/configs/const/firebase_const.dart';
import 'package:fcmdemo/src/configs/routes/app_routes.dart';
import 'package:fcmdemo/src/configs/routes/route_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: FirebaseConstants.firebaseAPIKey,
            appId: FirebaseConstants.firebaseAppID,
            messagingSenderId: FirebaseConstants.messagingSenderId,
            projectId: FirebaseConstants.projectID));
  } else {
    await Firebase.initializeApp();
  }
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: FirebaseConstants.firebaseAPIKey,
            appId: FirebaseConstants.firebaseAppID,
            messagingSenderId: FirebaseConstants.messagingSenderId,
            projectId: FirebaseConstants.projectID));
  } else {
    await Firebase.initializeApp();
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FCM Demo',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.splashScreen,
      onGenerateRoute: AppRouteHandler.onGenerateRoute,
    );
  }
}
