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

  const HeroGameBadge({
    super.key,
    this.onPlayPressed,
    this.onLearnMorePressed,
    this.showActionBtns = true,
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
          imageUrl:
              'https://www.forgottenplayland.com/_next/image?url=%2Fassets%2Flogo.webp&w=640&q=75',
          height: SizeUtils.pxToDp(context, 146),
          fit: BoxFit.contain,
        ),
        SizedBox(height: SizeUtils.pxToDp(context, 3)),
        // Info Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '2024',
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
              'Top Secret Games',
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
              imageUrl:
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
                  '86 Friends Play',
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
                  '12 Currently Playing',
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
              SizedBox(
                width: SizeUtils.pxToDp(context, 180),
                height: SizeUtils.pxToDp(context, 67),
                child: PrimaryButton(
                  text: 'Play',
                  textColor: btnText,
                  onPressed: onPlayPressed,
                  backgroundColor: textColor,
                  icon: Icons.play_arrow,
                  iconColor: btnText,
                  iconSize: SizeUtils.pxToDp(context, 28),
                  fontSize: FontUtils.pxToSp(context, 25),
                ),
              ),
              SizedBox(width: SizeUtils.pxToDp(context, 28)),
              SizedBox(
                width: SizeUtils.pxToDp(context, 234),
                height: SizeUtils.pxToDp(context, 67),
                child: PrimaryButton(
                  text: 'More Info',
                  onPressed: onLearnMorePressed,
                  backgroundColor: buttonBg2,
                  textColor: textColor,
                  icon: Icons.info_outline,
                  iconColor: textColor,
                  iconSize: SizeUtils.pxToDp(context, 28),
                  fontSize: FontUtils.pxToSp(context, 25),
                ),
              ),
            ],
          )
        ],
      ],
    );
  }
}
