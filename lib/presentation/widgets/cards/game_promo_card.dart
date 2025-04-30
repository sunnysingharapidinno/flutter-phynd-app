import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';

class GamePromoCard extends StatefulWidget {
  final String imageUrl;
  final String gameTitle;
  final String? badgeText;
  final double rating;
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final VoidCallback? onTap;

  const GamePromoCard({
    Key? key,
    required this.imageUrl,
    required this.gameTitle,
    this.badgeText,
    this.rating = 5.0,
    this.width = 280,
    this.height = 160,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.onTap,
  }) : super(key: key);

  @override
  State<GamePromoCard> createState() => _GamePromoCardState();
}

class _GamePromoCardState extends State<GamePromoCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;

    return RemoteControlWrapper(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
        ),
        child: ClipRRect(
          borderRadius: widget.borderRadius,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: theme.get('cardBg'),
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: theme.get('text'),
                    ),
                  ),
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: theme.get('cardBg'),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: theme.get('primary'),
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
              ),

              // Dark gradient overlay at the bottom for readable text
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 60,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
              ),

              // Free Trial badge
              if (widget.badgeText != null)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: theme.get('cardBg').withOpacity(0.8),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: theme.get('primary').withOpacity(0.5),
                      ),
                    ),
                    child: Text(
                      widget.badgeText!,
                      style: TextStyle(
                        color: theme.get('text'),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              // Rating stars and game title
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Star rating
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < widget.rating.floor()
                              ? Icons.star
                              : index < widget.rating
                                  ? Icons.star_half
                                  : Icons.star_outline,
                          color: Colors.amber,
                          size: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Game title
                    Text(
                      widget.gameTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
