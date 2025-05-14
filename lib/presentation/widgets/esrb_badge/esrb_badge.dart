import 'package:flutter/material.dart';
import 'package:phynd_app/core/helpers/responsive_helper.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';

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
    return ImageThumbnail(
      imageUrl: imageUrl,
      height: height ?? 48,
      width: width ?? 45,
      fit: fit,
    );
  }
}
