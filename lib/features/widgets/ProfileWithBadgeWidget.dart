import 'package:flutter/material.dart';

class ProfileWithBadge extends StatelessWidget {
  final ImageProvider image;
  final int badgeCount;
  final double size;
  final bool showBadge;

  static const double _badgeSize = 20.0;
  static const Color _badgeColor = Colors.red;
  static const Color _badgeTextColor = Colors.white;
  static const double _badgeFontSize = 12.0;
  static const Color _badgeBorderColor = Colors.red;
  static const double _badgeBorderWidth = 1.5;

  const ProfileWithBadge({
    super.key,
    required this.image,
    this.badgeCount = 0,
    this.size = 48.0,
    this.showBadge = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: image,
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1.0,
              ),
            ),
          ),

          if (showBadge && badgeCount > 0)
            Positioned(
              top: -_badgeSize * 0.25,
              right: -_badgeSize * 0.25,
              child: Container(
                width: _badgeSize,
                height: _badgeSize,
                decoration: BoxDecoration(
                  color: _badgeColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _badgeBorderColor,
                    width: _badgeBorderWidth,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    badgeCount > 9 ? '9+' : badgeCount.toString(),
                    style: const TextStyle(
                      color: _badgeTextColor,
                      fontSize: _badgeFontSize,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}