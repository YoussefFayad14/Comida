import 'package:comida_app/presentation/screens/home_screen.dart';
import 'package:comida_app/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';


class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
