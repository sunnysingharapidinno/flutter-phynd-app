import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';

class FavGameCard extends StatelessWidget {
  final String imageUrl;
  final int rank;
  final String title;
  final VoidCallback? onTap;
  final double? height;
  final double? width;

  const FavGameCard({
    super.key,
    required this.imageUrl,
    required this.rank,
    required this.title,
    this.onTap,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text');
    final darkSlateOverlay = theme?.get('profileHeaderOverlay');
    return RemoteControlWrapper(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: SizeUtils.pxToAllBorderRadius(context, radius: 8),
                child: ImageThumbnail(
                  imageUrl: imageUrl,
                  height: SizeUtils.pxToDp(
                      context, height ?? 300), // Adjust as needed
                  width: SizeUtils.pxToDp(
                      context, width ?? 260), // Adjust as needed
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: SizeUtils.pxToDp(context, 8),
                left: SizeUtils.pxToDp(context, 8),
                child: Container(
                  width: SizeUtils.pxToDp(context, 64),
                  height: SizeUtils.pxToDp(context, 64),
                  decoration: BoxDecoration(
                    color: darkSlateOverlay,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: textColor!, width: SizeUtils.pxToDp(context, 2)),
                  ),
                  child: Center(
                    child: Text(
                      rank.toString(),
                      style: TextStyle(
                        color: textColor,
                        fontSize: FontUtils.pxToSp(context, 32),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Exo2',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: SizeUtils.pxToDp(context, 8)),
          Center(
            child: Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: FontUtils.pxToSp(context, 32),
                fontWeight: FontWeight.w600,
                fontFamily: 'Exo2',
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
