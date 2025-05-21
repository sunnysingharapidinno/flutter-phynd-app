import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/ui_constants.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/cards/clip_card/game_clip_card.dart';
import 'package:phynd_app/presentation/widgets/carousel/carousel_row.dart';
import 'package:phynd_app/presentation/screens/library_page/models/hero_data.dart';

class SavedGameSection extends StatefulWidget {
  final GameService? gameService;
  final Function(HeroData) onHover;
  final VoidCallback onHoverExit;

  const SavedGameSection({
    Key? key,
    this.gameService,
    required this.onHover,
    required this.onHoverExit,
  }) : super(key: key);

  @override
  State<SavedGameSection> createState() => _FavoriteGameState();
}

class _FavoriteGameState extends State<SavedGameSection> {
  late final GameService _gameService;

  @override
  void initState() {
    super.initState();
    _gameService = widget.gameService ?? GameService();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselRow(
      cardSpacing: UIConstants.cardSpacing,
      cardsPerView: UIConstants.defaultCardsPerView,
      heading: 'Saved Games',
      handleApiCall: (page) {
        return _gameService.getSavedGames(
          page: page,
          limit: UIConstants.defaultPageSize,
        );
      },
      cardBuilder: (context, game, width, index) {
        return MouseRegion(
          onEnter: (_) {
            widget.onHover(HeroData(
              imageUrl: game.imageUrl ?? game.image ?? '',
              videoUrl: game.trailerUrl ?? '',
              gameTextImg: game.imageUrl ?? game.image ?? '',
              releaseYear: '2024',
              companyName: game.companyName ?? '',
              esrb: game.esrbRatingUrl ?? '',
              friendsCount: 0,
              onlineCount: 0,
              gameTitle: game.title ?? '',
            ));
          },
          onExit: (_) {
            widget.onHoverExit();
          },
          child: GameClipCard(
            thumbnailUrl: game.imageUrl ?? game.image ?? '',
            videoUrl: game.trailerUrl ?? '',
            title: game.title ?? '',
            rating: game.rating ?? 0.0,
            maxRating: 5,
            esrbRatingImageUrl: game.esrbRatingUrl ?? '',
          ),
        );
      },
    );
  }
}
