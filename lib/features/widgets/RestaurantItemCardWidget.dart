import 'package:flutter/material.dart';

class RestaurantItemCardWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final double rating;
  final String deliveryText;
  final String timeText;
  final VoidCallback onFavoriteToggle;
  final bool isFavorite;

  const RestaurantItemCardWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.rating,
    this.deliveryText = "Free delivery",
    this.timeText = "45 mins",
    required this.onFavoriteToggle,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child:Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 6,
      margin: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: onFavoriteToggle,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(Icons.star, color: Colors.amber, size: 18),
                    SizedBox(width: 4),
                    Text(
                      rating.toStringAsFixed(1),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Image.asset(
                        "assets/images/delivery_icon.png",
                        color: Colors.red,
                        width: 16,
                        height: 16
                    ),
                    SizedBox(width: 4),
                    Text(deliveryText),
                    SizedBox(width: 16),
                    Icon(Icons.timer, color: Colors.red.shade400, size: 18),
                    SizedBox(width: 4),
                    Text(timeText),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}
