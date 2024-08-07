import 'package:fcmdemo/src/configs/routes/app_routes.dart';
import 'package:fcmdemo/src/presentation/demo.dart';
import 'package:fcmdemo/src/presentation/home.dart';
import 'package:fcmdemo/src/presentation/splash.dart';
import 'package:flutter/material.dart';

class AppRouteHandler {
  AppRouteHandler._();

  static final appRouteHandler = AppRouteHandler._();
  factory AppRouteHandler() {
    return appRouteHandler;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final routes = {
      AppRoutes.splashScreen: (context) => const SplashScreen(),
      AppRoutes.homeScreen: (context) =>
          HomeScreen(name: (settings.arguments as Map)["name"]),
      AppRoutes.fcmScreen: (context) => const FCMDEMO()
    };

    final routeBuilder = routes[settings.name];
    if (routeBuilder != null) {
      return MaterialPageRoute(builder: routeBuilder);
    }

    // Handle default case (optional):
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Placeholder(),
      ),
    );
  }
}
