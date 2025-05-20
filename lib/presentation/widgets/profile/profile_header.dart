import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/app_images.dart';
import 'package:phynd_app/core/enums/friend_status.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/buttons/primary_button.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';

class ProfileHeader extends StatefulWidget {
  final String username;
  final bool isOnline;
  final String? avatar;

  final String? currentlyPlaying;
  final bool isOtherProfile;
  final int? friendsCount;
  final int? followingCount;
  final int? mutualFriendsCount;
  final FriendStatus? friendStatus;
  final Future<void> Function(FriendStatus?)? onFriendButtonPressed;

  const ProfileHeader({
    super.key,
    required this.username,
    required this.isOnline,
    this.avatar,
    this.currentlyPlaying,
    this.isOtherProfile = false,
    this.friendsCount,
    this.followingCount,
    this.mutualFriendsCount,
    this.friendStatus,
    this.onFriendButtonPressed,
  });

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  bool _friendButtonLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final primaryColor = theme?.get('primary');
    final textColor = theme?.get('text');
    final backgroundColor = theme?.get('profileHeaderOverlay');
    final subText2 = theme?.get('subText2');

    String getFriendButtonText() {
      if (widget.friendStatus == FriendStatus.pending) {
        return 'Pending';
      } else if (widget.friendStatus == FriendStatus.accepted) {
        return 'Unfriend';
      }
      return 'Add Friend';
    }

    return Container(
      width: double.infinity,
      height: SizeUtils.pxToDp(context, widget.isOtherProfile ? 472 : 330),
      padding: EdgeInsets.symmetric(
          horizontal: SizeUtils.pxToDp(context, 56),
          vertical: SizeUtils.pxToDp(context, 40)),
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: widget.isOtherProfile
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              ImageThumbnail(
                borderRadius: 250,
                imageUrl: widget.avatar ?? AppImages.profileAvatarGradient,
                width: 250,
                height: 250,
                fit: BoxFit.cover,
                isNetwork: widget.avatar != null,
              ),
              SizedBox(width: SizeUtils.pxToDp(context, 24)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.username,
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
                          color: widget.isOnline ? Colors.green : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: SizeUtils.pxToDp(context, 12)),
                      Text(
                        widget.isOnline ? 'Online' : 'Offline',
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
                            "${widget.friendsCount ?? 0}",
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
                            "${widget.followingCount ?? 0}",
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
          if (widget.isOtherProfile) ...[
            SizedBox(height: SizeUtils.pxToDp(context, 64)),
            Row(
              children: [
                SizedBox(
                  width: SizeUtils.pxToDp(context, 472),
                  height: SizeUtils.pxToDp(context, 78),
                  child: PrimaryButton(
                    text: getFriendButtonText(),
                    isLoading: _friendButtonLoading,
                    onPressed: () async {
                      if (widget.friendStatus == FriendStatus.pending) {
                        return;
                      }

                      try {
                        setState(() {
                          _friendButtonLoading = true;
                        });
                        await widget.onFriendButtonPressed
                            ?.call(widget.friendStatus);
                      } catch (e) {
                        debugPrint(e.toString());
                      } finally {
                        setState(() {
                          _friendButtonLoading = false;
                        });
                      }
                    },
                    borderColor: textColor,
                    borderRadius: 16,
                    backgroundColor: backgroundColor,
                    fontSize: 36,
                  ),
                ),
                SizedBox(width: SizeUtils.pxToDp(context, 80)),
                const ImageThumbnail(
                  imageUrl: AppImages.peopleLogoGreyBg,
                  height: 75,
                  width: 75,
                  fit: BoxFit.contain,
                  isNetwork: false,
                ),
                SizedBox(width: SizeUtils.pxToDp(context, 16)),
                Text(
                  '${widget.mutualFriendsCount ?? 0} Mutual Friends ',
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
