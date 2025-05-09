import 'package:flutter/material.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/cards/clip_card/game_clip_card.dart';
import 'package:phynd_app/presentation/widgets/cards/skeleton_loaders/game_clip_card_skeleton.dart';
import 'package:phynd_app/presentation/widgets/common/no_data_widget.dart';
import 'package:phynd_app/presentation/widgets/game_clip_slider/game_clip_slider.dart';
import 'package:phynd_app/presentation/widgets/heading/slider_heading.dart';
import 'package:phynd_app/presentation/widgets/ratings/ratings.dart';

class FavoriteGameSection extends StatefulWidget {
  const FavoriteGameSection({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteGameSection> createState() => _FavoriteGameState();
}

class _FavoriteGameState extends State<FavoriteGameSection> {
  final GameService _gameService = GameService();
  List<GameClipCard> _cards = [];
  bool _isLoading = true;
  final _currentPage = 1;
  static const int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _fetchCards();
  }

  Future<void> _fetchCards() async {
    try {
      final result = await _gameService.getFavoriteGames(
        page: _currentPage,
        limit: _pageSize,
      );

      setState(() {
        _cards = result.data
            .map((game) => GameClipCard(
                  imageUrl: game.imageUrl ?? '',
                  videoUrl: game.trailerUrl ?? '',
                  gameName: game.title ?? '',
                  badge: Ratings(rating: game.rating ?? 0.0),
                  esrbImageUrl: game.esrbRatingUrl ?? '',
                ))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error appropriately
      print('Error fetching games: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_isLoading)
          GameClipSlider(
            title: 'Favorited Games',
            cards: List.generate(
              3,
              (index) => const GameClipCardSkeleton(),
            ),
          )
        else if (_cards.isEmpty)
          const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SliderHeading('Favorited Games'),
              SizedBox(height: 16),
              NoDataWidget(
                title: 'No Favorited Games',
                subtitle: 'You haven\'t favorited any content yet',
                icon: Icons.bookmark_border,
              ),
            ],
          )
        else
          GameClipSlider(
            title: 'Favorited Games',
            cards: _cards,
          ),
        const SizedBox(height: 32),
      ],
    );
  }
}
