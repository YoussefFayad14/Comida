import 'package:comida_app/presentation/screens/HomeScreen.dart';
import 'package:comida_app/presentation/screens/OnboardingScreen.dart';
import 'package:comida_app/presentation/screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';


class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => OnboadingScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
