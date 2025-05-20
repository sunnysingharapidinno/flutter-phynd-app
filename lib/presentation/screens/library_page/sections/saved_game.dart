import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/ui_constants.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/cards/clip_card/game_clip_card.dart';
import 'package:phynd_app/presentation/widgets/carousel/carousel_row.dart';

class SavedGameSection extends StatefulWidget {
  final GameService? gameService;
  const SavedGameSection({
    Key? key,
    this.gameService,
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
        return GameClipCard(
          thumbnailUrl: game.imageUrl ?? game.image ?? '',
          videoUrl: game.trailerUrl ?? '',
          title: game.title ?? '',
          rating: game.rating ?? 0.0,
          maxRating: 5,
          esrbRatingImageUrl: game.esrbRatingUrl ?? '',
        );
      },
    );
  }
}
