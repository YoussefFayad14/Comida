import 'package:flutter/material.dart';

class SummaryRow extends StatelessWidget {
  final String title;
  final String value;

  const SummaryRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        children: [
          Text(title,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 14)),
          Spacer(),
          Text(value,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 14)),
        ],
      ),
    );
  }
}
