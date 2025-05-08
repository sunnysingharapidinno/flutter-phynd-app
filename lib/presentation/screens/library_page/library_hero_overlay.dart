import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phynd_app/core/helpers/responsive_helper.dart';
import 'package:phynd_app/presentation/widgets/buttons/button.dart';
import 'package:phynd_app/presentation/widgets/esrb_badge/esrb_badge.dart';
import 'package:phynd_app/presentation/widgets/verify_badge/verify_badge.dart';

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

  double _getResponsiveSpacing(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ResponsiveHelper.getResponsiveSize(
        screenWidth, 12.0, [24.0, 20.0, 16.0, 12.0]);
  }

  double _getResponsiveIconSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ResponsiveHelper.getResponsiveSize(
        screenWidth, 10.0, [20.0, 16.0, 12.0, 10.0]);
  }

  TextStyle _getGameTitleStyle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GoogleFonts.rubik(
      fontSize:
          ResponsiveHelper.getResponsiveSize(screenWidth, 24, [72, 64, 58, 24]),
      fontWeight: FontWeight.w600,
      color: Colors.white,
      height: 1.2,
    );
  }

  @override
  Widget build(BuildContext context) {
    final spacing = _getResponsiveSpacing(context);
    final iconSize = _getResponsiveIconSize(context);
    final friendsIconSize = ResponsiveHelper.getResponsiveSize(
      MediaQuery.of(context).size.width,
      20.0,
      [64.0, 54.0, 46.0, 20.0],
    );

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
              padding: EdgeInsets.all(spacing * 1.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1634309490604-1270c0d486e8?q=80&w=3132&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    height: ResponsiveHelper.getResponsiveRatio(
                      MediaQuery.of(context).size.width,
                      250.0,
                      [460.0, 400.0, 320.0, 250.0],
                    ),
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
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.white54,
                          size: iconSize * 4,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: spacing * 1.5),
                  // Info Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '2024',
                        style: _getGameTitleStyle(context),
                      ),
                      SizedBox(width: spacing),
                      Icon(
                        Icons.circle,
                        color: Colors.white,
                        size: iconSize,
                      ),
                      SizedBox(width: spacing),
                      Text(
                        'Top Secret Games',
                        style: _getGameTitleStyle(context),
                      ),
                      SizedBox(width: spacing),
                      VerifiedBadge(size: iconSize * 1.6),
                      SizedBox(width: spacing),
                      Icon(
                        Icons.circle,
                        color: Colors.white,
                        size: iconSize,
                      ),
                      SizedBox(width: spacing),
                      ESRBBadge(
                        imageUrl:
                            'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/everyone.png',
                      ),
                    ],
                  ),
                  SizedBox(height: spacing * 1.5),
                  // Friends Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Friends icon
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          color: Colors.grey[800],
                        ),
                        padding: EdgeInsets.all(spacing * 0.5),
                        child: Icon(
                          Icons.groups,
                          color: Colors.white,
                          size: friendsIconSize,
                        ),
                      ),
                      SizedBox(width: spacing * 0.75),
                      Text(
                        '86 Friends Play',
                        style: GoogleFonts.exo2(
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: ResponsiveHelper.getResponsiveSize(
                                  MediaQuery.of(context).size.width,
                                  Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.fontSize ??
                                      16.0,
                                  [42.0, 38.0, 34.0, 20.0],
                                ),
                              ),
                        ),
                      ),
                      SizedBox(width: spacing * 1.5),
                      // Green dot
                      Container(
                        width: iconSize,
                        height: iconSize,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2ECC40),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spacing * 0.75),
                      Text(
                        '12 Currently Playing',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white.withOpacity(0.85),
                              fontWeight: FontWeight.w600,
                              fontSize: ResponsiveHelper.getResponsiveSize(
                                MediaQuery.of(context).size.width,
                                Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.fontSize ??
                                    16.0,
                                [32.0, 28.0, 24.0, 16.0],
                              ),
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: spacing * 5), // Space for buttons
                ],
              ),
            ),
          ),
        ),
        // Interactive buttons
        Positioned(
          left: spacing * 1.5,
          right: spacing * 1.5,
          bottom: spacing * 1.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Button(
                text: 'Play',
                variant: ButtonVariant.secondary,
                icon: Icons.play_arrow,
                onPressed: onPlayPressed,
              ),
              SizedBox(width: spacing),
              Button(
                text: 'More info',
                variant: ButtonVariant.transparent,
                icon: Icons.info,
                onPressed: onLearnMorePressed,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
