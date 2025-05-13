import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/app_images.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/buttons/primary_button.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';

class ProfileHeader extends StatelessWidget {
  final String username;
  final bool isOnline;
  final String? avatar;

  final String? currentlyPlaying;
  final bool isOtherProfile;

  const ProfileHeader({
    super.key,
    required this.username,
    required this.isOnline,
    this.avatar,
    this.currentlyPlaying,
    this.isOtherProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final primaryColor = theme?.get('primary');
    final textColor = theme?.get('text');
    final backgroundColor = theme?.get('profileHeaderOverlay');
    final subText2 = theme?.get('subText2');

    return Container(
      width: double.infinity,
      height: SizeUtils.pxToDp(context, isOtherProfile ? 472 : 330),
      padding: EdgeInsets.symmetric(
          horizontal: SizeUtils.pxToDp(context, 56),
          vertical: SizeUtils.pxToDp(context, 40)),
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: isOtherProfile
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              ImageThumbnail(
                borderRadius:
                    BorderRadius.circular(SizeUtils.pxToDp(context, 250)),
                imageUrl: avatar ?? AppImages.profileAvatarGradient,
                width: SizeUtils.pxToDp(context, 250),
                height: SizeUtils.pxToDp(context, 250),
                fit: BoxFit.cover,
                isNetwork: avatar != null,
              ),
              SizedBox(width: SizeUtils.pxToDp(context, 24)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: TextStyle(
                          fontSize: FontUtils.pxToSp(context, 48),
                          fontWeight: FontWeight.w600,
                          color: textColor,
                          fontFamily: 'Exo2',
                        ),
                      ),
                      SizedBox(width: SizeUtils.pxToDp(context, 24)),
                      Container(
                        width: SizeUtils.pxToDp(context, 16),
                        height: SizeUtils.pxToDp(context, 16),
                        decoration: BoxDecoration(
                          color: isOnline ? Colors.green : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: SizeUtils.pxToDp(context, 12)),
                      Text(
                        isOnline ? 'Online' : 'Offline',
                        style: TextStyle(
                          fontSize: FontUtils.pxToSp(context, 24),
                          color: textColor,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: SizeUtils.pxToDp(context, 8)),
                  Row(
                    children: [
                      Text(
                        "Recently Played:",
                        style: TextStyle(
                          fontSize: FontUtils.pxToSp(context, 28),
                          fontWeight: FontWeight.w300,
                          color: textColor,
                        ),
                      ),
                      SizedBox(width: SizeUtils.pxToDp(context, 16)),
                      Text(
                        "Marvel Rivals",
                        style: TextStyle(
                          fontSize: FontUtils.pxToSp(context, 28),
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: SizeUtils.pxToDp(context, 48)),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "1.4K",
                            style: TextStyle(
                              fontSize: FontUtils.pxToSp(context, 24),
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                          Text(
                            "Friends",
                            style: TextStyle(
                              fontSize: FontUtils.pxToSp(context, 24),
                              fontWeight: FontWeight.w400,
                              color: textColor,
                            ),
                          )
                        ],
                      ),
                      SizedBox(width: SizeUtils.pxToDp(context, 40)),
                      Container(
                        width: SizeUtils.pxToDp(context, 3),
                        height: SizeUtils.pxToDp(context, 55),
                        color: primaryColor,
                      ),
                      SizedBox(width: SizeUtils.pxToDp(context, 40)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "680",
                            style: TextStyle(
                              fontSize: FontUtils.pxToSp(context, 24),
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                          Text(
                            "Following",
                            style: TextStyle(
                              fontSize: FontUtils.pxToSp(context, 24),
                              fontWeight: FontWeight.w400,
                              color: textColor,
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          if (isOtherProfile) ...[
            SizedBox(height: SizeUtils.pxToDp(context, 64)),
            Row(
              children: [
                SizedBox(
                  width: SizeUtils.pxToDp(context, 472),
                  height: SizeUtils.pxToDp(context, 78),
                  child: PrimaryButton(
                    text: 'Add Friend',
                    onPressed: () {},
                    borderColor: textColor,
                    borderRadius: 16,
                    backgroundColor: backgroundColor,
                  ),
                ),
                SizedBox(width: SizeUtils.pxToDp(context, 80)),
                ImageThumbnail(
                  imageUrl: AppImages.peopleLogoGreyBg,
                  height: SizeUtils.pxToDp(context, 75),
                  width: SizeUtils.pxToDp(context, 75),
                  fit: BoxFit.contain,
                  isNetwork: false,
                ),
                SizedBox(width: SizeUtils.pxToDp(context, 16)),
                Text(
                  '34 Mutual Friends ',
                  style: TextStyle(
                    color: subText2,
                    fontSize: FontUtils.pxToSp(context, 36),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          ]
        ],
      ),
    );
  }
}
