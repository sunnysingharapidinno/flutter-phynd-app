import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/ui_constants.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/cards/clip_card/game_clip_card.dart';
import 'package:phynd_app/presentation/widgets/section/home_section.dart';

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
  List<dynamic> _games = [];
  bool _isLoading = true;
  int _currentPage = UIConstants.initialPage;
  bool _hasMoreContent = true;

  @override
  void initState() {
    super.initState();
    _gameService = widget.gameService ?? GameService();
    _fetchCards();
  }

  Future<void> _fetchCards() async {
    if (_currentPage > 1 && (!_hasMoreContent || _isLoading)) return;

    try {
      setState(() {
        _isLoading = true;
      });

      final result = await _gameService.getSavedGames(
        page: _currentPage,
        limit: UIConstants.defaultPageSize,
      );

      setState(() {
        if (result.data.isEmpty) {
          _hasMoreContent = false;
        } else {
          if (_currentPage == 1) {
            _games = result.data;
          } else {
            _games.addAll(result.data);
          }
          _hasMoreContent = _currentPage < result.totalPage;
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Error fetching games: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomeSection(
      cardSpacing: UIConstants.cardSpacing,
      cardsPerView: UIConstants.defaultCardsPerView,
      heading: 'Saved Games',
      items: _games,
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
      onEndOfScroll: () {
        _currentPage++;
        _fetchCards();
      },
      isLoading: _isLoading,
      isLoadingMore: _isLoading,
    );
  }
}
