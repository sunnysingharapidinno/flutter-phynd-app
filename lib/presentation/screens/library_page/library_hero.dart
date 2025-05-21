import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/hero_game_badge.dart';
import 'package:phynd_app/presentation/widgets/image_video.dart';
import 'package:phynd_app/presentation/screens/library_page/models/hero_data.dart';

class LibraryHero extends StatelessWidget {
  final HeroData heroData;

  
  const LibraryHero({
    super.key,
    required this.heroData,
  });

  @override
  Widget build(BuildContext context) {
    print('heroData: ${heroData.gameTitle}');
    return Container(
      height: SizeUtils.pxToDp(context, 565),
      width: double.infinity,
      color: Colors.black, // fallback background
      child: Stack(
        children: [
          // ImageVideo at the background, with full width and height
          ImageVideo(
            imageUrl: heroData.imageUrl,
            videoUrl: heroData.videoUrl,
            width: double.infinity, // Ensuring full width
            height: double.infinity, // Ensuring full height
          ),
          // LinearGradient overlay, covering full width
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  Color.fromRGBO(27, 29, 38, 0.0),
                  Color.fromRGBO(27, 29, 38, 0.8),
                  Color.fromRGBO(27, 29, 38, 0.9),
                ],
                stops: [0.31, 0.5491, 0.8026],
              ),
            ),
          ),
          // HeroGameBadge positioned at the top-left
          Positioned(
            top: SizeUtils.pxToDp(context, 80),
            left: SizeUtils.pxToDp(context, 56),
            child: IntrinsicWidth(
              child: IntrinsicHeight(
                child: HeroGameBadge(
                  gameTextImg: heroData.gameTextImg,
                  releaseYear: heroData.releaseYear,
                  publisherName: (heroData.companyName != null && heroData.companyName!.isNotEmpty) 
                      ? heroData.companyName! 
                      : "Unknown Company",
                  esrb: heroData.esrb,
                  friendsCount: heroData.friendsCount,
                  onlineCount: heroData.onlineCount,
                  onPlayPressed: () {},
                  onLearnMorePressed: () {},
                  showGameTitle: true,
                  gameTitle: heroData.gameTitle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
