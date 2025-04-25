import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  final String title;
  final Color textColor;
  final Color accentColor;
  final VoidCallback? onSeeAllPressed;
  final bool showSeeAll;
  final double fontSize;
  final FontWeight fontWeight;

  const SectionHeading({
    super.key,
    required this.title,
    required this.textColor,
    required this.accentColor,
    this.onSeeAllPressed,
    this.showSeeAll = true,
    this.fontSize = 28,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor,
          ),
        ),
        if (showSeeAll)
          TextButton(
            onPressed: onSeeAllPressed ??
                () {
                  // Default action if not provided
                },
            child: Text(
              'See All',
              style: TextStyle(
                color: accentColor,
              ),
            ),
          ),
      ],
    );
  }
}
