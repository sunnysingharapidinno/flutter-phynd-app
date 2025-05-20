import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';

class GenreCard extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final VoidCallback? onTap;
  final double? height;
  final double? width;

  const GenreCard({
    super.key,
    this.imageUrl,
    this.title,
    this.onTap,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text');
    final cardHeight = SizeUtils.pxToDp(context, height ?? 200);
    final cardWidth = SizeUtils.pxToDp(context, width ?? 350);

    return RemoteControlWrapper(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SizeUtils.pxToDp(context, 12)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Image
            ImageThumbnail(
              imageUrl: imageUrl,
              height: cardHeight,
              width: cardWidth,
              fit: BoxFit.cover,
            ),
            // Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.8),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [
                      0.0,
                      0.5,
                      1.0
                    ], // Adjust stops for desired gradient effect
                  ),
                ),
              ),
            ),
            // Title Text
            Text(
              title ?? '',
              style: TextStyle(
                  color: textColor,
                  fontSize: FontUtils.pxToSp(context, 32),
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Exo2',
                  shadows: [
                    Shadow(
                      offset: const Offset(1.0, 1.0),
                      blurRadius: 3.0,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
