import 'package:flutter/material.dart';
import 'package:phynd_app/core/helpers/responsive_helper.dart';

class VerifiedBadge extends StatelessWidget {
  final double size;
  final Color color;
  final Color iconColor;

  const VerifiedBadge({
    super.key,
    this.size = 16,
    this.color = const Color(0xFF7B61FF),
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final sizes = [32.0, 28.0, 20.0, 18.0];
    final actualSize =
        ResponsiveHelper.getResponsiveSize(screenWidth, size, sizes);
    final iconSize = actualSize * 0.8; // Icon size is 80% of container size

    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      padding:
          EdgeInsets.all(actualSize * 0.25), // Padding is 25% of container size
      child: Icon(
        Icons.check,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
