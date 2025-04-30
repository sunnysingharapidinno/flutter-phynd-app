import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';

class ShortsCard extends StatelessWidget {
  final String thumbnailUrl;
  final String userName;
  final String title;
  final bool isVerified;
  final VoidCallback? onTap;
  final double width;

  const ShortsCard({
    Key? key,
    required this.thumbnailUrl,
    required this.userName,
    required this.title,
    this.isVerified = false,
    this.onTap,
    this.width = 240,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;

    return RemoteControlWrapper(
      onEnter: onTap,
      child: Container(
        width: width,
        height: 320,
        decoration: BoxDecoration(
          color: theme.get('cardBg'),
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Expanded(
              child: Image.network(
                thumbnailUrl,
                fit: BoxFit.cover,
                width: width,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: theme.get('surface'),
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: theme.get('onSurface'),
                    ),
                  ),
                ),
              ),
            ),

            // Content area
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User info with verified badge
                  Row(
                    children: [
                      // Profile image
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.get('accent'),
                        ),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              'https://i.imgur.com/VvvURHZ.jpeg',
                              width: 24,
                              height: 24,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                Icons.person,
                                size: 16,
                                color: theme.get('textOnPrimary'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Username
                      Text(
                        userName,
                        style: TextStyle(
                          color: theme.get('text'),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      // Verified badge
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

                  const SizedBox(height: 8),

                  // Title
                  Text(
                    title,
                    style: TextStyle(
                      color: theme.get('text'),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Warning stripe at bottom
            // Container(
            //   width: double.infinity,
            //   height: 16,
            //   decoration: const BoxDecoration(
            //     gradient: LinearGradient(
            //       begin: Alignment.centerLeft,
            //       end: Alignment.centerRight,
            //       colors: [
            //         Colors.yellow,
            //         Colors.black,
            //         Colors.yellow,
            //         Colors.black,
            //         Colors.yellow,
            //         Colors.black,
            //         Colors.yellow,
            //         Colors.black,
            //       ],
            //       stops: [0.0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875],
            //     ),
            //   ),
            //   alignment: Alignment.center,
            //   child: Container(
            //     height: 16,
            //     color: Colors.black.withOpacity(0.6),
            //     padding: const EdgeInsets.symmetric(horizontal: 8),
            //     child: const Center(
            //       child: Text(
            //         'INDUSTRIAL EQUIPMENT IN USE',
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 9,
            //           fontWeight: FontWeight.bold,
            //           letterSpacing: 0.5,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
