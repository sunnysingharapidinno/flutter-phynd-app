import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/hero_game_badge.dart';
import 'package:phynd_app/presentation/widgets/image_video.dart';

class LibraryHero extends StatelessWidget {
  const LibraryHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeUtils.pxToDp(context, 565),
      width: double.infinity,
      color: Colors.black, // fallback background
      child: Stack(
        children: [
          // ImageVideo at the background, with full width and height
          const ImageVideo(
            imageUrl:
                'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
            videoUrl:
                'https://cdn.pixabay.com/video/2025/04/29/275633_large.mp4',

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
                  onPlayPressed: () {},
                  onLearnMorePressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
