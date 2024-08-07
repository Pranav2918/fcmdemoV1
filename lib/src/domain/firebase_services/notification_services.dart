import 'dart:convert';
import 'dart:io';

import 'package:fcmdemo/main.dart';
import 'package:fcmdemo/src/configs/routes/app_routes.dart';
import 'package:fcmdemo/src/presentation/demo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;

class FirebaseNotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      //Open app settings if required
      debugPrint('User declined or has not accepted permission');
    }
  }

  Future<String> getDeviceToken() async {
    String? deviceToken = await messaging.getToken();
    String? serverKey = await getAccessToken();
    debugPrint("Device token $deviceToken");
    debugPrint("Server token $serverKey");
    return deviceToken ?? "";
  }

  Future<String> getAccessToken() async {
    final serviceAccountJSON = {
      "type": "service_account",
      "project_id": "fcmdemo-2d962",
      "private_key_id": "b8ea04f6267cc993686a007548d800b56641773c",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCz/ctXjHe8PIag\nEMgM8ro8qayQv2Y9Qp8MEAbvDxdZB1SsopmqJ2XXPqVv1pTioeJ254cJXr2NSm++\ncAvd3tyYznJHZxFEcQ1dF8xArr5SAXR4/RKNl7uF7q1kgNiKrY2oSGcFJOgVEwpk\n7a7KBX5aDwMThZpZOYh6DK4F3ELjGFI3nhQVkgn+DRaIeuSyxELHGsK/A/KFUspc\nmC1wqEI4SUqtDgdTicUQoGlhG3Q8BD0WFzQbvA4mzBQICHo+VJB6CWF6nsSEUFid\nZ37aiTSmNO77Sm+L8uPCPZKRlYKfuet72wy7rPyYwCQoGV1UhDmbeyN5zTdU08Os\noJA5vTpLAgMBAAECggEABSQqusV4ZhgUgF36WORWDYWLOFc/RGCyylVq3UlBEXn0\nITpDyWh2sD9J2nf2qMKXBW53nPznzTFjH71zmVLUWkkLWp7HD31rNE2JuA9FwHHq\nMcqIzSKYaKr4qPZFOTDb6wKmbq8vMerpURi49WxSv5/OJrCaSBIso8/Y6LHx9yqe\nXGqmPw9CsFyA/xTsGVs3LNWK+E+z1CHVJaimx9R2ZbI5b0b3qQIqH+UeEIFinUAj\ni2lm+0ktYIQBIh4/yIBXVhyqzOjhZY4Qt9M8NRGVfAW52Zo56YNRMdJM5WQGWy/E\nJeUCEmsOPqKmqc1o8eAhjSAYXmEOxsGpnb0z08MTgQKBgQDsjGRLj0Wm7TJWp1Mm\nm2OgO4C+sAt55+BO8Hf3O2Yb9lHBBMlUZ75K4BXypofHiaM38QeV52sAh3MBvf/6\npNtPNe1nD27wdC3gzScTEF2G2n7j4ruSKDpXXEgD+lBGZh2Wcdpb8oSAJhU00Cz9\n+/yI2CL6Gw98hTHS1CtlfWHSFQKBgQDCytBkvD8FCDZ2Fwv1Bw+a4WI/bcjcvX5X\nY6y7nL8cHceFE21Spp9JxW5MYyF4Xttw94eh8HdAz0u3vhVd2xkA7jp8ZB6OQohy\nocMm0zmNTXXJi/do6ZHjN4hUpnX0ILR91m0AujwWeRv89Oee5YLYhdqxPKGsnT9t\npTNPzOrS3wKBgHTJ9/bKXQRGlhTsdgRYsf55gl4jgvcEQd4XodNh808Y9VJML67J\nrc1AB/YOvHkK/pfvG+SqJk1TkreofErevBzGrli06Pw1EDWudH1YFiUvmXigCCXo\nUK2zNScpnhqz7iXKPpopCbxPkSbLJXucvxk9RT+gvqunA2tpL6fjGLnlAoGATDnt\nnt4Dk0aJeWC/bx1aP/Oe7M9bYPZOcIgy2iAWsTv+DddyWnuVrdqytPW97UrBeM2E\nqBxfrl7wdHDQD7BjcnfHL1JGmsjyeFlQ8uqJhQAg7cP2B3oPeukKUoXpdqUtvGii\nszwts2WlTDHSSd3qfCy1TdI6OkA2yANztvCrm+UCgYB+MWr3UV/bnY5pJCQ0n9wi\niAKzC1Uey3H7pALB25tv3tPNheWOagl6ZeYV8yzCHnSL4EEdLPd96KxSrF7qoAsw\n6JfKmiyITRn6z3R+IROODU4R2f1SrIus0lIT1w5SVmZJNeDAL4T/R6IQipRoL4PB\nCkHrl8qxpS4lv0NN/OGo9g==\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-f982d@fcmdemo-2d962.iam.gserviceaccount.com",
      "client_id": "108096343046410385521",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-f982d%40fcmdemo-2d962.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    http.Client client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJSON), scopes);

    //Get (save) access token
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJSON),
            scopes,
            client);

    client.close();

    return credentials.accessToken.data;
  }

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'FCMDemo', // id
    'FCMDemo', // title
    description:
        'This channel is used for important notifications.', // description
    showBadge: true,
    playSound: true,
    enableVibration: true,
    importance: Importance.max,
  );

  initLocalNotification() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('notification_icon');
    var initializeSettingsIOS = const DarwinInitializationSettings();

    var initializeSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: initializeSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializeSettings,
      onDidReceiveNotificationResponse: (response) => _handleNavigation(),
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (Platform.isAndroid) {
        flutterLocalNotificationsPlugin.show(
            1,
            message.notification?.title,
            message.notification?.body,
            const NotificationDetails(
                android: AndroidNotificationDetails("FCMDemo", "FCMDemo",
                    channelDescription: "FCM Channel",
                    importance: Importance.max,
                    priority: Priority.max,
                    ticker: 'ticker',
                    playSound: true)),
            payload: jsonEncode(message.data));
      }
      if (Platform.isIOS) {
        await FirebaseMessaging.instance
            .setForegroundNotificationPresentationOptions(
          alert: true, // Required to display a heads up notification
          badge: true,
          sound: true,
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        _handleNavigation();
      },
    );
  }

  void openFromTerminatedState() async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      _handleNavigation();
    }
  }

  void _handleNavigation() {
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil(AppRoutes.fcmScreen, (route) => false);
  }
}
