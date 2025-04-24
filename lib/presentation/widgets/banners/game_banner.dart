import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

class GameBanner extends StatelessWidget {
  final String imageUrl;
  final String gameTitle;
  final String gameSubtitle;
  final String? badgeText;
  final double rating;
  final int playerCount;
  final String gameGenre;
  final String releaseDate;
  final List<String> platforms;
  final VoidCallback? onPlayTap;

  const GameBanner({
    Key? key,
    this.imageUrl =
        'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    this.gameTitle = 'CALL OF DUTY',
    this.gameSubtitle = 'MODERN WARFARE III',
    this.badgeText,
    this.rating = 4.5,
    this.playerCount = 254300,
    this.gameGenre = 'FPS, Action, Multiplayer',
    this.releaseDate = 'Nov 10, 2023',
    this.platforms = const ['PC', 'Xbox', 'PlayStation'],
    this.onPlayTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;

    return Container(
      height: 350,
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.get('cardBg'),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: theme.get('cardBg'),
              child: Icon(
                Icons.image_not_supported,
                color: theme.get('text'),
              ),
            ),
          ),

          // Dark gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.8),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Title & Subtitle
                Text(
                  gameTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                if (gameSubtitle.isNotEmpty)
                  Text(
                    gameSubtitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),

                const SizedBox(height: 16),

                // Rating and Badge
                Row(
                  children: [
                    // Stars
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < rating.floor()
                              ? Icons.star
                              : index < rating
                                  ? Icons.star_half
                                  : Icons.star_outline,
                          color: Colors.amber,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Rating text
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    if (badgeText != null) ...[
                      const SizedBox(width: 16),
                      // Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: theme.get('primary'),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          badgeText!,
                          style: TextStyle(
                            color: theme.get('textOnPrimary'),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 16),

                // Stats Section - Horizontal row
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Active Players
                    _buildStatItem(
                      context: context,
                      icon: Icons.people,
                      value: _formatNumber(playerCount),
                      label: 'Active Players',
                      theme: theme,
                    ),
                    const SizedBox(width: 32),

                    // Genre
                    _buildStatItem(
                      context: context,
                      icon: Icons.gamepad,
                      value: gameGenre,
                      label: 'Genre',
                      theme: theme,
                    ),
                    const SizedBox(width: 32),

                    // Release Date
                    _buildStatItem(
                      context: context,
                      icon: Icons.calendar_today,
                      value: releaseDate,
                      label: 'Release Date',
                      theme: theme,
                    ),
                    const SizedBox(width: 32),

                    // Platforms
                    _buildStatItem(
                      context: context,
                      icon: Icons.devices,
                      value: platforms.join(', '),
                      label: 'Platforms',
                      theme: theme,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Play button
          // if (onPlayTap != null)
          //   Positioned(
          //     top: 24,
          //     right: 24,
          //     child: ElevatedButton.icon(
          //       onPressed: onPlayTap,
          //       icon: Icon(Icons.play_arrow),
          //       label: Text('Play Now'),
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: theme.get('primary'),
          //         foregroundColor: theme.get('textOnPrimary'),
          //         padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required BuildContext context,
    required IconData icon,
    required String value,
    required String label,
    required dynamic theme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Colors.white70,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}
