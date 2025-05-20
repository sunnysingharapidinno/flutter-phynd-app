import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/app_images.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';
import 'package:phynd_app/presentation/widgets/verify_badge/verify_badge.dart';

class PublisherHeader extends StatefulWidget {
  final List<String> backgroundImages;
  final String? publisherCircularLogoUrl;
  final String? publisherNameArtUrl;
  final String followersCount;
  final String gamesCount;
  final String upcomingEventsCount;
  final bool? isVerified;

  const PublisherHeader({
    super.key,
    required this.backgroundImages,
    this.publisherCircularLogoUrl,
    this.publisherNameArtUrl,
    required this.followersCount,
    required this.gamesCount,
    required this.upcomingEventsCount,
    this.isVerified = false,
  });

  @override
  State<PublisherHeader> createState() => _PublisherHeaderState();
}

class _PublisherHeaderState extends State<PublisherHeader> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page?.round() != _currentPage) {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final bgColor = theme?.get('bgColor');
    final dotActiveColor = theme?.get('primary');
    final dotInactiveColor = Colors.grey[600] ?? Colors.grey;

    return SizedBox(
      height: SizeUtils.pxToDp(context, 565),
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.backgroundImages.length,
            itemBuilder: (context, index) {
              return ImageThumbnail(
                imageUrl: widget.backgroundImages[index],
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              );
            },
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Color.fromRGBO(27, 29, 38, 0.00),
                    Color.fromRGBO(27, 29, 38, 0.80),
                    Color.fromRGBO(27, 29, 38, 0.90),
                  ],
                  stops: [0.31, 0.55, 0.80],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(27, 29, 38, 0.00),
                    bgColor!,
                  ],
                  stops: [0.5532, 0.9836],
                ),
              ),
            ),
          ),
          if (widget.backgroundImages.length > 1)
            Positioned(
              top: SizeUtils.pxToDp(context, 20),
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(widget.backgroundImages.length,
                    (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeUtils.pxToDp(context, 4)),
                    height: SizeUtils.pxToDp(context, 8),
                    width: _currentPage == index
                        ? SizeUtils.pxToDp(context, 24)
                        : SizeUtils.pxToDp(context, 8),
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? dotActiveColor
                          : dotInactiveColor,
                      borderRadius:
                          BorderRadius.circular(SizeUtils.pxToDp(context, 4)),
                    ),
                  );
                }),
              ),
            ),
          Positioned(
            bottom: SizeUtils.pxToDp(context, 64),
            left: SizeUtils.pxToDp(context, 56),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageThumbnail(
                      imageUrl: widget.publisherCircularLogoUrl ??
                          AppImages.profileAvatar,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                      borderRadius: 200,
                      isNetwork: widget.publisherCircularLogoUrl != null,
                    ),
                    SizedBox(width: SizeUtils.pxToDp(context, 8)),
                    if (widget.isVerified == true)
                      VerifiedBadge(
                        size: SizeUtils.pxToDp(context, 42),
                      ),
                    SizedBox(width: SizeUtils.pxToDp(context, 24)),
                    ImageThumbnail(
                      imageUrl: widget.publisherNameArtUrl,
                      height: 207,
                      width: 383,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                SizedBox(height: SizeUtils.pxToDp(context, 40)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildStatItem(
                      context,
                      widget.followersCount,
                      'Followers',
                    ),
                    _buildDivider(context),
                    _buildStatItem(
                      context,
                      widget.gamesCount,
                      'Games',
                    ),
                    _buildDivider(context),
                    _buildStatItem(
                      context,
                      widget.upcomingEventsCount,
                      'Upcoming Events',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String value,
    String label,
  ) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text');
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeUtils.pxToDp(context, 12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: FontUtils.pxToSp(context, 22),
              fontWeight: FontWeight.w600,
              fontFamily: 'Exo2',
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: FontUtils.pxToSp(context, 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(
    BuildContext context,
  ) {
    final theme = Theme.of(context).extension<AppTheme>();
    final dividerColor = theme?.get('primary');
    return Container(
      height: SizeUtils.pxToDp(context, 48),
      width: 1,
      color: dividerColor,
      margin: EdgeInsets.symmetric(horizontal: SizeUtils.pxToDp(context, 24)),
    );
  }
}
