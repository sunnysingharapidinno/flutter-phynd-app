import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phynd_app/presentation/widgets/esrb_badge/esrb_badge.dart';
import 'package:phynd_app/core/helpers/responsive_helper.dart';

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
                    final screenWidth = MediaQuery.of(context).size.width;
                    double fontSize = 20.0;
                    final sizes = [64.0, 58.0, 32.0, 24.0];
                    fontSize = ResponsiveHelper.getResponsiveSize(
                        screenWidth, fontSize, sizes);
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
