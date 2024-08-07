import 'package:fcmdemo/src/configs/routes/app_routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 800)).then((value) {
      Navigator.pushReplacementNamed(context, AppRoutes.homeScreen,
          arguments: {"name": "PRANAV"});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Splash here"),
      ),
    );
  }
}
