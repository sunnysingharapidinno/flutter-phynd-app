import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

class GameImageThumbnail extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final BorderRadius borderRadius;

  const GameImageThumbnail({
    super.key,
    this.imageUrl,
    this.size = 80,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.network(
        imageUrl ?? '',
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Theme.of(context).extension<AppTheme>()!.get('primary'),
            borderRadius: borderRadius,
          ),
          child: const Icon(
            Icons.broken_image,
            size: 40,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
