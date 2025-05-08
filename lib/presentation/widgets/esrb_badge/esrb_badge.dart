import 'package:flutter/material.dart';

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
  final double? size;

  const ESRBBadge({
    super.key,
    this.imageUrl,
    this.size,
  });

  double _getResponsiveSize(BuildContext context) {
    if (size != null) return size!;

    double screenWidth = MediaQuery.of(context).size.width;
    double imageSize = 36.0; // Base size for mobile

    // Responsive sizes for different screen widths
    if (screenWidth >= 1200) imageSize = 34.0; // HD
    if (screenWidth >= 2560) imageSize = 64.0; // 2K
    if (screenWidth >= 3200) imageSize = 72.0; // 3K
    if (screenWidth >= 3840) imageSize = 80.0; // 4K

    return imageSize;
  }

  @override
  Widget build(BuildContext context) {
    final imageSize = _getResponsiveSize(context);

    if (imageUrl == null) {
      return SizedBox(
        width: imageSize,
        height: imageSize,
        child: Container(
          color: Colors.grey[800],
          child: Center(
            child: Icon(
              Icons.error_outline,
              color: Colors.white54,
              size: imageSize * 0.5,
            ),
          ),
        ),
      );
    }

    return Container(
      width: imageSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        image: DecorationImage(
          image: NetworkImage(imageUrl!),
          fit: BoxFit.contain,
          onError: (exception, stackTrace) {
            debugPrint('Error loading ESRB image: $exception');
          },
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: Image.network(
          imageUrl!,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[800],
              child: Center(
                child: Icon(
                  Icons.error_outline,
                  color: Colors.white54,
                  size: imageSize * 0.5,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
