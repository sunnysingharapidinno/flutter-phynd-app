import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phynd_app/presentation/widgets/esrb_badge/esrb_badge.dart';

class GameClipOverlay extends StatelessWidget {
  final String gameName;
  final Widget? badge;
  final Widget? overlayInfo;
  final String? esrbImageUrl;
  final Color gradientStartColor;
  final Color gradientEndColor;
  final double gradientStartOpacity;
  final double gradientEndOpacity;

  const GameClipOverlay({
    super.key,
    required this.gameName,
    this.badge,
    this.overlayInfo,
    this.esrbImageUrl,
    this.gradientStartColor = Colors.black,
    this.gradientEndColor = Colors.transparent,
    this.gradientStartOpacity = 0.7,
    this.gradientEndOpacity = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  gradientStartColor.withOpacity(gradientStartOpacity),
                  gradientEndColor.withOpacity(gradientEndOpacity),
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
                if (badge != null) ...[
                  badge!,
                  const SizedBox(height: 8),
                ],
                LayoutBuilder(
                  builder: (context, constraints) {
                    double screenWidth = MediaQuery.of(context).size.width;
                    double fontSize = 20.0;
                    if (screenWidth >= 1200) fontSize = 24.0;
                    if (screenWidth >= 2560) fontSize = 32.0;
                    if (screenWidth >= 3200) fontSize = 36.0;
                    if (screenWidth >= 3840) fontSize = 38.0;
                    return Text(
                      gameName,
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
          // Bottom right: Network image
          if (esrbImageUrl != null)
            Positioned(
              right: 16,
              bottom: 16,
              child: ESRBBadge(
                imageUrl: esrbImageUrl,
              ),
            ),
        ],
      ),
    );
  }
}
