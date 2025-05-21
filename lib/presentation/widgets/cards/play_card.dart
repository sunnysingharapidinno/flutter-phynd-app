import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/theme/app_colors.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';

class PlayCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double rating;
  final bool isFree;
  final bool isExclusive;
  final bool isMultiplayer;
  final bool isSinglePlayer;
  final String? esrbRating;
  final VoidCallback? onTap;
  final double width;
  final List<PlatformOption>? platformOptions;
  final List<ControllerOption>? controllerOptions;

  const PlayCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    this.rating = 0,
    this.isFree = false,
    this.isExclusive = false,
    this.isMultiplayer = false,
    this.isSinglePlayer = false,
    this.esrbRating,
    this.onTap,
    this.width = 350,
    this.platformOptions,
    this.controllerOptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;

    return RemoteControlWrapper(
      onTap: onTap,
      child: Container(
        width: width,
        height: 200.0,
        decoration: BoxDecoration(
          color: theme.get('cardBg'),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.get('borderColor'),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              // Game Image Background
              Positioned.fill(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: theme.get('surface'),
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                          color: theme.get('onSurface'),
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: theme.get('surface'),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.image_not_supported,
                            color: theme.get('onSurface'),
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Image not available',
                            style: TextStyle(
                              color: theme.get('onSurface'),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Exclusive Badge
              if (isExclusive)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: theme.get('primary').withOpacity(0.9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'PHYND Exclusive',
                      style: TextStyle(
                        color: theme.get('textOnPrimary'),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              // Game Info (overlay on main card)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        theme.get('cardBg').withOpacity(0.9),
                        theme.get('cardBg').withOpacity(0.6),
                        Colors.transparent,
                      ],
                      stops: const [0.4, 0.8, 1.0],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Star Rating
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < rating
                                ? Icons.star
                                : index < rating + 0.5
                                    ? Icons.star_half
                                    : Icons.star_border,
                            color: AppColors.gameCardRatingColor,
                            size: 18,
                          );
                        }),
                      ),
                      const SizedBox(height: 4),

                      // Game Title
                      Text(
                        title,
                        style: TextStyle(
                          color: theme.get('text'),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),

                      // Game Details Row
                      Row(
                        children: [
                          // Free Tag
                          if (isFree)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.gameCardTagColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'FREE',
                                style: TextStyle(
                                  color: theme.get('textOnPrimary'),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          if (isFree) const SizedBox(width: 8),

                          // Multiplayer
                          if (isMultiplayer) ...[
                            Icon(
                              Icons.people,
                              size: 14,
                              color: theme.get('textSecondary'),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Multiplayer',
                              style: TextStyle(
                                color: theme.get('textSecondary'),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],

                          // Single Player
                          if (isSinglePlayer) ...[
                            Icon(
                              Icons.person,
                              size: 14,
                              color: theme.get('textSecondary'),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Single Player',
                              style: TextStyle(
                                color: theme.get('textSecondary'),
                                fontSize: 12,
                              ),
                            ),
                          ],

                          const Spacer(),

                          // ESRB Rating
                          if (esrbRating != null)
                            Container(
                              width: 33.219,
                              height: 40,
                              child: Image.network(
                                esrbRating!,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(
                                  Icons.image_not_supported,
                                  color: theme.get('onSurface'),
                                  size: 16,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlatformOption {
  final IconData icon;
  final String name;

  const PlatformOption({
    required this.icon,
    required this.name,
  });

  static const windows = PlatformOption(
    icon: Icons.desktop_windows,
    name: 'Windows',
  );

  static const mobile = PlatformOption(
    icon: Icons.phone_android,
    name: 'Mobile',
  );

  static const cloud = PlatformOption(
    icon: Icons.cloud,
    name: 'Cloud',
  );
}

class ControllerOption {
  final IconData icon;
  final String name;

  const ControllerOption({
    required this.icon,
    required this.name,
  });

  static const gamepad = ControllerOption(
    icon: Icons.gamepad,
    name: 'Gamepad',
  );

  static const touchscreen = ControllerOption(
    icon: Icons.touch_app,
    name: 'Touchscreen',
  );

  static const keyboard = ControllerOption(
    icon: Icons.keyboard,
    name: 'Keyboard',
  );
}
