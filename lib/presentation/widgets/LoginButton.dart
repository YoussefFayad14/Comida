import 'package:flutter/material.dart';

import '../screens/LoginScreen.dart';

@override
Widget LoginButton(context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    onPressed: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    },
    child: Text(
      "Log In",
      style: TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
    ),
  );
}