import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';
import 'package:phynd_app/presentation/widgets/image_video.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';
import 'package:phynd_app/presentation/widgets/verify_badge/verify_badge.dart';

class VideoCard extends StatelessWidget {
  final String? thumbnailUrl;
  final String? videoUrl;
  final String? timeAgo;
  final String? duration;
  final String? title;
  final String? publisherAvatarUrl;
  final String? publisherName;
  final bool isVerified;
  final int? friendsWatchedCount;
  final VoidCallback? onTap;
  final double? width;
  final double? height; // Optional overall height for the card

  const VideoCard({
    super.key,
    this.thumbnailUrl,
    this.videoUrl,
    this.timeAgo,
    this.duration,
    this.title,
    this.publisherAvatarUrl,
    this.publisherName,
    this.isVerified = false,
    this.friendsWatchedCount = 0,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text');
    final double thumbnailHeight =
        height ?? 495; // Default to 16:9 aspect ratio for thumbnail

    return RemoteControlWrapper(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail Section with Overlays
          Stack(
            children: [
              ImageVideo(
                imageUrl: thumbnailUrl,
                videoUrl: videoUrl,
                height: thumbnailHeight,
                width: double.infinity,
                borderRadius: 12,
                fit: BoxFit.cover,
              ),

              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(27, 29, 38, 0.0),
                        Color(0xFF1B1D26),
                      ],
                    ),
                  ),
                ),
              ),
              // Second gradient: rgba(13,19,44,0.6) to rgba(13,19,44,0)
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.1016, 0.276],
                      colors: [
                        Color.fromRGBO(13, 19, 44, 0.6),
                        Color.fromRGBO(13, 19, 44, 0.0),
                      ],
                    ),
                  ),
                ),
              ),

              // Time Ago Overlay (Top-Left)
              Positioned(
                top: SizeUtils.pxToDp(context, 8),
                left: SizeUtils.pxToDp(context, 8),
                child: _buildOverlayChip(
                    context, timeAgo ?? '0', Color.fromRGBO(49, 53, 68, 0.40)),
              ),
              // Duration Overlay (Bottom-Right of Thumbnail)
              Positioned(
                bottom: SizeUtils.pxToDp(context, 8),
                right: SizeUtils.pxToDp(context, 8),
                child: _buildOverlayChip(context, duration ?? '0.00',
                    Color.fromRGBO(49, 53, 68, 0.60)),
              ),
              // Title Overlay (Bottom-Left of Thumbnail)
              Positioned(
                bottom: SizeUtils.pxToDp(context, 8),
                left: SizeUtils.pxToDp(context, 8),
                child: Text(
                  title ?? '',
                  style: TextStyle(
                    color: textColor,
                    fontSize: FontUtils.pxToSp(context, 20),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Exo2',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          // Publisher Info Section
          Padding(
            padding: EdgeInsets.all(SizeUtils.pxToDp(context, 8)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageThumbnail(
                  imageUrl: publisherAvatarUrl,
                  height: 40,
                  width: 40,
                  borderRadius: 40,
                  isNetwork: true,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: SizeUtils.pxToDp(context, 8)),
                Text(
                  publisherName ?? '',
                  style: TextStyle(
                    color: textColor,
                    fontSize: FontUtils.pxToSp(context, 20),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: SizeUtils.pxToDp(context, 8)),
                if (isVerified)
                  VerifiedBadge(size: SizeUtils.pxToDp(context, 20)),
              ],
            ),
          ),
          // Friends Watched Section
          Padding(
            padding: EdgeInsets.only(
              top: SizeUtils.pxToDp(context, 4),
              right: SizeUtils.pxToDp(context, 8),
              bottom: SizeUtils.pxToDp(context, 8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.people_outline, // Using a standard icon
                  color: textColor,
                  size: SizeUtils.pxToDp(context, 18),
                ),
                SizedBox(width: SizeUtils.pxToDp(context, 4)),
                Text(
                  '$friendsWatchedCount Friends Watched',
                  style: TextStyle(
                    color: textColor,
                    fontSize: FontUtils.pxToSp(context, 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverlayChip(
    BuildContext context,
    String text,
    Color? bgColor,
  ) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text');
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtils.pxToDp(context, 8),
        vertical: SizeUtils.pxToDp(context, 4),
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(SizeUtils.pxToDp(context, 4)),
        border: Border.all(color: textColor ?? Colors.transparent),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: FontUtils.pxToSp(context, 16),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
