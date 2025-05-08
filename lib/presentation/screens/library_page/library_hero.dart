import 'package:flutter/material.dart';
import 'package:phynd_app/core/helpers/responsive_helper.dart';
import 'package:phynd_app/presentation/screens/library_page/library_hero_overlay.dart';
import 'package:phynd_app/presentation/widgets/image_video.dart';

class LibraryHero extends StatelessWidget {
  const LibraryHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black, // fallback background
      child: Stack(
        children: [
          ImageVideo(
            imageUrl:
                'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
            videoUrl:
                'https://cdn.pixabay.com/video/2025/04/29/275633_large.mp4',
            aspectRatio: ResponsiveHelper.getResponsiveSize(
                MediaQuery.of(context).size.width,
                3 / 1,
                [3 / 1, 3 / 1, 4 / 1, 4 / 1]),
          ),
          Positioned.fill(
            child: LibraryHeroOverlay(
              title: 'Featured Game',
              description:
                  'Experience the next level of gaming with our featured title',
              onPlayPressed: () {},
              onLearnMorePressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
