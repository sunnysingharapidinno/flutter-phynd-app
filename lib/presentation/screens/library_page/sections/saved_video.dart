import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/ui_constants.dart';
import 'package:phynd_app/core/enums/media_type.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/cards/video_cards.dart';
import 'package:phynd_app/presentation/widgets/carousel/carousel_row.dart';

class SavedVideoSection extends StatefulWidget {
  const SavedVideoSection({
    Key? key,
  }) : super(key: key);

  @override
  State<SavedVideoSection> createState() => _SavedVideoState();
}

class _SavedVideoState extends State<SavedVideoSection> {
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
      heading: 'Saved Videos',
      handleApiCall: (page) {
        return _gameService.getSavedContent(
          page: page,
          limit: UIConstants.defaultPageSize,
          contentType: MediaType.video.value,
        );
      },
      cardBuilder: (context, content, width, index) {
        return VideoCard(
          thumbnailUrl: content.thumbnailUrl ?? '',
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
