import 'package:flutter/material.dart';
import 'util/AppRoutes.dart';
import 'util/RouterGenerator.dart';

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
