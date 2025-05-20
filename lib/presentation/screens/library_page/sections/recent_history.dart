import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/ui_constants.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/cards/clip_card/game_clip_card.dart';
import 'package:phynd_app/presentation/widgets/carousel/carousel_row.dart';

class RecentHistorySection extends StatefulWidget {
  const RecentHistorySection({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentHistorySection> createState() => _RecentHistorySectionState();
}

class _RecentHistorySectionState extends State<RecentHistorySection> {
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
      heading: 'Recent History',
      handleApiCall: (page) {
        return _gameService.getRecentHistory(
          page: page,
          limit: UIConstants.defaultPageSize,
        );
      },
      cardBuilder: (context, game, width, index) {
        return GameClipCard(
          thumbnailUrl: game.imageUrl ?? '',
          title: game.title ?? '',
          rating: game.rating ?? 0.0,
          maxRating: 5,
          esrbRatingImageUrl: game.esrb ?? '',
        );
      },
    );
  }
}
