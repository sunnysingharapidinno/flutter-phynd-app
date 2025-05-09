import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
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

  // double _getResponsiveSize(BuildContext context) {
  //   if (size != null) return size!;

  //   double screenWidth = MediaQuery.of(context).size.width;
  //   double imageSize = 36.0; // Base size for mobile

  //   // Responsive sizes for different screen widths
  //   if (screenWidth >= 1200) imageSize = 34.0; // HD
  //   if (screenWidth >= 2560) imageSize = 64.0; // 2K
  //   if (screenWidth >= 3200) imageSize = 72.0; // 3K
  //   if (screenWidth >= 3840) imageSize = 80.0; // 4K

  //   return imageSize;
  // }

  @override
  Widget build(BuildContext context) {
    return ImageThumbnail(
      imageUrl: imageUrl,
      height: height ?? SizeUtils.pxToDp(context, 48),
      width: width ?? SizeUtils.pxToDp(context, 45),
      fit: fit,
    );
  }
}
