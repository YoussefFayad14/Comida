import 'package:flutter/material.dart';
import 'app_routes.dart';
import 'router_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.splash,
      onGenerateRoute: RouterGenerator.generateRoute,
    );
  }
}
