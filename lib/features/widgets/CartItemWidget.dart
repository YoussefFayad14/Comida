import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final String image;
  final String name;
  final String category;
  final int quantity;
  final VoidCallback  onDelete;

  const CartItemWidget({
    super.key,
    required this.image,
    required this.name,
    required this.category,
    required this.quantity,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(image, width: 60, height: 60, fit: BoxFit.cover),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 4),
                Text(
                    category,
                    style: TextStyle(color: Colors.red, fontSize: 14)),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.remove_circle_outline, color: Colors.grey),
              SizedBox(width: 8),
              Text(quantity.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 8),
              Icon(Icons.add_circle_outline, color: Colors.grey),
            ],
          ),
          SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              onDelete();
            },
            child: Icon(Icons.close, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
