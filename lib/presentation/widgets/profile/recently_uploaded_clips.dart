import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/widgets/cards/gameplay_clip_card.dart';
import 'package:phynd_app/presentation/widgets/common/section_heading.dart';

class RecentlyUploadedClips extends StatelessWidget {
  const RecentlyUploadedClips({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for clips
    final List<Map<String, dynamic>> sampleClips = [
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.amazonaws.com/images/Fortnite.jpeg',
        'timeAgo': '2 Hrs Ago',
        'duration': '8:14',
        'username': 'Marcus Mantis',
        'userAvatarUrl':
            'https://api.dicebear.com/7.x/avataaars/png?seed=Marcus&backgroundColor=b6e3f4',
        'isVerified': true,
        'clipTitle': 'Winning my first round in Season 6',
        'friendsWatched': 35,
        'friendAvatarUrls': <String>[
          'https://api.dicebear.com/7.x/avataaars/png?seed=friend1',
          'https://api.dicebear.com/7.x/avataaars/png?seed=friend2',
          'https://api.dicebear.com/7.x/avataaars/png?seed=friend3',
          'https://api.dicebear.com/7.x/avataaars/png?seed=friend4',
          'https://api.dicebear.com/7.x/avataaars/png?seed=friend5',
        ],
      },
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.amazonaws.com/images/Fortnite.jpeg',
        'timeAgo': '1 Day Ago',
        'duration': '5:22',
        'username': 'Marcus Mantis',
        'userAvatarUrl':
            'https://api.dicebear.com/7.x/avataaars/png?seed=Marcus&backgroundColor=b6e3f4',
        'isVerified': true,
        'clipTitle': 'Amazing squad wipe in Apex',
        'friendsWatched': 18,
        'friendAvatarUrls': <String>[
          'https://api.dicebear.com/7.x/avataaars/png?seed=friend6',
          'https://api.dicebear.com/7.x/avataaars/png?seed=friend7',
          'https://api.dicebear.com/7.x/avataaars/png?seed=friend8',
        ],
      },
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.amazonaws.com/images/Fortnite.jpeg',
        'timeAgo': '3 Days Ago',
        'duration': '10:45',
        'username': 'Marcus Mantis',
        'userAvatarUrl':
            'https://api.dicebear.com/7.x/avataaars/png?seed=Marcus&backgroundColor=b6e3f4',
        'isVerified': true,
        'clipTitle': 'Epic boss battle in Elden Ring',
        'friendsWatched': 42,
        'friendAvatarUrls': <String>[
          'https://api.dicebear.com/7.x/avataaars/png?seed=friend9',
          'https://api.dicebear.com/7.x/avataaars/png?seed=friend10',
          'https://api.dicebear.com/7.x/avataaars/png?seed=friend11',
          'https://api.dicebear.com/7.x/avataaars/png?seed=friend12',
        ],
      },
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.amazonaws.com/images/Fortnite.jpeg',
        'timeAgo': '1 Week Ago',
        'duration': '3:17',
        'username': 'Marcus Mantis',
        'userAvatarUrl':
            'https://api.dicebear.com/7.x/avataaars/png?seed=Marcus&backgroundColor=b6e3f4',
        'isVerified': true,
        'clipTitle': 'Clutch play in Call of Duty',
        'friendsWatched': 27,
        'friendAvatarUrls': <String>[
          'https://api.dicebear.com/7.x/avataaars/png?seed=friend13',
          'https://api.dicebear.com/7.x/avataaars/png?seed=friend14',
          'https://api.dicebear.com/7.x/avataaars/png?seed=friend15',
        ],
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeading(
            title: 'Recently Uploaded Clips',
            textColor: Colors.white,
            accentColor: Colors.deepPurple,
            onSeeAllPressed: () {
              // Navigate to all clips
            },
          ),
          const SizedBox(height: 12),

          // Display clip cards
          SizedBox(
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: sampleClips.length,
              itemBuilder: (context, index) {
                final clip = sampleClips[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GameplayClipCard(
                    thumbnailUrl: clip['thumbnailUrl'] as String,
                    timeAgo: clip['timeAgo'] as String,
                    duration: clip['duration'] as String,
                    username: clip['username'] as String,
                    userAvatarUrl: clip['userAvatarUrl'] as String,
                    isVerified: clip['isVerified'] as bool,
                    clipTitle: clip['clipTitle'] as String,
                    friendsWatched: clip['friendsWatched'] as int,
                    friendAvatarUrls:
                        (clip['friendAvatarUrls'] as List<String>),
                  ),
                );
              },
            ),
          ),

          // If no clips are available, show this message
          if (sampleClips.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'No clips uploaded yet',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
