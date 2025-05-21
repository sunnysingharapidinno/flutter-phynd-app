import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/ui_constants.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/cards/clip_card/game_clip_card.dart';
import 'package:phynd_app/presentation/widgets/carousel/carousel_row.dart';
import 'package:phynd_app/presentation/screens/library_page/models/hero_data.dart';

class RecentHistorySection extends StatefulWidget {
  final Function(HeroData) onHover;
  final VoidCallback onHoverExit;


  const RecentHistorySection({
    super.key,
    required this.onHover,
    required this.onHoverExit,
  });

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
        return MouseRegion(
          onEnter: (_) {
            widget.onHover(HeroData(
              imageUrl: game.imageUrl,
              videoUrl: '', // You might want to add video URL to your game model
              gameTextImg: game.companyImage ?? '',
              releaseYear: game.lastPlayed.year.toString(),
              companyName: game.companyName ?? 'Unknown Company',
              esrb: game.esrb,
              friendsCount: game.ratingCount ?? 0,
              onlineCount: 0, // You might want to add this to your game model
              gameTitle: game.title,
            ));
          },
          onExit: (_) {
            widget.onHoverExit();
          },
          child: GameClipCard(
            thumbnailUrl: game.imageUrl,
            title: game.title,
            rating: game.rating ?? 0.0,
            maxRating: 5,
            esrbRatingImageUrl: game.esrb,
          ),
        );
      },
    );
  }
}
