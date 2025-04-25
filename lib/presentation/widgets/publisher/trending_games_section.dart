import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/widgets/cards/gameplay_clip_card.dart';
import 'package:phynd_app/presentation/widgets/common/section_heading.dart';

class TrendingGamesSection extends StatelessWidget {
  final List<Map<String, dynamic>> trendingGames;
  final Color primaryColor;
  final Color textColor;

  const TrendingGamesSection({
    super.key,
    required this.trendingGames,
    required this.primaryColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          title: 'Trending Games',
          textColor: textColor,
          accentColor: primaryColor,
          onSeeAllPressed: () {
            // Navigate to all trending games
          },
        ),
        const SizedBox(height: 12),

        // Display trending game cards using GameplayClipCard
        SizedBox(
          height: 320,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: trendingGames.length,
            itemBuilder: (context, index) {
              final game = trendingGames[index];
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
