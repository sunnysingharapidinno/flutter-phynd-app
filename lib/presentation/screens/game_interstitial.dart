import 'package:flutter/material.dart';
import 'package:phynd_app/core/theme/app_colors.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/buttons/primary_button.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';

class GameInterstitialPage extends StatefulWidget {
  const GameInterstitialPage({super.key});

  @override
  State<GameInterstitialPage> createState() => _GameInterstitialPageState();
}

class _GameInterstitialPageState extends State<GameInterstitialPage> {
  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return Stack(
      children: [
        // Background Image
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              AppColors.black.withOpacity(0.5),
              BlendMode.darken,
            ),
            child: ImageThumbnail(
              imageUrl:
                  'https://xstrela-alpha.s3.us-east-1.amazonaws.com/general/2025/03/16/3bc8bc2f85184505aec7858df30ac041.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Content
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(SizeUtils.pxToDp(context, 80)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Game Title Row
                Row(
                  children: [
                    // Game Logo (network image)
                    ImageThumbnail(
                      imageUrl:
                          'https://www.forgottenplayland.com/_next/image?url=%2Fassets%2Flogo.webp&w=640&q=75',
                      width: SizeUtils.pxToDp(context, 1212),
                      height: SizeUtils.pxToDp(context, 476),
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: SizeUtils.pxToDp(context, 16)),
                    // ESRB Rating (also a network image)
                    ImageThumbnail(
                      imageUrl:
                          'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/Teen.png',
                      width: SizeUtils.pxToDp(context, 92),
                      height: SizeUtils.pxToDp(context, 111),
                      fit: BoxFit.contain,
                    ),
                  ],
                ),

                SizedBox(height: SizeUtils.pxToDp(context, 16)),

                // Game Tags
                Row(
                  children: [
                    _buildTag('Action'),
                    SizedBox(width: SizeUtils.pxToDp(context, 24)),
                    _buildTag('Adventure'),
                    SizedBox(width: SizeUtils.pxToDp(context, 24)),
                    _buildTag('Racing'),
                    SizedBox(width: SizeUtils.pxToDp(context, 24)),
                    _buildTag('Local Co-Op'),
                  ],
                ),

                const SizedBox(height: 16),

                // Game Description

                Container(
                  constraints:
                      BoxConstraints(maxWidth: SizeUtils.pxToDp(context, 928)),
                  child: Text(
                    'A whimsical free-to-play social party game. Set in an isolated and abandoned attic, a group of small plush toy characters known as Plushkyns have been left to their own devices.',
                    maxLines: 3,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: FontUtils.pxToSp(context, 57),
                      color: AppColors.text,
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Action Buttons Row
                Row(
                  children: [
                    SizedBox(
                      width: SizeUtils.pxToDp(context, 394),
                      child: PrimaryButton(
                        text: 'Play',
                        onPressed: () {},
                        backgroundColor: AppColors.buttonPrimary,
                        icon: Icons.play_arrow,
                      ),
                    ),
                    SizedBox(width: SizeUtils.pxToDp(context, 64)),
                    SizedBox(
                      width: SizeUtils.pxToDp(context, 519),
                      child: PrimaryButton(
                        text: 'More Info',
                        onPressed: () {},
                        isTransparent: true,
                        icon: Icons.info_outline,
                      ),
                    ),
                    SizedBox(width: SizeUtils.pxToDp(context, 64)),
                    SizedBox(
                      width: SizeUtils.pxToDp(context, 448),
                      child: PrimaryButton(
                        text: 'Follow',
                        onPressed: () {},
                        isTransparent: true,
                        icon: Icons.add,
                      ),
                    ),
                    SizedBox(width: SizeUtils.pxToDp(context, 64)),
                    CircleAvatar(
                      backgroundColor: Colors.white60,
                      radius: SizeUtils.pxToDp(context, 36),
                      child: IconButton(
                        icon: Icon(Icons.favorite, color: Colors.white),
                        onPressed: () {
                          // Your action
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Friends Playing Section
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.onlineCountBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.group,
                            color: AppColors.text,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '86 Friends Play',
                            style: TextStyle(
                              color: AppColors.text,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.onlineCountBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: AppColors.onlineIndicator,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '12 online',
                            style: TextStyle(
                              color: AppColors.text,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.gameTagBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.text,
          fontSize: 14,
        ),
      ),
    );
  }
}
