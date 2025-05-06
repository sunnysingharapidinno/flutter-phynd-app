import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class GameClipCard extends StatefulWidget {
  final String imageUrl;
  final String videoUrl;
  final String gameName;
  final Widget? badge;
  final Widget? overlayInfo;

  const GameClipCard({
    super.key,
    required this.imageUrl,
    required this.videoUrl,
    required this.gameName,
    this.badge,
    this.overlayInfo,
  });

  @override
  State<GameClipCard> createState() => _GameClipCardState();
}

class _GameClipCardState extends State<GameClipCard> {
  bool _isHovered = false;
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..setVolume(0.0)
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {
          _initialized = true;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool hover) {
    setState(() {
      _isHovered = hover;
      if (_initialized) {
        if (hover) {
          _controller.play();
        } else {
          _controller.pause();
          _controller.seekTo(Duration.zero);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Show video if hovered and initialized, else image
                if (_isHovered && _initialized)
                  VideoPlayer(_controller)
                else
                  Image.network(widget.imageUrl, fit: BoxFit.cover),
                // Overlay gradient for readability
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                // Bottom left: rating and game name
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.badge != null) ...[
                        widget.badge!,
                        const SizedBox(height: 8),
                      ],
                      LayoutBuilder(
                        builder: (context, constraints) {
                          double screenWidth =
                              MediaQuery.of(context).size.width;
                          double fontSize = 20.0;
                          if (screenWidth >= 1200) fontSize = 24.0;
                          if (screenWidth >= 2560) fontSize = 32.0;
                          if (screenWidth >= 3200) fontSize = 36.0;
                          if (screenWidth >= 3840) fontSize = 38.0;
                          return Text(
                            widget.gameName,
                            style: GoogleFonts.exo2(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                                shadows: const [
                                  Shadow(
                                    color: Colors.black54,
                                    blurRadius: 4,
                                    offset: Offset(1, 2),
                                  ),
                                ],
                              ),
                            ),
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // Bottom right: overlayInfo (ESRB rating)
                if (widget.overlayInfo != null)
                  Positioned(right: 16, bottom: 16, child: widget.overlayInfo!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
