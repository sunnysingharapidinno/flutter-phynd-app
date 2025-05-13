import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

class ImageThumbnail extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BorderRadius borderRadius;
  final bool isNetwork;

  const ImageThumbnail({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.isNetwork = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (isNetwork) {
      imageWidget = Image.network(
        imageUrl ?? '',
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            _errorPlaceholder(context),
      );
    } else {
      imageWidget = Image.asset(
        imageUrl ?? '',
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            _errorPlaceholder(context),
      );
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: imageWidget,
    );
  }

  Widget _errorPlaceholder(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).extension<AppTheme>()!.get('primary'),
        borderRadius: borderRadius,
      ),
      child: const Icon(
        Icons.broken_image,
        size: 40,
        color: Colors.white,
      ),
    );
  }
}
