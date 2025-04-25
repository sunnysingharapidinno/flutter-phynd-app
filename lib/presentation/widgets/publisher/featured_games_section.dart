import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/widgets/cards/gameplay_clip_card.dart';
import 'package:phynd_app/presentation/widgets/common/section_heading.dart';

class FeaturedGamesSection extends StatelessWidget {
  final List<Map<String, dynamic>> featuredGames;
  final Color primaryColor;
  final Color textColor;

  const FeaturedGamesSection({
    super.key,
    required this.featuredGames,
    required this.primaryColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          title: 'Featured Games',
          textColor: textColor,
          accentColor: primaryColor,
          onSeeAllPressed: () {
            // Navigate to all featured games
          },
        ),
        const SizedBox(height: 12),

        // Display featured game cards using GameplayClipCard
        SizedBox(
          height: 320,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: featuredGames.length,
            itemBuilder: (context, index) {
              final game = featuredGames[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GameplayClipCard(
                  thumbnailUrl: game['thumbnailUrl'] as String,
                  timeAgo: game['timeAgo'] as String,
                  duration: game['duration'] as String,
                  username: game['username'] as String,
                  userAvatarUrl: game['userAvatarUrl'] as String,
                  isVerified: game['isVerified'] as bool,
                  clipTitle: game['clipTitle'] as String,
                  friendsWatched: game['friendsWatched'] as int,
                  friendAvatarUrls: game['friendAvatarUrls'] as List<String>,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
