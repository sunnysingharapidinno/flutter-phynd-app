import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/app_images.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/buttons/primary_button.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';
import 'package:phynd_app/presentation/widgets/verify_badge/verify_badge.dart';

class EventOfferCard extends StatelessWidget {
  final String backgroundImageUrl;
  final String publisherLogoUrl;
  final String gameTitle;
  final bool isVerified;
  final VoidCallback? onSavePressed;
  final int friendsSavedCount;
  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final bool isSaved;

  const EventOfferCard({
    super.key,
    required this.backgroundImageUrl,
    required this.publisherLogoUrl,
    required this.gameTitle,
    this.isVerified = false,
    this.onSavePressed,
    required this.friendsSavedCount,
    this.onTap,
    this.height = 327,
    this.width = 350,
    this.isSaved = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text');
    final buttonBg = theme?.get('borderColors');

    return RemoteControlWrapper(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ImageThumbnail(
                imageUrl: backgroundImageUrl,
                height: height,
                width: width,
                fit: BoxFit.cover,
                borderRadius: 8,
              ),
              // Optional: Dark overlay. Kept for now, can be removed if image should be clear.
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.0),
                            Colors.black.withOpacity(0.2),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.6, 1.0])),
                ),
              ),

              Positioned(
                  bottom: SizeUtils.pxToDp(context, 16),
                  left: SizeUtils.pxToDp(context, 16),
                  child: Row(
                    children: [
                      ImageThumbnail(
                        imageUrl: publisherLogoUrl,
                        height: 48,
                        width: 48,
                        isNetwork:
                            true, // Assuming publisher logo is network image
                        fit: BoxFit.contain,
                        borderRadius: 200,
                      ),
                      SizedBox(width: SizeUtils.pxToDp(context, 8)),
                      Text(
                        gameTitle,
                        style: TextStyle(
                          color: textColor,
                          fontSize: FontUtils.pxToSp(context, 32),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: SizeUtils.pxToDp(context, 8)),
                      if (isVerified) VerifiedBadge(),
                    ],
                  )),
            ],
          ),

          // Bottom Action Bar
          Padding(
            padding: EdgeInsets.fromLTRB(
                SizeUtils.pxToDp(context, 16),
                SizeUtils.pxToDp(context, 16),
                SizeUtils.pxToDp(context, 16),
                0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrimaryButton(
                  text: isSaved ? 'Unsave' : 'Save',
                  icon: Icons.bookmark, // Or Icons.bookmark for filled
                  onPressed: onSavePressed,
                  iconColor: textColor,
                  fontSize: 24,
                  iconSize: 27,
                  width: isSaved ? 200 : 184,
                  height: 52,
                  backgroundColor: buttonBg,
                  borderRadius: 8,
                ),
                Row(
                  children: [
                    ImageThumbnail(
                      imageUrl: AppImages.peopleLogoGreyBg,
                      width: 48,
                      height: 48,
                      borderRadius: 200,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: SizeUtils.pxToDp(context, 8)),
                    Text(
                      '$friendsSavedCount Friends Saved',
                      style: TextStyle(
                        color: textColor,
                        fontSize: FontUtils.pxToSp(context, 24),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Exo2',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
