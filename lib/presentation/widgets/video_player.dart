import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool isAds;
  final String? sponsorName;
  final String? sponsorLogoUrl;
  final VoidCallback? onVideoComplete;

  const CustomVideoPlayer({
    super.key,
    required this.videoUrl,
    this.isAds = false,
    this.sponsorName,
    this.sponsorLogoUrl,
    this.onVideoComplete,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late final VideoPlayerController _controller;
  bool _isInitialized = false;
  String? _errorMessage;
  int _remainingAdTime = 0;
  Timer? _adTimer;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _startAdTimer() {
    // Get total duration in seconds
    final totalDuration = _controller.value.duration.inSeconds;
    _remainingAdTime = totalDuration;

    _adTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingAdTime > 0) {
        setState(() {
          _remainingAdTime--;
        });
      } else {
        _adTimer?.cancel();
        widget.onVideoComplete?.call();
      }
    });
  }

  void _videoListener() {
    // Check if video has reached the end (with a small buffer to account for rounding errors)
    if (_controller.value.position >=
        _controller.value.duration - const Duration(milliseconds: 300)) {
      if (!widget.isAds) {
        widget.onVideoComplete?.call();
      }
    }
  }

  Future<void> _initializePlayer() async {
    try {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );

      _controller.addListener(_videoListener);
      await _controller.initialize();

      if (!widget.isAds) {
        _controller.setLooping(false);
      }

      await _controller.play();

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });

        if (widget.isAds) {
          _startAdTimer();
        }
      }
    } catch (e) {
      debugPrint('Error initializing video player: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to load video: ${e.toString()}';
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    _adTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(_errorMessage!),
          ],
        ),
      );
    }

    if (!_isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Material(
      color: Colors.black,
      child: Center(
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              VideoPlayer(_controller),
              if (!widget.isAds) ...[
                _ControlsOverlay(controller: _controller),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                    colors: const VideoProgressColors(
                      playedColor: Colors.white,
                      bufferedColor: Colors.white24,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ),
              ] else ...[
                // Ad UI overlay
                _AdOverlay(
                  controller: _controller,
                  remainingTime: _remainingAdTime,
                  sponsorName: widget.sponsorName ?? 'Sponsored',
                  sponsorLogoUrl: widget.sponsorLogoUrl,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _AdOverlay extends StatelessWidget {
  final VideoPlayerController controller;
  final int remainingTime;
  final String sponsorName;
  final String? sponsorLogoUrl;

  const _AdOverlay({
    required this.controller,
    required this.remainingTime,
    required this.sponsorName,
    this.sponsorLogoUrl,
  });

  @override
  Widget build(BuildContext context) {
    final totalDuration = controller.value.duration.inSeconds;

    return Stack(
      children: [
        // Bottom progress bar
        Positioned(
          bottom: 10,
          left: 20,
          right: 20,
          child: VideoProgressIndicator(
            controller,
            allowScrubbing: false,
            colors: const VideoProgressColors(
              playedColor: Colors.white,
              bufferedColor: Colors.white24,
              backgroundColor: Colors.grey,
            ),
          ),
        ),

        // Sponsor info at bottom left
        Positioned(
          bottom: 36,
          left: 16,
          child: Row(
            children: [
              // Sponsor logo
              if (sponsorLogoUrl != null)
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(sponsorLogoUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              else
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.business,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              const SizedBox(width: 8),
              // Sponsor info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Sponsored',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        sponsorName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.verified,
                        color: Colors.blue,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        // Timer at bottom right with circular progress
        Positioned(
          bottom: 36,
          right: 16,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.6),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Circular progress indicator
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    value: remainingTime / totalDuration,
                    strokeWidth: 3,
                    backgroundColor: Colors.grey.withOpacity(0.3),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                // Timer text
                Text(
                  '$remainingTime',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({required this.controller});

  static const List<Duration> _exampleCaptionOffsets = <Duration>[
    Duration(seconds: -10),
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration.zero,
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
    Duration(seconds: 10),
  ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : const ColoredBox(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.topLeft,
          child: PopupMenuButton<Duration>(
            initialValue: controller.value.captionOffset,
            tooltip: 'Caption Offset',
            onSelected: (Duration delay) {
              controller.setCaptionOffset(delay);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<Duration>>[
                for (final Duration offsetDuration in _exampleCaptionOffsets)
                  PopupMenuItem<Duration>(
                    value: offsetDuration,
                    child: Text('${offsetDuration.inMilliseconds}ms'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.captionOffset.inMilliseconds}ms'),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (double speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<double>>[
                for (final double speed in _examplePlaybackRates)
                  PopupMenuItem<double>(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}

class _PlayerVideoAndPopPage extends StatefulWidget {
  @override
  _PlayerVideoAndPopPageState createState() => _PlayerVideoAndPopPageState();
}

class _PlayerVideoAndPopPageState extends State<_PlayerVideoAndPopPage> {
  late VideoPlayerController _videoPlayerController;
  bool startedPlaying = false;

  @override
  void initState() {
    super.initState();

    _videoPlayerController =
        VideoPlayerController.asset('assets/Butterfly-209.mp4');
    _videoPlayerController.addListener(() {
      if (startedPlaying && !_videoPlayerController.value.isPlaying) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<bool> started() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.play();
    startedPlaying = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: FutureBuilder<bool>(
          future: started(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data ?? false) {
              return AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              );
            } else {
              return const Text('waiting for video to load');
            }
          },
        ),
      ),
    );
  }
}
