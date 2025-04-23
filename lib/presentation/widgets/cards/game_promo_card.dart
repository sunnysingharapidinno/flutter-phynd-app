import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

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
  final FocusNode _focusNode = FocusNode();
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {}); // Rebuild on focus change
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(_focusNode);
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        child: Focus(
          focusNode: _focusNode,
          child: Container(
            width: widget.width,
            height: widget.height,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              border: Border.all(
                color: _focusNode.hasFocus || _isHovered
                    ? theme.get('primary').withOpacity(0.5)
                    : Colors.transparent,
                width: 2,
              ),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
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
                          style: TextStyle(
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
        ),
      ),
    );
  }
}
