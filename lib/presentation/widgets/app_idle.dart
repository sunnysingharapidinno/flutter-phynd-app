import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/hero_game_badge.dart';

class AppIdle extends StatefulWidget {
  final String backgroundImg;
  final String gameTextImg;
  final String releaseYear;
  final String publisherName;
  final String esrb;
  final int friendsCount;
  final int onlineCount;

  const AppIdle({
    super.key,
    required this.backgroundImg,
    required this.gameTextImg,
    required this.releaseYear,
    required this.publisherName,
    required this.esrb,
    required this.friendsCount,
    required this.onlineCount,
  });

  @override
  State<AppIdle> createState() => _AppIdleState();
}

class _AppIdleState extends State<AppIdle> {
  bool _showBackground = false;
  bool _showContent = false;
  bool _imageLoaded = false;

  late final ImageProvider _backgroundImage;

  @override
  void initState() {
    super.initState();
    _backgroundImage = NetworkImage(widget.backgroundImg);

    // Preload the background image
    _backgroundImage.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((info, synchronousCall) {
        if (mounted) {
          setState(() {
            _imageLoaded = true;
            _showBackground = true;
          });

          // Fade in content after a delay
          Future.delayed(const Duration(milliseconds: 2000), () {
            if (mounted) {
              setState(() => _showContent = true);
            }
          });
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image
        AnimatedOpacity(
          opacity: _showBackground && _imageLoaded ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: _backgroundImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        // Gradient overlay
        AnimatedOpacity(
          opacity: _showBackground && _imageLoaded ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.5, 1.0193],
                colors: [
                  const Color.fromRGBO(27, 29, 38, 0.0), // transparent
                  const Color(0xFF1B1D26), // #1B1D26
                ],
              ),
            ),
          ),
        ),

        // Content
        Positioned(
          bottom: SizeUtils.pxToDp(context, 100),
          left: SizeUtils.pxToDp(context, 100),
          child: AnimatedOpacity(
            opacity: _showContent && _imageLoaded ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
            child: HeroGameBadge(
              showActionBtns: false,
              onPlayPressed: null,
              onLearnMorePressed: null,
              // Optional: pass props like gameTextImg, publisherName, etc. if HeroGameBadge supports them
            ),
          ),
        ),
      ],
    );
  }
}
