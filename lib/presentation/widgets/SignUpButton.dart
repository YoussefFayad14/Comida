import 'package:flutter/material.dart';

Widget SignUpButton(BuildContext context) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      side: BorderSide(color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    onPressed: () {
     /* Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );*/
    },
    child: Text(
      "Sign Up",
      style: TextStyle(fontSize: 18),
    ),
  );
}

