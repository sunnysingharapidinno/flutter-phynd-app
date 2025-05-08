import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ImageVideo extends StatefulWidget {
  final String imageUrl;
  final String videoUrl;
  final double aspectRatio;
  final BorderRadius? borderRadius;

  const ImageVideo({
    super.key,
    required this.imageUrl,
    required this.videoUrl,
    this.aspectRatio = 16 / 9,
    this.borderRadius,
  });

  @override
  State<ImageVideo> createState() => _ImageVideoState();
}

class _ImageVideoState extends State<ImageVideo> {
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
        if (mounted) {
          setState(() {
            _initialized = true;
          });
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool hover) {
    if (mounted) {
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
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        _onHover(true);
      },
      onExit: (_) {
        _onHover(false);
      },
      child: AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (_isHovered && _initialized)
                  VideoPlayer(_controller)
                else
                  Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[800],
                        child: const Center(
                          child: Icon(
                            Icons.error_outline,
                            color: Colors.white54,
                            size: 32,
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
