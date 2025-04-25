import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/widgets/common/section_heading.dart';

class LatestUpdatesSection extends StatelessWidget {
  final List<Map<String, dynamic>> latestUpdates;
  final Color primaryColor;
  final Color textColor;

  const LatestUpdatesSection({
    super.key,
    required this.latestUpdates,
    required this.primaryColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          title: 'Latest Updates',
          textColor: textColor,
          accentColor: primaryColor,
          onSeeAllPressed: () {
            // Navigate to all updates
          },
        ),
        const SizedBox(height: 12),

        // Display update cards
        SizedBox(
          height: 320,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: latestUpdates.length,
            itemBuilder: (context, index) {
              final update = latestUpdates[index];
              return _buildUpdateCard(
                context,
                update['thumbnailUrl'] as String,
                update['timeAgo'] as String,
                update['duration'] as String,
                update['clipTitle'] as String,
                update['friendsWatched'] as int,
                update['friendAvatarUrls'] as List<String>,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUpdateCard(
    BuildContext context,
    String thumbnailUrl,
    String timeAgo,
    String duration,
    String title,
    int friendsWatched,
    List<String> friendAvatarUrls,
  ) {
    return Container(
      width: 320,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black26,
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail with time indicators
          Stack(
            children: [
              // Thumbnail image
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  thumbnailUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey.shade800,
                    child: const Center(
                        child: Icon(Icons.broken_image, color: Colors.white)),
                  ),
                ),
              ),

              // Time ago indicator
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    timeAgo,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // Duration indicator
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    duration,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Update details
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Update title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 8),

                // Friends watched section
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      color: textColor.withOpacity(0.7),
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$friendsWatched Friends Watched',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),

                    // Friend avatars
                    if (friendAvatarUrls.isNotEmpty)
                      SizedBox(
                        height: 24,
                        width: friendAvatarUrls.length * 16.0 + 8,
                        child: Stack(
                          children: [
                            for (int i = 0;
                                i < friendAvatarUrls.length && i < 4;
                                i++)
                              Positioned(
                                left: i * 16.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.black26, width: 1),
                                  ),
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundImage:
                                        NetworkImage(friendAvatarUrls[i]),
                                    backgroundColor: Colors.grey.shade800,
                                  ),
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
        ],
      ),
    );
  }
}
