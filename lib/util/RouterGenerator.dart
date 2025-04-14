import 'package:flutter/material.dart';
import '../features/screens/CartScreen.dart';
import '../features/screens/FoodDetailsScreen.dart';
import '../features/screens/HomeScreen.dart';
import '../features/screens/LoginScreen.dart';
import '../features/screens/OnboardingScreen.dart';
import '../features/screens/SignupScreen.dart';
import '../features/screens/SplashScreen.dart';
import 'AppRoutes.dart';


class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case AppRoutes.foodDetails:
        final String idMeal = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => FoodDetailsScreen(id: idMeal));
      case AppRoutes.cart:
        return MaterialPageRoute(builder: (_) => CartScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
