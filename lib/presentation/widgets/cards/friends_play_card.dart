import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/cards/clip_card/game_clip_card.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';

class FriendsPlayCard extends StatelessWidget {
  // Parameters for the GameClipCard part (image with overlays)
  final String? gameImageUrl;
  final String? gameTitle; // This will be the title overlaid on the image
  final String? esrbRatingImageUrl;

  // Parameters for the bottom user info section
  final String? userAvatarUrl;
  final String? userGamertag;
  final String? currentlyPlayingGame;

  final VoidCallback? onTap;
  final double? width; // Total width of this card
  final double? height; // Total height of this card

  const FriendsPlayCard({
    super.key,
    this.gameImageUrl,
    this.gameTitle,
    this.esrbRatingImageUrl,
    this.userAvatarUrl,
    this.userGamertag,
    this.currentlyPlayingGame,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text');
    final subTextColor = theme?.get('subText');
    final cardColor = theme?.get('cardBg');

    final double cardWidth = SizeUtils.pxToDp(context, width ?? 320);
    final double totalCardHeight = SizeUtils.pxToDp(context, height ?? 280);

    // Estimate height for the bottom user info section
    // This should be enough for an avatar, gamertag line, and currently playing line with padding
    final double userInfoSectionHeight = SizeUtils.pxToDp(context, 85);
    final double gameClipCardHeight = totalCardHeight - userInfoSectionHeight;

    return RemoteControlWrapper(
      onTap: onTap,
      child: SizedBox(
        width: cardWidth,
        height: totalCardHeight,
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Important for Column height based on children
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reusing GameClipCard for the top image part with overlays
            GameClipCard(
              thumbnailUrl: gameImageUrl,
              title:
                  gameTitle, // This title is overlaid on the image by GameClipCard
              esrbRatingImageUrl: esrbRatingImageUrl,
              hideRating: true, // As per the new screenshot, no star ratings
              width: double.infinity, // Pass width directly in dp
              height: 255, // Pass height for the image part in dp
              onTap:
                  null, // onTap for the whole FriendsPlayCard is handled by RemoteControlWrapper
            ),
            // Bottom User Info Section
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeUtils.pxToDp(context, 12),
                vertical: SizeUtils.pxToDp(
                    context, 10), // Vertical padding for this section
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ImageThumbnail(
                        imageUrl: userAvatarUrl!,
                        height: 40,
                        width: 40,
                        borderRadius: 40, // Circular
                        isNetwork: true,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: SizeUtils.pxToDp(context, 8)),
                      if (userGamertag != null)
                        Expanded(
                          child: Text(
                            userGamertag ?? '',
                            style: TextStyle(
                              color: textColor,
                              fontSize: FontUtils.pxToSp(context, 28),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Exo2',
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: SizeUtils.pxToDp(context, 3)),
                  Row(
                    children: [
                      Text(
                        'Currently Playing:',
                        style: TextStyle(
                          color: textColor,
                          fontSize: FontUtils.pxToSp(context, 24),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(width: SizeUtils.pxToDp(context, 16)),
                      Text(
                        currentlyPlayingGame ?? '',
                        style: TextStyle(
                          color: textColor,
                          fontSize: FontUtils.pxToSp(context, 24),
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )
                  // if (currentlyPlayingGame != null &&
                  //   RichText(
                  //     text: TextSpan(
                  //         style: TextStyle(
                  //             color: textColor,
                  //             fontSize: FontUtils.pxToSp(context, 24),
                  //             fontFamily: 'Exo2',
                  //             fontWeight: FontWeight.w300),
                  //         children: [
                  //           const TextSpan(text: 'Currently Playing: '),
                  //           TextSpan(
                  //             text: currentlyPlayingGame!,
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 color: textColor),
                  //           ),
                  //         ]),
                  //     maxLines: 1,
                  //     overflow: TextOverflow.ellipsis,
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
