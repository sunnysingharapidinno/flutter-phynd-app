import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/theme/app_colors.dart';

class FreePlayCard extends StatelessWidget {
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
  final double height;

  const FreePlayCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    this.rating = 0,
    this.isFree = true,
    this.isExclusive = false,
    this.isMultiplayer = false,
    this.isSinglePlayer = false,
    this.esrbRating,
    this.onTap,
    this.width = 350,
    this.height = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: theme.get('cardBg'),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
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

            // Exclusive badge
            if (isExclusive)
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.freePlayBadgeBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'PHYND Exclusive',
                    style: TextStyle(
                      color: theme.get('textOnPrimary'),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            // Bottom Info Panel
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.freePlayGradientStart,
                      AppColors.freePlayGradientEnd,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Rating stars
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < rating
                              ? Icons.star
                              : index < rating + 0.5
                                  ? Icons.star_half
                                  : Icons.star_outline,
                          color: AppColors.freePlayStarColor,
                          size: 20,
                        );
                      }),
                    ),

                    const SizedBox(height: 8),

                    // Game Title
                    Text(
                      title,
                      style: TextStyle(
                        color: theme.get('textOnPrimary'),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 12),

                    // Game Tags Row
                    Row(
                      children: [
                        // Free Tag
                        if (isFree)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.freePlayFreeTagBg,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'FREE',
                              style: TextStyle(
                                color: theme.get('textOnPrimary'),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                        const SizedBox(width: 12),

                        // Multiplayer Icon and Text
                        if (isMultiplayer) ...[
                          Icon(
                            Icons.people,
                            size: 16,
                            color: theme.get('textOnPrimary'),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Multiplayer',
                            style: TextStyle(
                              color: theme.get('textOnPrimary'),
                              fontSize: 14,
                            ),
                          ),
                        ],

                        if (isMultiplayer && isSinglePlayer)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '|',
                              style: TextStyle(
                                color: theme
                                    .get('textOnPrimary')
                                    ?.withOpacity(0.6),
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),

                        // Single Player Icon and Text
                        if (isSinglePlayer) ...[
                          Icon(
                            Icons.person,
                            size: 16,
                            color: theme.get('textOnPrimary'),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Single Player',
                            style: TextStyle(
                              color: theme.get('textOnPrimary'),
                              fontSize: 14,
                            ),
                          ),
                        ],

                        const Spacer(),

                        // ESRB Rating
                        if (esrbRating != null)
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.gameCardEsrbBg,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: AppColors.gameCardEsrbBorder,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              esrbRating!,
                              style: const TextStyle(
                                color: AppColors.gameCardEsrbText,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
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
    );
  }
}
