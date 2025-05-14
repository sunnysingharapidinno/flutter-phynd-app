import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/cards/clip_card/game_clip_card.dart';
import 'package:phynd_app/presentation/widgets/common/no_data_widget.dart';
import 'package:phynd_app/presentation/widgets/heading/slider_heading.dart';
import 'package:phynd_app/presentation/widgets/ratings/ratings.dart';
import 'package:phynd_app/presentation/widgets/section/home_section.dart';

class FavoriteGameSection extends StatefulWidget {
  const FavoriteGameSection({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteGameSection> createState() => _FavoriteGameState();
}

class _FavoriteGameState extends State<FavoriteGameSection> {
  final GameService _gameService = GameService();
  bool _isLoading = true;
  int _currentPage = 1;
  static const int _pageSize = 10;
  bool _hasMoreContent = true;
  List<dynamic> _games = [];

  @override
  void initState() {
    super.initState();
    _fetchCards();
  }

  Future<void> _fetchCards() async {
    if (_currentPage > 1 && (!_hasMoreContent || _isLoading)) return;

    try {
      setState(() {
        _isLoading = true;
      });

      final result = await _gameService.getFavoriteGames(
        page: _currentPage,
        limit: _pageSize,
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
    return Column(
      children: [
        if (_isLoading)
          const Text('Loading...')
        else if (_games.isEmpty)
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
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.pxToDp(context, 56),
              vertical: SizeUtils.pxToDp(context, 0),
            ),
            child: HomeSection(
              cardSpacing: 20,
              cardsPerView: 4,
              heading: 'Favorited Games',
              items: _games,
              cardBuilder: (context, game, width, index) {
                return GameClipCard(
                  imageUrl: game.imageUrl ?? '',
                  videoUrl: game.trailerUrl ?? '',
                  gameName: game.title ?? '',
                  badge: Ratings(rating: game.rating ?? 0.0),
                  esrbImageUrl: game.esrbRatingUrl ?? '',
                );
              },
              onEndOfScroll: () {
                _fetchCards();
                _currentPage++;
              },
            ),
          ),
        const SizedBox(height: 32),
      ],
    );
  }
}
