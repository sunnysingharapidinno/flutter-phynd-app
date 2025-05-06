import 'package:flutter/material.dart';

class Ratings extends StatelessWidget {
  final double rating; // e.g. 4.5
  final int maxRating;
  final double starSize;
  final Color color;

  const Ratings({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.starSize = 20,
    this.color = Colors.yellow,
  });

  @override
  Widget build(BuildContext context) {
    // Determine star size based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    final actualStarSize = screenWidth > 3000 ? 28.0 : starSize;

    List<Widget> stars = [];
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    for (int i = 0; i < maxRating; i++) {
      if (i < fullStars) {
        stars.add(Icon(Icons.star, color: color, size: actualStarSize));
      } else if (i == fullStars && hasHalfStar) {
        stars.add(Icon(Icons.star_half, color: color, size: actualStarSize));
      } else {
        stars.add(Icon(Icons.star_border, color: color, size: actualStarSize));
      }
    }
    return Row(children: stars);
  }
}
