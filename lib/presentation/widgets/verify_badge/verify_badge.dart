import 'package:flutter/material.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF7B61FF),
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(4),
      child: const Icon(
        Icons.check,
        color: Colors.white,
        size: 16,
      ),
    );
  }
}
