import 'package:flutter/material.dart';

Widget itemBottomSheet(String text, bool isSelected, String imagePath) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Image.asset(
          imagePath,
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
              fontSize: 20,
              color: Colors.white
          ),
        ),
        const Spacer(),
        isSelected
            ? Icon(
          isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
          color: isSelected ? Colors.orange : Colors.grey,
          size: 24,
        )
            : Icon(
          isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked_outlined,
          color: isSelected ? Colors.orange : Colors.grey,
          size: 24,
        ),
      ],
    ),
  );
}