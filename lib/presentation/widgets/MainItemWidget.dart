import 'package:flutter/material.dart';

class MainItemWidget extends StatelessWidget {
  final String imagePath;
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const MainItemWidget({
    super.key,
    required this.imagePath,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.only(top: isSelected ? 0 : 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.greenAccent.shade200 : Colors.transparent,
          borderRadius: BorderRadius.circular(48),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: EdgeInsets.only(bottom: isSelected ? 16 : 0),
              child: CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage(imagePath),
              ),
            ),
            AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              child: Text(name, textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
