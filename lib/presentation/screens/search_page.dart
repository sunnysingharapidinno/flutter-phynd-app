import 'package:flutter/material.dart';
import 'package:phynd_app/core/routing/app_routes.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/widgets/cards/game_trials_card.dart';
import 'package:phynd_app/presentation/widgets/cards/publisher_card.dart';
import 'package:phynd_app/presentation/widgets/cards/user_card.dart';
import 'package:phynd_app/presentation/widgets/input_fields/search_input_field.dart';
import 'package:phynd_app/data/services/algolia_service.dart';
import 'package:phynd_app/core/enums/algolia_index.dart';
import 'dart:async';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final AlgoliaService _algoliaService = AlgoliaService();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  List<Map<String, dynamic>> _gameResults = [];
  List<Map<String, dynamic>> _userResults = [];
  List<Map<String, dynamic>> _publisherResults = [];

  bool _isGamesLoading = false;
  bool _isUsersLoading = false;
  bool _isPublishersLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        _performSearch(query);
      } else {
        _clearResults();
      }
    });
  }

  void _clearResults() {
    setState(() {
      _gameResults = [];
      _userResults = [];
      _publisherResults = [];
    });
  }

  Future<void> _performSearch(String query) async {
    setState(() {
      _isGamesLoading = true;
      _isUsersLoading = true;
      _isPublishersLoading = true;
    });

    await Future.wait([
      _searchGames(query),
      _searchUsers(query),
      _searchPublishers(query),
    ]);
  }

  Future<void> _searchGames(String query) async {
    try {
      final results = await _algoliaService.search(
        indexName: AlgoliaIndex.games,
        query: query,
      );
      if (mounted) setState(() => _gameResults = results);
    } catch (e) {
      debugPrint('Game search error: $e');
    } finally {
      if (mounted) setState(() => _isGamesLoading = false);
    }
  }

  Future<void> _searchUsers(String query) async {
    try {
      final results = await _algoliaService.search(
        indexName: AlgoliaIndex.users,
        query: query,
      );
      if (mounted) setState(() => _userResults = results);
    } catch (e) {
      debugPrint('User search error: $e');
    } finally {
      if (mounted) setState(() => _isUsersLoading = false);
    }
  }

  Future<void> _searchPublishers(String query) async {
    try {
      final results = await _algoliaService.search(
        indexName: AlgoliaIndex.publishers,
        query: query,
      );
      if (mounted) setState(() => _publisherResults = results);
    } catch (e) {
      debugPrint('Publisher search error: $e');
    } finally {
      if (mounted) setState(() => _isPublishersLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: SearchInputField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            hintText: 'Phynd Anything...',
            isLoading:
                _isGamesLoading || _isUsersLoading || _isPublishersLoading,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_isGamesLoading || _gameResults.isNotEmpty)
                    _buildGamesSection(theme),
                  if (_isUsersLoading || _userResults.isNotEmpty)
                    _buildUsersSection(theme),
                  if (_isPublishersLoading || _publisherResults.isNotEmpty)
                    _buildPublishersSection(theme),
                  if (!_isGamesLoading &&
                      !_isUsersLoading &&
                      !_isPublishersLoading &&
                      _gameResults.isEmpty &&
                      _userResults.isEmpty &&
                      _publisherResults.isEmpty &&
                      _searchController.text.isNotEmpty)
                    _buildNoResultsMessage(theme),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoResultsMessage(AppTheme theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64,
              color: theme.get('textSecondary'),
            ),
            const SizedBox(height: 16),
            Text(
              'No results found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: theme.get('text'),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search terms',
              style: TextStyle(
                color: theme.get('textSecondary'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGamesSection(AppTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Games',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: theme.get('text'),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 280,
          child: _isGamesLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _gameResults.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final game = _gameResults[index];
                    return GameTrialsCard(
                      imageUrl: game['image'] ?? '',
                      title: game['name'] ?? '',
                      rating: (game['rating'] as num?)?.toDouble() ?? 4.5,
                      trialDuration: '2 hours',
                      price: '\$59.99',
                      coinPrice: '5000',
                      friendAvatars: const [],
                      friendsPlayingCount: 0,
                      onlineCount: 0,
                      esrbRating: '',
                      onTap: () {
                        // Convert the game map to string and parse it properly
                        final gameString = game.toString();
                        final objectIdMatch = RegExp(r'objectID: ([^,}]+)')
                            .firstMatch(gameString);
                        final gameId = objectIdMatch?.group(1);

                        print('Game ObjectID: $gameId');

                        if (gameId != null && gameId.isNotEmpty) {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.game,
                            arguments: gameId,
                          );
                        }
                      },
                    );
                  },
                ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildUsersSection(AppTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Users',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: theme.get('text'),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: _isUsersLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _userResults.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final user = _userResults[index];
                    return UserCard(
                      avatarUrl: user['avatar'],
                      username: user['display_name'] ?? '',
                      isOnline: user['isOnline'] as bool? ?? false,
                      onTap: () {
                        final userString = user.toString();
                        final objectIdMatch = RegExp(r'objectID: ([^,}]+)')
                            .firstMatch(userString);
                        final userId = objectIdMatch?.group(1);

                        print('User ObjectID: $userId');

                        if (userId != null && userId.isNotEmpty) {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.playerProfile,
                            arguments: userId,
                          );
                        }
                      },
                    );
                  },
                ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildPublishersSection(AppTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Publishers',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: theme.get('text'),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: _isPublishersLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _publisherResults.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final publisher = _publisherResults[index];
                    return PublisherCard(
                      logoUrl: publisher['logo'],
                      name: publisher['name'] ?? '',
                      onTap: () {
                        final userString = publisher.toString();
                        final objectIdMatch = RegExp(r'objectID: ([^,}]+)')
                            .firstMatch(userString);
                        final userId = objectIdMatch?.group(1);

                        print('User ObjectID: $userId');

                        if (userId != null && userId.isNotEmpty) {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.publisherProfile,
                            arguments: userId,
                          );
                        }
                      },
                    );
                  },
                ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
