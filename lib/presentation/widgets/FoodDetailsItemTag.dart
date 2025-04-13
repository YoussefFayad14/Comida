import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget itemTag(String text, String imagePath) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Image.asset(
        imagePath,
        width: 20,
        height: 20,
      ),
      const SizedBox(width: 6),
      Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
    ],
  );
}