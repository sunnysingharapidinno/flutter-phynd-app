import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/hero_game_badge.dart';

class AppIdle extends StatefulWidget {
  const AppIdle({super.key});

  @override
  State<AppIdle> createState() => _AppIdleState();
}

class _AppIdleState extends State<AppIdle> {
  bool _showBackground = false;
  bool _showContent = false;
  bool _imageLoaded = false;
  final ImageProvider _backgroundImage = const NetworkImage(
    'https://xstrela-alpha.s3.us-east-1.amazonaws.com/general/2025/03/16/3bc8bc2f85184505aec7858df30ac041.png',
  );

  @override
  void initState() {
    super.initState();
    // Preload the image
    _backgroundImage.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((info, synchronousCall) {
        if (mounted) {
          setState(() => _imageLoaded = true);
          // Start background fade in after image is loaded
          Future.microtask(() => setState(() => _showBackground = true));
          // Start content fade in after image is loaded + 2 seconds
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
        // Background with fade in
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
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.3),
                ],
              ),
            ),
          ),
        ),
        // Content with delayed fade in
        Positioned(
          bottom: SizeUtils.pxToDp(context, 100),
          left: SizeUtils.pxToDp(context, 100),
          child: AnimatedOpacity(
            opacity: _showContent && _imageLoaded ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
            child: const HeroGameBadge(
              showActionBtns: false,
              onPlayPressed: null,
              onLearnMorePressed: null,
            ),
          ),
        ),
      ],
    );
  }
}
