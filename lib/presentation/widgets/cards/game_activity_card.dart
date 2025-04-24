import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

class GameActivityCard extends StatelessWidget {
  final String thumbnailUrl;
  final String timeAgo;
  final String gameTitle;
  final String duration;
  final String userName;
  final bool isVerified;
  final String clipTitle;
  final int friendsWatchedCount;
  final List<String> friendAvatars;
  final VoidCallback? onTap;

  const GameActivityCard({
    Key? key,
    required this.thumbnailUrl,
    required this.timeAgo,
    required this.gameTitle,
    required this.duration,
    required this.userName,
    this.isVerified = false,
    required this.clipTitle,
    required this.friendsWatchedCount,
    required this.friendAvatars,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        decoration: BoxDecoration(
          color: theme.get('cardBg'),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.get('text'), width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Thumbnail with overlays
            Stack(
              children: [
                // Thumbnail image
                Image.network(
                  thumbnailUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 160,
                    color: theme.get('surface'),
                    child: Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: theme.get('onSurface'),
                      ),
                    ),
                  ),
                ),

                // Time ago badge
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: theme.get('primary'),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      timeAgo,
                      style: TextStyle(
                        color: theme.get('textOnPrimary'),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),

                // Game title and duration
                Positioned(
                  bottom: 8,
                  left: 8,
                  right: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Game title with ESRB
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: theme.get('cardBg').withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(
                              gameTitle,
                              style: TextStyle(
                                color: theme.get('text'),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: theme.get('textOnPrimary'),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Text(
                                'T',
                                style: TextStyle(
                                  color: theme.get('cardBg'),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Duration
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: theme.get('cardBg').withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          duration,
                          style: TextStyle(
                            color: theme.get('text'),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Content area
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Username with verified badge
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: theme.get('accent'),
                        child: Icon(
                          Icons.person,
                          size: 16,
                          color: theme.get('textOnPrimary'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        userName,
                        style: TextStyle(
                          color: theme.get('text'),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (isVerified) ...[
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: theme.get('primary'),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            size: 10,
                            color: theme.get('textOnPrimary'),
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Clip title
                  Text(
                    clipTitle,
                    style: TextStyle(
                      color: theme.get('text'),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 6),

                  // Compact version of Friends who watched with avatars
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Row(
                      children: [
                        Icon(
                          Icons.people,
                          size: 14,
                          color: theme.get('textSecondary'),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$friendsWatchedCount Friends',
                          style: TextStyle(
                            color: theme.get('textSecondary'),
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        // Friend avatars with stack
                        SizedBox(
                          width: 50,
                          height: 16,
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              for (int i = 0;
                                  i <
                                      (friendAvatars.length > 4
                                          ? 4
                                          : friendAvatars.length);
                                  i++)
                                Positioned(
                                  right: i * 10.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: theme.get('cardBg'),
                                        width: 1,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundColor: theme.get('surface'),
                                      backgroundImage:
                                          NetworkImage(friendAvatars[i]),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
