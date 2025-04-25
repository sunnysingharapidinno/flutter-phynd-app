import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

class GameActivityCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String username;
  final String timestamp;
  final bool isLive;
  final VoidCallback? onTap;

  const GameActivityCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.username,
    required this.timestamp,
    this.isLive = false,
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
          border: Border.all(color: theme.get('borderColor')),
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
                  imageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 160,
                    color: theme.get('cardBg'),
                    child: Icon(
                      Icons.image_not_supported,
                      color: theme.get('text'),
                    ),
                  ),
                ),

                // Time/Live badge
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: isLive
                          ? theme.get('trialPrice')
                          : theme.get('primary'),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isLive)
                          Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.only(right: 4),
                            decoration: BoxDecoration(
                              color: theme.get('textOnPrimary'),
                              shape: BoxShape.circle,
                            ),
                          ),
                        Text(
                          timestamp,
                          style: TextStyle(
                            color: theme.get('textOnPrimary'),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Content area
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: theme.get('text'),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    username,
                    style: TextStyle(
                      color: theme.get('textSecondary'),
                      fontSize: 14,
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
