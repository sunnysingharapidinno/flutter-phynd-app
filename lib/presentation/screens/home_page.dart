import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phynd_app/core/enums/marketplace.dart';
import 'package:phynd_app/core/routing/app_routes.dart';
import 'package:phynd_app/data/models/payload/game_payload_model.dart';
import 'package:phynd_app/data/models/response/game_list_model.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/loader/circular_load.dart';
import 'package:phynd_app/presentation/widgets/section/home_section.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/widgets/banners/game_banner.dart';
import 'package:phynd_app/presentation/widgets/cards/game_activity_card.dart';
import 'package:phynd_app/presentation/widgets/cards/play_card.dart';
import 'package:phynd_app/presentation/widgets/cards/free_play_card.dart';
import 'package:phynd_app/presentation/widgets/cards/shorts_card.dart';
import 'package:phynd_app/presentation/widgets/cards/game_trials_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _featuredPageController;
  Timer? _featuredTimer;
  int _currentFeaturedIndex = 0;

  List<GameItem>? _featGamesList;
  late bool _isFeatGamesLoading = false;

  List<GameItem>? _trendGamesList;
  late bool _isTrendGamesLoading = false;

  List<GameItem>? _topGamesList;
  late bool _isTopGamesLoading = false;

  List<GameItem>? _newGamesList;
  late bool _isNewGamesLoading = false;

  final GameService _gameService = GameService();

  @override
  void initState() {
    super.initState();
    _featuredPageController = PageController();
    _fetchFeatGameList().then((_) {
      _startFeaturedTimer();
    });
    _fetchTrendGameList();
    _fetchNewGameList();
    // _fetchBrowseGameList();
  }

  void _startFeaturedTimer() {
    _featuredTimer?.cancel();
    _featuredTimer = Timer.periodic(const Duration(seconds: 7), (timer) {
      if (_featGamesList != null &&
          _featGamesList!.isNotEmpty &&
          _featuredPageController.hasClients) {
        int nextPage = (_currentFeaturedIndex + 1) % _featGamesList!.length;
        _featuredPageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _featuredTimer?.cancel();
    _featuredPageController.dispose();
    super.dispose();
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
      featuredType: [MarketplaceGameType.topGames],
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

  Future<void> _fetchNewGameList() async {
    setState(() => _isNewGamesLoading = true);

    final filters = GamePayload(
      featuredType: [MarketplaceGameType.browserGames],
    );

    try {
      final details = await _gameService.getMarketplaceGames(filters: filters);
      setState(() => _newGamesList = details.data);
    } catch (e) {
      print("Error fetching game details: $e");
    } finally {
      setState(() => _isNewGamesLoading = false);
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
    final theme = Theme.of(context).extension<AppTheme>()!;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PrimaryButton(
          //     text: "Show Game",
          //     onPressed: () {
          //       Navigator.pushNamed(
          //         context,
          //         AppRoutes.game,
          //         arguments: 'need-for-speed-heat',
          //       );
          //     }),

          // PrimaryButton(
          //     text: "View Video",
          //     onPressed: () {
          //       Navigator.pushNamed(
          //         context,
          //         AppRoutes.video,
          //       );
          //     }),

          // Featured Game Banner
          _buildFeaturedGameSection(context),

          // Latest Activity Section
          _buildLatestActivitySection(context),

          // Continue Playing Section
          HomeSection(
            heading: 'Continue Playing',
            height: 220,
            items: (_trendGamesList ?? [])
                .map((game) => {
                      'slug': game.slug,
                      'title': game.name,
                      'imageUrl': game.image?.isNotEmpty == true
                          ? game.image!
                          : 'https://via.placeholder.com/300x200/1a1a1a/ffffff?text=Game+Image',
                      'rating':
                          4.0, // Default value since Game model doesn't have rating
                      'isFree':
                          true, // Default value since Game model doesn't have isFree
                      'isMultiplayer':
                          game.mode?.contains('multiplayer') ?? false,
                      'isSinglePlayer':
                          game.mode?.contains('singleplayer') ?? false,
                      'esrbRating': game.esrbRatingImgUrl ?? '',
                    })
                .toList(),
            cardBuilder: (context, game) {
              return PlayCard(
                imageUrl: game['imageUrl'] as String,
                title: game['title'] as String,
                rating: game['rating'] as double,
                isFree: game['isFree'] as bool,
                isMultiplayer: game['isMultiplayer'] as bool,
                isSinglePlayer: game['isSinglePlayer'] as bool,
                esrbRating: game['esrbRating'] as String,
                width: 300,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.game,
                    arguments: game['slug'],
                  );
                },
              );
            },
          ),

          // Clips from Friends Section
          _buildClipsFromFriendsSection(context),

          // Free to Play Section
          HomeSection(
            heading: 'Free to Play',
            height: 220,
            items: (_featGamesList ?? [])
                .map((game) => {
                      'slug': game.slug,
                      'title': game.name,
                      'imageUrl': game.image?.isNotEmpty == true
                          ? game.image!
                          : 'https://via.placeholder.com/300x200/1a1a1a/ffffff?text=Game+Image',
                      'rating':
                          4.0, // Default value since Game model doesn't have rating
                      'isFree':
                          true, // Default value since Game model doesn't have isFree
                      'isMultiplayer':
                          game.mode?.contains('multiplayer') ?? false,
                      'isSinglePlayer':
                          game.mode?.contains('singleplayer') ?? false,
                      'esrbRating': game.esrbRatingImgUrl ?? '',
                    })
                .toList(),
            cardBuilder: (context, game) {
              return FreePlayCard(
                isExclusive: true,
                imageUrl: game['imageUrl'] as String,
                title: game['title'] as String,
                rating: game['rating'] as double,
                isFree: game['isFree'] as bool,
                isMultiplayer: game['isMultiplayer'] as bool,
                isSinglePlayer: game['isSinglePlayer'] as bool,
                esrbRating: game['esrbRating'] as String,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.game,
                    arguments: game['slug'],
                  );
                },
              );
            },
          ),

          // Free Trials Section
          HomeSection(
            heading: 'Free Trials',
            height: 314,
            items: (_newGamesList ?? [])
                .map((game) => {
                      'slug': game.slug,
                      'title': game.name,
                      'imageUrl': game.image?.isNotEmpty == true
                          ? game.image!
                          : 'https://via.placeholder.com/300x200/1a1a1a/ffffff?text=Game+Image',
                      'rating':
                          4.0, // Default value since Game model doesn't have rating
                      'isFree':
                          true, // Default value since Game model doesn't have isFree
                      'isMultiplayer':
                          game.mode?.contains('multiplayer') ?? false,
                      'isSinglePlayer':
                          game.mode?.contains('singleplayer') ?? false,
                      'esrbRating': game.esrbRatingImgUrl ?? '',
                      'rating': 4.5,
                      'trialDuration': '2',
                      'price': '9.99',
                      'coinPrice': 24,
                      'friendAvatars': [
                        'https://i.imgur.com/VvvURHZ.jpeg',
                        'https://i.imgur.com/kxNSgIY.jpeg',
                        'https://i.imgur.com/iNKFLtW.jpeg',
                      ],
                      'friendsPlayingCount': 56,
                      'onlineCount': 15,
                    })
                .toList(),
            cardBuilder: (context, game) {
              return GameTrialsCard(
                trialDuration: game['trialDuration'] as String,
                price: game['price'] as String,
                coinPrice: '${game['coinPrice']}',
                friendAvatars: (game['friendAvatars'] as List).cast<String>(),
                friendsPlayingCount: game['friendsPlayingCount'] as int,
                onlineCount: game['onlineCount'] as int,
                imageUrl: game['imageUrl'] as String,
                title: game['title'] as String,
                rating: game['rating'] as double,
                esrbRating: game['esrbRating'] as String,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.game,
                    arguments: game['slug'],
                  );
                },
              );
            },
          ),

          // Livestreaming Now Section
          _buildLivestreamingSection(context),

          // Shorts Section
          _buildShortsSection(context),

          // Bottom padding
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildFeaturedGameSection(BuildContext context) {
    if (_isFeatGamesLoading) {
      return const Center(child: CircularLoad());
    }

    if (_featGamesList == null || _featGamesList!.isEmpty) {
      return GameBanner(
        gameTitle: 'CRASH BANDICOOT 4',
        gameSubtitle: 'IT\'S ABOUT TIME',
        badgeText: 'Featured',
        onPlayTap: () {},
      );
    }

    return SizedBox(
      height: 500, // Adjust this height as needed
      child: PageView.builder(
        controller: _featuredPageController,
        itemCount: _featGamesList!.length,
        onPageChanged: (index) {
          setState(() {
            _currentFeaturedIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final featuredGame = _featGamesList![index];
          return GameBanner(
            imageUrl:
                featuredGame.image ?? 'https://via.placeholder.com/1920x1080',
            gameTitle: featuredGame.name.toUpperCase(),
            gameSubtitle:
                featuredGame.publisherDisplayName?.toUpperCase() ?? '',
            badgeText: 'Featured',
            rating: 4.5,
            playerCount: 254300,
            gameGenre: featuredGame.category?.join(', ') ?? 'Action, Adventure',
            releaseDate: featuredGame.firstReleaseDate != null
                ? _formatDate(featuredGame.firstReleaseDate!)
                : 'Nov 10, 2023',
            platforms: featuredGame.platform ?? ['PC', 'Xbox', 'PlayStation'],
            onPlayTap: () {},
          );
        },
      ),
    );
  }

  String _formatDate(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  Widget _buildLatestActivitySection(BuildContext context) {
    // Sample data for activity cards
    final activityData = [
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/heros-home-screen/latest-activity/tile-3/tile-3.png',
        'timeAgo': '2 Hrs Ago',
        'gameTitle': 'SNK_Corp',
        'duration': '8:14',
        'userName': 'OutofOrbit',
        'isVerified': true,
        'clipTitle': 'Updates for Samurai Shodown',
        'friendsWatchedCount': 34,
        'friendAvatars': [
          'https://i.imgur.com/VvvURHZ.jpeg',
          'https://i.imgur.com/kxNSgIY.jpeg',
          'https://i.imgur.com/iNKFLtW.jpeg',
          'https://i.imgur.com/D7PVWoL.jpeg',
          'https://i.imgur.com/bm5LDrA.jpeg',
        ],
      },
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/heros-home-screen/latest-activity/tile-4/tile-4.jpg',
        'timeAgo': '5 Hrs Ago',
        'gameTitle': 'Fortnite',
        'duration': '3:45',
        'userName': 'NetEase_Games',
        'isVerified': false,
        'clipTitle': 'Early Access now!',
        'friendsWatchedCount': 18,
        'friendAvatars': [
          'https://i.imgur.com/VvvURHZ.jpeg',
          'https://i.imgur.com/kxNSgIY.jpeg',
          'https://i.imgur.com/iNKFLtW.jpeg',
        ],
      },
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/heros-home-screen/latest-activity/tile-3/tile-3.png',
        'timeAgo': '1 Day Ago',
        'gameTitle': 'Call of Duty',
        'duration': '6:22',
        'userName': 'SNK_Corp',
        'isVerified': true,
        'clipTitle': 'Updates for Samurai Shodown',
        'friendsWatchedCount': 27,
        'friendAvatars': [
          'https://i.imgur.com/VvvURHZ.jpeg',
          'https://i.imgur.com/kxNSgIY.jpeg',
          'https://i.imgur.com/iNKFLtW.jpeg',
          'https://i.imgur.com/bm5LDrA.jpeg',
        ],
      },
    ];

    return HomeSection<Map<String, Object>>(
      heading: 'Latest Activity',
      height: 290,
      items: activityData,
      cardBuilder: (context, data) {
        return GameActivityCard(
          imageUrl: data['thumbnailUrl'] as String,
          title: data['clipTitle'] as String,
          username: data['userName'] as String,
          timestamp: data['timeAgo'] as String,
          onTap: () {
            // Handle tap
            Navigator.pushNamed(
              context,
              AppRoutes.video,
            );
          },
        );
      },
    );
  }

  Widget _buildClipsFromFriendsSection(BuildContext context) {
    // Sample data for clips from friends
    final clipsData = [
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/home-screen/clips-from-friends/tile-2/fortnite-image-1.jpg',
        'timeAgo': '3 Hrs Ago',
        'gameTitle': 'Apex Legends',
        'duration': '5:22',
        'userName': 'Fortnite',
        'isVerified': false,
        'clipTitle': 'Winning my first round in Season 6',
        'friendsWatchedCount': 15,
        'friendAvatars': [
          'https://i.imgur.com/VvvURHZ.jpeg',
          'https://i.imgur.com/kxNSgIY.jpeg',
          'https://i.imgur.com/iNKFLtW.jpeg',
        ],
      },
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/home-screen/clips-from-friends/tile-3/rivals-image-1.webp',
        'timeAgo': '1 Day Ago',
        'gameTitle': 'Crazy Spiderman Combos in Marvel Rivals',
        'duration': '2:47',
        'userName': 'SoccerKingZ',
        'isVerified': true,
        'clipTitle': 'Crazy Spiderman Combos in Marvel Rivals',
        'friendsWatchedCount': 28,
        'friendAvatars': [
          'https://i.imgur.com/VvvURHZ.jpeg',
          'https://i.imgur.com/kxNSgIY.jpeg',
          'https://i.imgur.com/iNKFLtW.jpeg',
          'https://i.imgur.com/D7PVWoL.jpeg',
        ],
      },
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/publisher-page-tv-screen/latest-updates/samurai-shodown/samurai-shodown.png',
        'timeAgo': '2 Days Ago',
        'gameTitle': 'First Time Playing Samurai Shodown',
        'duration': '10:15',
        'userName': 'BuilderPro',
        'isVerified': false,
        'clipTitle': 'First Time Playing Samurai Shodown',
        'friendsWatchedCount': 42,
        'friendAvatars': [
          'https://i.imgur.com/VvvURHZ.jpeg',
          'https://i.imgur.com/kxNSgIY.jpeg',
          'https://i.imgur.com/iNKFLtW.jpeg',
          'https://i.imgur.com/D7PVWoL.jpeg',
          'https://i.imgur.com/bm5LDrA.jpeg',
        ],
      },
    ];

    return HomeSection<Map<String, Object>>(
      heading: 'Clips from Friends',
      height: 290,
      items: clipsData,
      cardBuilder: (context, data) {
        return GameActivityCard(
          imageUrl: data['thumbnailUrl'] as String,
          title: data['clipTitle'] as String,
          username: data['userName'] as String,
          timestamp: data['timeAgo'] as String,
          onTap: () {
            // Handle clip tap
            Navigator.pushNamed(
              context,
              AppRoutes.video,
            );
          },
        );
      },
    );
  }

  Widget _buildLivestreamingSection(BuildContext context) {
    // Sample data for livestreaming section
    final livestreamData = [
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/home-screen/live-streaming-now/tile-2/rivals-image-2.jpg',
        'timeAgo': 'LIVE',
        'gameTitle': 'Valorant',
        'duration': '1:45:22',
        'userName': 'ShroudFan',
        'isVerified': true,
        'clipTitle': 'How to use Hulk in Marvel Rivals',
        'friendsWatchedCount': 87,
        'friendAvatars': [
          'https://i.imgur.com/VvvURHZ.jpeg',
          'https://i.imgur.com/kxNSgIY.jpeg',
          'https://i.imgur.com/iNKFLtW.jpeg',
          'https://i.imgur.com/D7PVWoL.jpeg',
          'https://i.imgur.com/bm5LDrA.jpeg',
        ],
      },
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/game-page-smart-tv-forgotten-playland/game-preview-module/tile-1/tile-1.png',
        'timeAgo': 'LIVE',
        'gameTitle': 'League of Legends',
        'duration': '2:15:07',
        'userName': 'MidLaner',
        'isVerified': false,
        'clipTitle': 'Tips & Tricks for Forgotten Playland',
        'friendsWatchedCount': 34,
        'friendAvatars': [
          'https://i.imgur.com/VvvURHZ.jpeg',
          'https://i.imgur.com/kxNSgIY.jpeg',
          'https://i.imgur.com/iNKFLtW.jpeg',
        ],
      },
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/home-screen/live-streaming-now/tile-4/fortnite-image-1.jpg',
        'timeAgo': 'LIVE',
        'gameTitle': 'Grand Theft Auto V',
        'duration': '4:37:18',
        'userName': 'RoleplayKing',
        'isVerified': true,
        'clipTitle': 'Trying the New Fortnite Map',
        'friendsWatchedCount': 56,
        'friendAvatars': [
          'https://i.imgur.com/VvvURHZ.jpeg',
          'https://i.imgur.com/kxNSgIY.jpeg',
          'https://i.imgur.com/iNKFLtW.jpeg',
          'https://i.imgur.com/D7PVWoL.jpeg',
        ],
      },
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/home-screen/shorts/tiles/controllerking-avatar.jpg',
        'timeAgo': 'LIVE',
        'gameTitle': 'Grand Theft Auto V',
        'duration': '4:37:18',
        'userName': 'RoleplayKing',
        'isVerified': true,
        'clipTitle': 'My First Win in Fortnite Season 6',
        'friendsWatchedCount': 56,
        'friendAvatars': [
          'https://i.imgur.com/VvvURHZ.jpeg',
          'https://i.imgur.com/kxNSgIY.jpeg',
          'https://i.imgur.com/iNKFLtW.jpeg',
          'https://i.imgur.com/D7PVWoL.jpeg',
        ],
      },
    ];

    return HomeSection<Map<String, Object>>(
      heading: 'Livestreaming Now',
      height: 290,
      items: livestreamData,
      cardBuilder: (context, data) {
        return GameActivityCard(
          imageUrl: data['thumbnailUrl'] as String,
          title: data['clipTitle'] as String,
          username: data['userName'] as String,
          timestamp: data['timeAgo'] as String,
          onTap: () {
            // Handle livestream tap
            Navigator.pushNamed(
              context,
              AppRoutes.video,
            );
          },
        );
      },
    );
  }

  Widget _buildShortsSection(BuildContext context) {
    // Sample data for shorts section
    final shortsData = [
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/home-screen/shorts/tiles/short-tile-2.jpg',
        'userName': 'MrGamer99',
        'title': 'Beating the Hardest Level in Chaos World',
        'isVerified': true,
      },
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/home-screen/shorts/tiles/short-tile-3.jpg',
        'userName': 'GameTips',
        'title': 'Where to find all Boss Battles in KnightCraft',
        'isVerified': false,
      },
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/home-screen/shorts/tiles/short-tile-4.jpg',
        'userName': 'ProGamerTV',
        'title': 'New Features Coming to Heroscape',
        'isVerified': true,
      },
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/home-screen/shorts/tiles/short-tile-5.jpg',
        'userName': 'ProGamerTV',
        'title': 'How to Pass Without Crashing in RaceTime',
        'isVerified': true,
      },
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/home-screen/shorts/tiles/short-tile-6.jpg',
        'userName': 'ProGamerTV',
        'title': 'New Halloween Map for Bubble Blaster',
        'isVerified': true,
      },
    ];

    return HomeSection<Map<String, Object>>(
      heading: 'Shorts',
      height: 340,
      items: shortsData,
      cardBuilder: (context, data) {
        return ShortsCard(
          thumbnailUrl: data['thumbnailUrl'] as String,
          userName: data['userName'] as String,
          title: data['title'] as String,
          isVerified: data['isVerified'] as bool,
          onTap: () {
            // Handle short tap
            Navigator.pushNamed(
              context,
              AppRoutes.video,
            );
          },
        );
      },
    );
  }
}
