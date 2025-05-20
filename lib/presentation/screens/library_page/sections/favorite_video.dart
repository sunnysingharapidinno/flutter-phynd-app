import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/ui_constants.dart';
import 'package:phynd_app/core/enums/media_type.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/cards/video_cards.dart';
import 'package:phynd_app/presentation/widgets/carousel/carousel_row.dart';

class FavoriteVideoSection extends StatefulWidget {
  const FavoriteVideoSection({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteVideoSection> createState() => _FavoriteVideoState();
}

class _FavoriteVideoState extends State<FavoriteVideoSection> {
  final GameService _gameService = GameService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselRow(
      cardSpacing: UIConstants.cardSpacing,
      cardsPerView: UIConstants.defaultCardsPerView,
      heading: 'Favorited Videos',
      handleApiCall: (page) {
        return _gameService.getFavoriteContent(
          page: page,
          limit: UIConstants.defaultPageSize,
          contentType: MediaType.video.value,
        );
      },
      cardBuilder: (context, content, width, index) {
        return VideoCard(
          thumbnailUrl:
              'https://xstrela-dev.s3.us-east-1.amazonaws.com/general/22_05_2024/65ecb31b797e4e1aba1ff46fd30eeb3b.png',
          videoUrl: content.url,
          height: 250,
          timeAgo: content.createdAt.toString(),
          duration: '12:00',
          title: content.title ?? '',
          publisherAvatarUrl: content.companyImage ?? '',
          isVerified: true,
          publisherName: content.companyName ?? '',
          friendsWatchedCount: 10,
        );
      },
    );
  }
}
