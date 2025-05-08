import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/widgets/cards/clip_card/game_clip_overlay.dart';
import 'package:phynd_app/presentation/widgets/image_video.dart';

class GameClipCard extends StatelessWidget {
  final String imageUrl;
  final String videoUrl;
  final String gameName;
  final Widget? badge;
  final Widget? overlayInfo;
  final String? esrbImageUrl;

  const GameClipCard({
    super.key,
    required this.imageUrl,
    required this.videoUrl,
    required this.gameName,
    this.badge,
    this.overlayInfo,
    this.esrbImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ImageVideo(
          imageUrl: imageUrl,
          videoUrl: videoUrl,
        ),
        GameClipOverlay(
          gameName: gameName,
          badge: badge,
          overlayInfo: overlayInfo,
          esrbImageUrl: esrbImageUrl,
        ),
      ],
    );
  }
}
