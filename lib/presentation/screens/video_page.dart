import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/layouts/base_layout.dart';
import 'package:phynd_app/presentation/widgets/video_player.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final List<Map<String, dynamic>> _videos = [
    {
      'url':
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      'isAd': true,

      'sponsorName': 'Warner Brothers',
      // 'sponsorLogoUrl': 'https://example.com/warner.png',
    },
    {
      'url':
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4',
      'isAd': true,
      'sponsorName': 'Warner Brothers',
    },
    {
      'url':
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      'isAd': true,

      'sponsorName': 'Disney',
      // 'sponsorLogoUrl': 'https://example.com/disney.png',
    },
    {
      'url':
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
      'isAd': true,
      'sponsorName': 'Disney',
    },
  ];

  int _currentVideoIndex = 0;
  bool _allVideosCompleted = false;

  void _onVideoComplete() {
    if (_currentVideoIndex < _videos.length - 1) {
      setState(() {
        _currentVideoIndex++;
      });
    } else {
      setState(() {
        _allVideosCompleted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_allVideosCompleted) {
      return BaseLayout(
        title: 'Video Player',
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 80,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 24),
              const Text(
                'All videos completed',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 16),
              // ElevatedButton(
              //   onPressed: () {
              //     setState(() {
              //       _currentVideoIndex = 0;
              //       _allVideosCompleted = false;
              //     });
              //   },
              //   child: const Text('Watch Again'),
              // ),
            ],
          ),
        ),
      );
    }

    final currentVideo = _videos[_currentVideoIndex];

    return BaseLayout(
      title: 'Video Player',
      child: Column(
        children: [
          Expanded(
            child: CustomVideoPlayer(
              key: ValueKey(
                  _currentVideoIndex), // Force rebuild when index changes
              videoUrl: currentVideo['url'],
              isAds: currentVideo['isAd'] ?? false,
              sponsorName: currentVideo['sponsorName'],
              sponsorLogoUrl: currentVideo['sponsorLogoUrl'],
              onVideoComplete: _onVideoComplete,
            ),
          ),
        ],
      ),
    );
  }
}
