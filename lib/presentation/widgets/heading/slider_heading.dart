import 'package:flutter/material.dart';

class SliderHeading extends StatelessWidget {
  final String text;
  const SliderHeading(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width to adjust font size for different resolutions
    double screenWidth = MediaQuery.of(context).size.width;

    // Default font size from headlineSmall
    TextStyle baseStyle = Theme.of(context).textTheme.headlineSmall!;

    // Adjust font size based on screen width
    if (screenWidth >= 2560) {
      // For 2K screens
      baseStyle = baseStyle.copyWith(fontSize: 32.0);
    }
    if (screenWidth >= 3840) {
      // For 4K screens
      baseStyle = baseStyle.copyWith(fontSize: 52.0);
    }

    return Text(
      text,
      style: baseStyle.copyWith(
          fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Exo2'),
    );
  }
}
