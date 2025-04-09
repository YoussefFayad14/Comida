import 'package:flutter/material.dart';

@override
Widget SectionTitleRow(String sectionName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          sectionName,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () {
            print("View All clicked");
          },
          child: Text(
            "View All",
            style: TextStyle(
              fontSize: 18,
              color: Colors.orange,
            ),
          ),
        ),
      ],
    );
 }

