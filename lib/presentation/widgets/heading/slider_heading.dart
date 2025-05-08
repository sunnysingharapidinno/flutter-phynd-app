import 'package:flutter/material.dart';
import 'package:phynd_app/core/helpers/responsive_helper.dart';

class SliderHeading extends StatelessWidget {
  final String text;
  const SliderHeading(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width to adjust font size for different resolutions
    double screenWidth = MediaQuery.of(context).size.width;

    // Default font size from headlineSmall
    TextStyle baseStyle = Theme.of(context).textTheme.headlineSmall!;

    // Get responsive font size
    final baseFontSize = baseStyle.fontSize ?? 36.0;
    final fontSizes = [72.0, 64.0, 48.0, 36.0];

    final fontSize = ResponsiveHelper.getResponsiveSize(
      screenWidth,
      baseFontSize,
      fontSizes,
    );

    return Text(
      text,
      style: baseStyle.copyWith(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Exo2',
      ),
    );
  }
}
