import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/buttons/button.dart';
import 'package:phynd_app/presentation/widgets/verify_badge/verify_badge.dart';
import 'package:phynd_app/presentation/widgets/esrb_badge/esrb_badge.dart';

class LibraryHeroOverlay extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onPlayPressed;
  final VoidCallback? onLearnMorePressed;
  final Color gradientStartColor;
  final Color gradientEndColor;
  final double gradientStartOpacity;
  final double gradientEndOpacity;

  const LibraryHeroOverlay({
    super.key,
    required this.title,
    required this.description,
    this.onPlayPressed,
    this.onLearnMorePressed,
    this.gradientStartColor = Colors.black,
    this.gradientEndColor = Colors.transparent,
    this.gradientStartOpacity = 0.7,
    this.gradientEndOpacity = 0.0,
  });

  TextStyle _getGameTitleStyle(BuildContext context) {
    return GoogleFonts.rubik(
      fontSize: FontUtils.pxToSp(context, 32),
      fontWeight: FontWeight.w600,
      color: Colors.white,
      height: 1.2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Non-interactive content
        IgnorePointer(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  gradientStartColor.withOpacity(gradientStartOpacity),
                  gradientEndColor.withOpacity(gradientEndOpacity),
                  gradientEndColor.withOpacity(gradientEndOpacity),
                  gradientStartColor.withOpacity(gradientStartOpacity),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1634309490604-1270c0d486e8?q=80&w=3132&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    height: SizeUtils.pxToDp(context,
                        MediaQuery.of(context).size.width >= 2200 ? 320 : 200),
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        height: 120,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => SizedBox(
                      height: 120,
                      child: Center(
                        child: Icon(Icons.broken_image,
                            color: Colors.white54, size: 48),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  // Info Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '2024',
                        style: _getGameTitleStyle(context),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.circle,
                        color: Colors.white,
                        size: 10,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Top Secret Games',
                        style: _getGameTitleStyle(context),
                      ),
                      const SizedBox(width: 12),
                      const VerifiedBadge(),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.circle,
                        color: Colors.white,
                        size: 10,
                      ),
                      const SizedBox(width: 12),
                      const ESRBBadge(
                          imageUrl:
                              'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/everyone.png'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Friends Row
                  Row(
                    children: [
                      // Friends icon
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white24, width: 2),
                          color: Colors.grey[800],
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(Icons.groups,
                            color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '86 Friends Play',
                        style: GoogleFonts.exo2(
                          textStyle:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Green dot
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2ECC40),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '12 Currently Playing',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white.withOpacity(0.85),
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60), // Space for buttons
                ],
              ),
            ),
          ),
        ),
        // Interactive buttons
        Positioned(
          left: 16,
          right: 16,
          bottom: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Button(
                text: 'Play',
                variant: ButtonVariant.secondary,
                icon: Icons.play_arrow,
                onPressed: onPlayPressed,
                width: SizeUtils.pxToDp(context, 200),
              ),
              const SizedBox(width: 12),
              Button(
                text: 'More info',
                variant: ButtonVariant.transparent,
                icon: Icons.info,
                onPressed: onLearnMorePressed,
                width: SizeUtils.pxToDp(context, 320),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
