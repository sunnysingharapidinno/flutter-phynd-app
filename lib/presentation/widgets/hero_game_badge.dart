import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/app_images.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/buttons/primary_button.dart';
import 'package:phynd_app/presentation/widgets/esrb_badge/esrb_badge.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';
import 'package:phynd_app/presentation/widgets/verify_badge/verify_badge.dart';

class HeroGameBadge extends StatelessWidget {
  final VoidCallback? onPlayPressed;
  final VoidCallback? onLearnMorePressed;
  final bool showActionBtns;
  final String? gameTextImg;
  final String? releaseYear;
  final String? publisherName;
  final String? esrb;
  final int? friendsCount;
  final int? onlineCount;

  const HeroGameBadge({
    super.key,
    this.onPlayPressed,
    this.onLearnMorePressed,
    this.showActionBtns = true,
    this.gameTextImg,
    this.releaseYear,
    this.publisherName,
    this.esrb,
    this.friendsCount,
    this.onlineCount,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final theme = appTheme.extension<AppTheme>();
    final textColor = theme?.get('text');
    final btnText = theme?.get('btnText');
    final buttonBg2 = theme?.get('buttonBg2');
    final subText2 = theme?.get('subText2');
    final onlineColor = theme?.get('onlineIndicator');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ImageThumbnail(
          imageUrl: gameTextImg ??
              'https://www.forgottenplayland.com/_next/image?url=%2Fassets%2Flogo.webp&w=640&q=75',
          height: 146,
          fit: BoxFit.contain,
        ),
        SizedBox(height: SizeUtils.pxToDp(context, 3)),
        // Info Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              releaseYear ?? '2024',
              style: TextStyle(
                fontSize: FontUtils.pxToSp(context, 28),
                color: textColor,
              ),
            ),
            SizedBox(width: SizeUtils.pxToDp(context, 19)),
            Icon(
              Icons.circle,
              color: textColor,
              size: SizeUtils.pxToDp(context, 19),
            ),
            SizedBox(width: SizeUtils.pxToDp(context, 19)),
            Text(
              publisherName ?? 'Top Secret Games',
              style: TextStyle(
                fontSize: FontUtils.pxToSp(context, 28),
                color: textColor,
              ),
            ),
            SizedBox(width: SizeUtils.pxToDp(context, 14)),
            VerifiedBadge(size: SizeUtils.pxToDp(context, 28)),
            SizedBox(width: SizeUtils.pxToDp(context, 19)),
            Icon(
              Icons.circle,
              color: textColor,
              size: SizeUtils.pxToDp(context, 19),
            ),
            SizedBox(width: SizeUtils.pxToDp(context, 19)),
            ESRBBadge(
              imageUrl: esrb ??
                  'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/everyone.png',
            )
          ],
        ),
        SizedBox(height: SizeUtils.pxToDp(context, 20)),

        Row(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppImages.peopleLogoGreyBg,
                  height: SizeUtils.pxToDp(context, 48),
                  fit: BoxFit.contain,
                ),
                SizedBox(width: SizeUtils.pxToDp(context, 9)),
                Text(
                  '${friendsCount ?? '86'} Friends Play',
                  style: TextStyle(
                    color: subText2,
                    fontSize: FontUtils.pxToSp(context, 24),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(width: SizeUtils.pxToDp(context, 14)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: SizeUtils.pxToDp(context, 14),
                  height: SizeUtils.pxToDp(context, 14),
                  decoration: BoxDecoration(
                    color: onlineColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 9),
                Text(
                  '${onlineCount ?? '12'} Currently Playing',
                  style: TextStyle(
                    color: subText2,
                    fontSize: FontUtils.pxToSp(context, 19),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),

        if (showActionBtns) ...[
          SizedBox(height: SizeUtils.pxToDp(context, 20)),
          Row(
            children: [
              PrimaryButton(
                text: 'Play',
                height: 67,
                width: 180,
                textColor: btnText,
                onPressed: onPlayPressed,
                backgroundColor: textColor,
                icon: Icons.play_arrow,
                iconColor: btnText,
                iconSize: 28,
                fontSize: 25,
                borderRadius: 7,
              ),
              SizedBox(width: SizeUtils.pxToDp(context, 28)),
              PrimaryButton(
                height: 67,
                width: 234,
                text: 'More Info',
                onPressed: onLearnMorePressed,
                backgroundColor: buttonBg2,
                textColor: textColor,
                icon: Icons.info_outline,
                iconColor: textColor,
                iconSize: 28,
                fontSize: 25,
                borderRadius: 7,
              ),
            ],
          )
        ],
      ],
    );
  }
}
