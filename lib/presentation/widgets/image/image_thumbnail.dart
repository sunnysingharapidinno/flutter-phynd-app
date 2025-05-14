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
    Widget imageWidget;

    if (isNetwork) {
      imageWidget = Image.network(
        imageUrl ?? '',
        width: SizeUtils.pxToDp(context, width),
        height: SizeUtils.pxToDp(context, height),
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            _errorPlaceholder(context),
      );
    } else {
      imageWidget = Image.asset(
        imageUrl ?? '',
        width: SizeUtils.pxToDp(context, width),
        height: SizeUtils.pxToDp(context, height),
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            _errorPlaceholder(context),
      );
    }

    return ClipRRect(
      borderRadius:
          BorderRadius.circular(SizeUtils.pxToDp(context, borderRadius)),
      child: imageWidget,
    );
  }

  Widget _errorPlaceholder(BuildContext context) {
    return Container(
      width: SizeUtils.pxToDp(context, width),
      height: SizeUtils.pxToDp(context, height),
      decoration: BoxDecoration(
        color: Theme.of(context).extension<AppTheme>()!.get('primary'),
        borderRadius:
            BorderRadius.circular(SizeUtils.pxToDp(context, borderRadius)),
      ),
      child: const Icon(
        Icons.broken_image,
        size: 40,
        color: Colors.white,
      ),
    );
  }
}
