import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

class GameplayClipCard extends StatefulWidget {
  final String imageUrl;
  final String timeSincePosted;
  final String duration;
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final VoidCallback? onTap;

  const GameplayClipCard({
    Key? key,
    required this.imageUrl,
    required this.timeSincePosted,
    required this.duration,
    this.width = 280,
    this.height = 160,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.onTap,
  }) : super(key: key);

  @override
  State<GameplayClipCard> createState() => _GameplayClipCardState();
}

class _GameplayClipCardState extends State<GameplayClipCard> {
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
                    ? Theme.of(context)
                        .extension<AppTheme>()!
                        .get('primary')
                        .withOpacity(0.5)
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
                      color: Theme.of(context)
                          .extension<AppTheme>()!
                          .get('cardBg'),
                      child: Center(
                        child: Icon(
                          Icons.videogame_asset_off,
                          color: Theme.of(context)
                              .extension<AppTheme>()!
                              .get('text'),
                        ),
                      ),
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Theme.of(context)
                            .extension<AppTheme>()!
                            .get('cardBg'),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context)
                                .extension<AppTheme>()!
                                .get('primary'),
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                  ),

                  // Dark gradient overlay for better text readability
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context)
                              .extension<AppTheme>()!
                              .get('darkBlueOverlay')
                              .withOpacity(0.6),
                          Theme.of(context)
                              .extension<AppTheme>()!
                              .get('darkBlueOverlay')
                              .withOpacity(0.0),
                        ],
                        stops: const [
                          0.1016,
                          0.276
                        ], // 10.16% to 27.6% as specified
                      ),
                    ),
                  ),

                  // Bottom gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context)
                              .extension<AppTheme>()!
                              .get('darkBlueOverlay')
                              .withOpacity(0.0),
                          Theme.of(context)
                              .extension<AppTheme>()!
                              .get('darkBlueOverlay')
                              .withOpacity(0.9),
                        ],
                        stops: const [0.7, 1.0], // Bottom portion of the card
                      ),
                    ),
                  ),

                  // Play button overlay (shows on hover/focus)
                  if (_isHovered || _focusNode.hasFocus)
                    Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .extension<AppTheme>()!
                              .get('primary'),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.play_arrow,
                          color: Theme.of(context)
                              .extension<AppTheme>()!
                              .get('textOnPrimary'),
                          size: 30,
                        ),
                      ),
                    ),

                  // Content overlay (time indicators)
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Time since posted - top left
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          constraints: BoxConstraints(
                            maxWidth: 100,
                          ),
                          child: Text(
                            widget.timeSincePosted,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        Spacer(),

                        // Duration - bottom right
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              widget.duration,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
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
