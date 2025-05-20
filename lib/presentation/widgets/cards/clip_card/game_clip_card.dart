import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/esrb_badge/esrb_badge.dart'; // Assuming you have this
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';
import 'package:phynd_app/presentation/widgets/ratings/ratings.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';

class GameClipCard extends StatelessWidget {
  final String? thumbnailUrl;
  final String? videoUrl;
  final String? title;
  final double rating; // e.g., 4.5 for 4.5 stars
  final int maxRating;
  final String? esrbRatingImageUrl; // URL for the ESRB image
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final bool? hideRating;

  const GameClipCard({
    super.key,
    this.thumbnailUrl,
    this.videoUrl,
    this.title,
    this.rating = 0.0,
    this.maxRating = 5,
    this.esrbRatingImageUrl,
    this.onTap,
    this.width,
    this.height,
    this.hideRating = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text');
    final cardColor = theme?.get('cardBg');

    final double cardWidth = SizeUtils.pxToDp(context, width ?? 368);
    final double cardHeight = SizeUtils.pxToDp(context, height ?? 207);

    return RemoteControlWrapper(
      onTap: onTap,
      child: SizedBox(
        width: cardWidth,
        height: cardHeight,
        child: Card(
          color: cardColor,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeUtils.pxToDp(context, 6)),
          ),
          child: Stack(
            children: [
              ImageThumbnail(
                imageUrl: thumbnailUrl,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(13, 19, 44, 0.00),
                        Color.fromRGBO(13, 19, 44, 0.90),
                      ],
                      stops: [0.267, 0.9971], // 26.7% and 99.71%
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: SizeUtils.pxToDp(context, 12),
                left: SizeUtils.pxToDp(context, 12),
                right: SizeUtils.pxToDp(context, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (hideRating == false)
                          Ratings(rating: rating, maxRating: maxRating),
                        SizedBox(height: SizeUtils.pxToDp(context, 8)),
                        Text(
                          title ?? '',
                          style: TextStyle(
                            color: textColor,
                            fontSize: FontUtils.pxToSp(context, 28),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Exo2',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                    if (esrbRatingImageUrl != null &&
                        esrbRatingImageUrl!.isNotEmpty)
                      ESRBBadge(
                        imageUrl: esrbRatingImageUrl!,
                        height: SizeUtils.pxToDp(context, 66),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
