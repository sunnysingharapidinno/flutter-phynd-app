import 'package:flutter/material.dart';
import 'package:phynd_app/core/helpers/responsive_helper.dart';

enum ESRBRating {
  everyone,
  everyone10Plus,
  teen,
  mature,
  adultsOnly,
  ratingPending
}

class ESRBBadge extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const ESRBBadge({
    super.key,
    this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) return const SizedBox.shrink();

    double screenWidth = MediaQuery.of(context).size.width;

    final imageSize =
        ResponsiveHelper.getResponsiveSize(screenWidth, 34, [80, 72, 64, 34]);

    return SizedBox(
      width: imageSize,
      height: imageSize,
      child: Image.network(
        imageUrl!,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
      ),
    );
  }
}
