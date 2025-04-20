import 'package:flutter/material.dart';
import 'package:phynd_app/core/enums/marketplace.dart';
import 'package:phynd_app/core/routing/app_routes.dart';
import 'package:phynd_app/data/models/payload/game_payload_model.dart';
import 'package:phynd_app/data/models/response/game_list_model.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/layouts/base_layout.dart';
import 'package:phynd_app/presentation/widgets/cards/game_card.dart';
import 'package:phynd_app/presentation/widgets/loader/circular_load.dart';
import 'package:phynd_app/presentation/widgets/section/home_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Game>? _featGamesList;
  late bool _isFeatGamesLoading = false;

  List<Game>? _trendGamesList;
  late bool _isTrendGamesLoading = false;

  List<Game>? _topGamesList;
  late bool _isTopGamesLoading = false;

  final GameService _gameService = GameService();

  @override
  void initState() {
    super.initState();
    _fetchFeatGameList();
    _fetchTrendGameList();
    _fetchBrowseGameList();
  }

  Future<void> _fetchFeatGameList() async {
    setState(() => _isFeatGamesLoading = true);

    final filters = GamePayload(
      featuredType: [MarketplaceGameType.featured],
    );

    try {
      final details = await _gameService.getMarketplaceGames(filters: filters);
      setState(() => _featGamesList = details.data);
    } catch (e) {
      print("Error fetching game details: $e");
    } finally {
      setState(() => _isFeatGamesLoading = false);
    }
  }

  Future<void> _fetchTrendGameList() async {
    setState(() => _isTrendGamesLoading = true);

    final filters = GamePayload(
      featuredType: [MarketplaceGameType.trendingGames],
    );

    try {
      final details = await _gameService.getMarketplaceGames(filters: filters);
      setState(() => _trendGamesList = details.data);
    } catch (e) {
      print("Error fetching game details: $e");
    } finally {
      setState(() => _isTrendGamesLoading = false);
    }
  }

  Future<void> _fetchBrowseGameList() async {
    setState(() => _isTopGamesLoading = true);

    final filters = GamePayload(
      featuredType: [MarketplaceGameType.topGames],
    );

    try {
      final details = await _gameService.getMarketplaceGames(filters: filters);
      setState(() => _topGamesList = details.data);
    } catch (e) {
      print("Error fetching game details: $e");
    } finally {
      setState(() => _isTopGamesLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Home',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _isFeatGamesLoading
                ? Center(child: CircularLoad())
                : HomeSection<Map<String, String>>(
                    heading: "Featured Games",
                    items: (_featGamesList ?? [])
                        .map((game) => {
                              'name': game.name,
                              'image': game.image ?? "",
                              'slug': game.slug
                            })
                        .toList(),
                    cardBuilder: (context, game) => GameCard(
                      imageUrl: game['image'] ?? '',
                      gameName: game['name'] ?? '',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.game,
                          arguments: game['slug'],
                        );
                      },
                    ),
                  ),
            const SizedBox(height: 24),
            _isTrendGamesLoading
                ? Center(child: CircularLoad())
                : HomeSection<Map<String, String>>(
                    heading: "Trending Games",
                    items: (_trendGamesList ?? [])
                        .map((game) => {
                              'name': game.name,
                              'image': game.image ?? "",
                              'slug': game.slug ?? "",
                            })
                        .toList(),
                    cardBuilder: (context, game) => GameCard(
                      imageUrl: game['image'] ?? '',
                      gameName: game['name'] ?? '',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.game,
                          arguments: game['slug'],
                        );
                      },
                    ),
                  ),
            const SizedBox(height: 24),
            _isTopGamesLoading
                ? Center(child: CircularLoad())
                : HomeSection<Map<String, String>>(
                    heading: "Top Games",
                    items: (_topGamesList ?? [])
                        .map((game) => {
                              'name': game.name,
                              'image': game.image ?? "",
                            })
                        .toList(),
                    cardBuilder: (context, game) => GameCard(
                      imageUrl: game['image'] ?? '',
                      gameName: game['name'] ?? '',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.game,
                          arguments: game['slug'],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
