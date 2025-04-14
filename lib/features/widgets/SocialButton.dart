import 'package:flutter/material.dart';

Widget SocialButton(String iconPath, String label) {
  return Container(
    width: 130,
    padding: EdgeInsets.symmetric(vertical: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(iconPath, height: 24),
        SizedBox(width: 8),
        Text(label),
      ],
    ),
  );
}