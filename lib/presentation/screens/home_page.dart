import 'package:flutter/material.dart';
import 'package:phynd_app/core/enums/marketplace.dart';
import 'package:phynd_app/core/routing/app_routes.dart';
import 'package:phynd_app/data/models/payload/game_payload_model.dart';
import 'package:phynd_app/data/models/response/game_list_model.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/layouts/base_layout.dart';
import 'package:phynd_app/presentation/widgets/buttons/primary_button.dart';
import 'package:phynd_app/presentation/widgets/cards/game_card.dart';
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
    final theme = Theme.of(context).extension<AppTheme>()!;

    return BaseLayout(
      title: 'Home',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryButton(
                text: "Show Game",
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.game,
                    arguments: 'need-for-speed-heat',
                  );
                }),

            PrimaryButton(
                text: "View Video",
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.video,
                  );
                }),

            // Featured Game Banner
            _buildFeaturedGameSection(context),

            // Latest Activity Section
            _buildLatestActivitySection(context),

            // Continue Playing Section
            _buildContinuePlayingSection(context),

            // Clips from Friends Section
            _buildClipsFromFriendsSection(context),

            // Free to Play Section
            _buildFreeToPlaySection(context),

            // Free Trials Section
            _buildFreeTrialsSection(context),

            // Livestreaming Now Section
            _buildLivestreamingSection(context),

            // Shorts Section
            _buildShortsSection(context),

            // Bottom padding
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedGameSection(BuildContext context) {
    if (_isFeatGamesLoading) {
      return Center(child: CircularLoad());
    }

    if (_featGamesList?.isNotEmpty == true) {
      final featuredGame = _featGamesList!.first;
      return GameBanner(
        imageUrl: featuredGame.image ??
            'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        gameTitle: featuredGame.name.toUpperCase(),
        gameSubtitle: featuredGame.publisherDisplayName?.toUpperCase() ?? '',
        badgeText: 'Featured',
        rating: 4.5,
        playerCount: 254300,
        gameGenre: featuredGame.category?.join(', ') ?? 'Action, Adventure',
        releaseDate: featuredGame.firstReleaseDate != null
            ? _formatDate(featuredGame.firstReleaseDate!)
            : 'Nov 10, 2023',
        platforms: featuredGame.platform ?? ['PC', 'Xbox', 'PlayStation'],
        onPlayTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.game,
            arguments: featuredGame.slug,
          );
        },
      );
    }

    // Fallback banner if no featured games are available
    return GameBanner(
      gameTitle: 'CRASH BANDICOOT 4',
      gameSubtitle: 'IT\'S ABOUT TIME',
      badgeText: 'Featured',
      onPlayTap: () {},
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
            'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'timeAgo': '2 Hrs Ago',
        'gameTitle': 'Marvel Rivals',
        'duration': '8:14',
        'userName': 'OutofOrbit',
        'isVerified': true,
        'clipTitle': 'How to Use Doctor Strange Portals',
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
        'thumbnailUrl': 'https://i.imgur.com/Nl7KAXw.jpeg',
        'timeAgo': '5 Hrs Ago',
        'gameTitle': 'Fortnite',
        'duration': '3:45',
        'userName': 'GamerPro',
        'isVerified': false,
        'clipTitle': 'Epic Victory Royale in Chapter 5',
        'friendsWatchedCount': 18,
        'friendAvatars': [
          'https://i.imgur.com/VvvURHZ.jpeg',
          'https://i.imgur.com/kxNSgIY.jpeg',
          'https://i.imgur.com/iNKFLtW.jpeg',
        ],
      },
      {
        'thumbnailUrl': 'https://i.imgur.com/aZRkRFf.jpeg',
        'timeAgo': '1 Day Ago',
        'gameTitle': 'Call of Duty',
        'duration': '6:22',
        'userName': 'FPSmaster',
        'isVerified': true,
        'clipTitle': 'Top 10 Warzone Plays This Week',
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
          },
        );
      },
    );
  }

  Widget _buildContinuePlayingSection(BuildContext context) {
    // Sample data for continue playing games
    final continuePlayingGames = [
      {
        'imageUrl':
            'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'title': 'Fortnite',
        'rating': 4.5,
        'isFree': true,
        'isMultiplayer': true,
        'isSinglePlayer': true,
        'esrbRating': 'T',
      },
      {
        'imageUrl':
            'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'title': 'Call of Duty: Modern Warfare',
        'rating': 4.0,
        'isFree': false,
        'isMultiplayer': true,
        'isSinglePlayer': true,
        'esrbRating': 'M',
      },
      {
        'imageUrl':
            'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'title': 'FIFA 23',
        'rating': 3.5,
        'isFree': false,
        'isMultiplayer': true,
        'isSinglePlayer': false,
        'esrbRating': 'E',
      },
    ];

    return HomeSection<Map<String, Object>>(
      heading: 'Continue Playing',
      height: 220,
      items: continuePlayingGames,
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
            // Handle navigation to game details
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
            'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'timeAgo': '3 Hrs Ago',
        'gameTitle': 'Apex Legends',
        'duration': '5:22',
        'userName': 'HuntMaster',
        'isVerified': false,
        'clipTitle': 'Clutch Win in Diamond Lobby',
        'friendsWatchedCount': 15,
        'friendAvatars': [
          'https://i.imgur.com/VvvURHZ.jpeg',
          'https://i.imgur.com/kxNSgIY.jpeg',
          'https://i.imgur.com/iNKFLtW.jpeg',
        ],
      },
      {
        'thumbnailUrl':
            'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'timeAgo': '1 Day Ago',
        'gameTitle': 'Rocket League',
        'duration': '2:47',
        'userName': 'SoccerKingZ',
        'isVerified': true,
        'clipTitle': 'Aerial Goal Montage',
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
            'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'timeAgo': '2 Days Ago',
        'gameTitle': 'Minecraft',
        'duration': '10:15',
        'userName': 'BuilderPro',
        'isVerified': false,
        'clipTitle': 'My Survival Base Tour',
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
          },
        );
      },
    );
  }

  Widget _buildFreeToPlaySection(BuildContext context) {
    // Sample data for free-to-play games
    final freeGames = [
      {
        'imageUrl':
            'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'title': 'Marvel Rivals',
        'rating': 4.5,
        'isFree': true,
        'isExclusive': true,
        'isMultiplayer': true,
        'isSinglePlayer': true,
        'esrbRating': 'T',
      },
      {
        'imageUrl':
            'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'title': 'Apex Legends',
        'rating': 4.0,
        'isFree': true,
        'isExclusive': false,
        'isMultiplayer': true,
        'isSinglePlayer': false,
        'esrbRating': 'T',
      },
      {
        'imageUrl':
            'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'title': 'Fortnite',
        'rating': 4.8,
        'isFree': true,
        'isExclusive': false,
        'isMultiplayer': true,
        'isSinglePlayer': true,
        'esrbRating': 'T',
      },
    ];

    return HomeSection<Map<String, Object>>(
      heading: 'Free to Play',
      height: 220,
      items: freeGames,
      cardBuilder: (context, game) {
        return FreePlayCard(
          imageUrl: game['imageUrl'] as String,
          title: game['title'] as String,
          rating: game['rating'] as double,
          isFree: game['isFree'] as bool,
          isExclusive: game['isExclusive'] as bool,
          isMultiplayer: game['isMultiplayer'] as bool,
          isSinglePlayer: game['isSinglePlayer'] as bool,
          esrbRating: game['esrbRating'] as String,
          onTap: () {
            // Handle game selection
          },
        );
      },
    );
  }

  Widget _buildFreeTrialsSection(BuildContext context) {
    // Sample data for free trial games
    final trialGames = [
      {
        'imageUrl':
            'https://cdn.akamai.steamstatic.com/steam/apps/1973710/header.jpg',
        'title': 'Heroes of Mavia',
        'rating': 4.0,
        'trialDuration': '1',
        'price': '4.99',
        'coinPrice': 12,
        'friendAvatars': [
          'https://i.imgur.com/VvvURHZ.jpeg',
          'https://i.imgur.com/kxNSgIY.jpeg',
          'https://i.imgur.com/iNKFLtW.jpeg',
          'https://i.imgur.com/D7PVWoL.jpeg',
        ],
        'friendsPlayingCount': 34,
        'onlineCount': 8,
        'esrbRating': {
          'Fantasy': 'Violence',
          'Mild': 'Blood',
        },
      },
      {
        'imageUrl':
            'https://cdn.akamai.steamstatic.com/steam/apps/1172470/header.jpg',
        'title': 'Sea of Stars',
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
        'esrbRating': {
          'Fantasy': 'Violence',
          'Mild': 'Language',
        },
      },
      {
        'imageUrl':
            'https://cdn.akamai.steamstatic.com/steam/apps/1966720/header.jpg',
        'title': 'Palworld',
        'rating': 4.8,
        'trialDuration': '3',
        'price': '14.99',
        'coinPrice': 36,
        'friendAvatars': [
          'https://i.imgur.com/VvvURHZ.jpeg',
          'https://i.imgur.com/kxNSgIY.jpeg',
          'https://i.imgur.com/iNKFLtW.jpeg',
          'https://i.imgur.com/D7PVWoL.jpeg',
          'https://i.imgur.com/bm5LDrA.jpeg',
        ],
        'friendsPlayingCount': 89,
        'onlineCount': 42,
        'esrbRating': {
          'Fantasy': 'Violence',
          'Mild': 'Blood',
          'Online': 'Interactions',
        },
      },
      {
        'imageUrl':
            'https://cdn.akamai.steamstatic.com/steam/apps/1938090/header.jpg',
        'title': 'Helldivers 2',
        'rating': 4.7,
        'trialDuration': '4',
        'price': '19.99',
        'coinPrice': 48,
        'friendAvatars': [
          'https://i.imgur.com/VvvURHZ.jpeg',
          'https://i.imgur.com/kxNSgIY.jpeg',
          'https://i.imgur.com/iNKFLtW.jpeg',
          'https://i.imgur.com/D7PVWoL.jpeg',
        ],
        'friendsPlayingCount': 67,
        'onlineCount': 23,
        'esrbRating': {
          'Intense': 'Violence',
          'Strong': 'Language',
          'Online': 'Interactions',
        },
      },
    ];

    return HomeSection<Map<String, Object>>(
      heading: 'Free Trials',
      height: 314,
      items: trialGames,
      cardBuilder: (context, game) {
        final index = trialGames.indexOf(game);
        return GameTrialsCard(
          imageUrl: game['imageUrl'] as String,
          title: game['title'] as String,
          rating: game['rating'] as double,
          trialDuration: game['trialDuration'] as String,
          price: game['price'] as String,
          coinPrice: '${game['coinPrice']}',
          friendAvatars: (game['friendAvatars'] as List).cast<String>(),
          friendsPlayingCount: game['friendsPlayingCount'] as int,
          onlineCount: game['onlineCount'] as int,
          esrbRating: (game['esrbRating'] as Map).cast<String, String>(),
          initiallyFocused: index == 0,
        );
      },
    );
  }

  Widget _buildLivestreamingSection(BuildContext context) {
    // Sample data for livestreaming section
    final livestreamData = [
      {
        'thumbnailUrl':
            'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'timeAgo': 'LIVE',
        'gameTitle': 'Valorant',
        'duration': '1:45:22',
        'userName': 'ShroudFan',
        'isVerified': true,
        'clipTitle': 'Ranked Grind to Radiant',
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
            'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'timeAgo': 'LIVE',
        'gameTitle': 'League of Legends',
        'duration': '2:15:07',
        'userName': 'MidLaner',
        'isVerified': false,
        'clipTitle': 'Challenger Series - Team Practice',
        'friendsWatchedCount': 34,
        'friendAvatars': [
          'https://i.imgur.com/VvvURHZ.jpeg',
          'https://i.imgur.com/kxNSgIY.jpeg',
          'https://i.imgur.com/iNKFLtW.jpeg',
        ],
      },
      {
        'thumbnailUrl':
            'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'timeAgo': 'LIVE',
        'gameTitle': 'Grand Theft Auto V',
        'duration': '4:37:18',
        'userName': 'RoleplayKing',
        'isVerified': true,
        'clipTitle': 'NoPixel RP - Criminal Underground',
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
            'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'userName': 'MrGamer99',
        'title': 'New Collabs Coming to Brawl Stars',
        'isVerified': true,
      },
      {
        'thumbnailUrl':
            'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'userName': 'GameTips',
        'title': '5 Tricks You Didn\'t Know About Minecraft',
        'isVerified': false,
      },
      {
        'thumbnailUrl':
            'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'userName': 'ProGamerTV',
        'title': 'Hidden Easter Egg in Call of Duty! Must Watch',
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
          },
        );
      },
    );
  }
}
