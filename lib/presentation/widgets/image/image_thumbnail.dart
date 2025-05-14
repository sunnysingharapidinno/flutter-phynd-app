import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/size_utils.dart';

class ImageThumbnail extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double borderRadius;
  final bool isNetwork;

  const ImageThumbnail({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.borderRadius = 0,
    this.isNetwork = true,
  });

  @override
  Widget build(BuildContext context) {
    // Set default size if not provided
    final double resolvedWidth = SizeUtils.pxToDp(context, width ?? 100);
    final double resolvedHeight = SizeUtils.pxToDp(context, height ?? 100);
    final double resolvedRadius = SizeUtils.pxToDp(context, borderRadius);

    // Determine image widget
    final Widget imageWidget = isNetwork
        ? Image.network(
            imageUrl ?? '',
            width: resolvedWidth,
            height: resolvedHeight,
            fit: fit ?? BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _errorPlaceholder(
                context, resolvedWidth, resolvedHeight, resolvedRadius),
          )
        : Image.asset(
            imageUrl ?? '',
            width: resolvedWidth,
            height: resolvedHeight,
            fit: fit ?? BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _errorPlaceholder(
                context, resolvedWidth, resolvedHeight, resolvedRadius),
          );

    return ClipRRect(
      borderRadius: BorderRadius.circular(resolvedRadius),
      child: imageWidget,
    );
  }

  Widget _errorPlaceholder(
      BuildContext context, double width, double height, double radius) {
    final themeColor =
        Theme.of(context).extension<AppTheme>()?.get('primary') ?? Colors.grey;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: themeColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.broken_image,
        size: 40,
        color: Colors.white,
      ),
    );
  }
}
