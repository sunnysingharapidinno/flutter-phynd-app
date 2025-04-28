import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/data/models/response/game_model.dart';
import 'package:phynd_app/data/models/payload/game_payload_model.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/layouts/base_layout.dart';
import 'package:phynd_app/presentation/widgets/loader/circular_load.dart';
import 'package:phynd_app/presentation/widgets/banners/game_banner.dart';
import 'package:phynd_app/presentation/widgets/cards/screenshot_card.dart';
import 'package:phynd_app/presentation/widgets/cards/gameplay_clip_card.dart';
import 'package:phynd_app/presentation/widgets/cards/ad_card.dart';
import 'package:phynd_app/presentation/widgets/cards/game_promo_card.dart';
import 'package:phynd_app/presentation/widgets/cards/tournament_card.dart';

class GamePage extends StatefulWidget {
  final String gameSlug;

  const GamePage({super.key, required this.gameSlug});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  GameDetails? _gameDetails;
  List<GameDetails>? _publisherGames;
  late bool _isLoading = false;
  late bool _isPublisherGamesLoading = false;
  final GameService _gameService = GameService();

  @override
  void initState() {
    super.initState();
    _fetchGameDetails();
  }

// will be used once gameSlug is dynamic
  // @override
  // void didUpdateWidget(covariant GamePage oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (widget.gameSlug != oldWidget.gameSlug) {
  //     _fetchGameDetails(); // Re-fetch when gameSlug changes
  //   }
  // }

  Future<void> _fetchGameDetails() async {
    setState(() => _isLoading = true);

    try {
      final details =
          await _gameService.getGameDetails(gameSlug: widget.gameSlug);

      final screenshots = [
        GameScreenshot(
          url:
              'https://xstrela-alpha.s3.amazonaws.com/images/MarvelRivalsPoster.jpeg',
          title: 'RandomTitle',
        ),
        GameScreenshot(
          url:
              'https://xstrela-alpha.s3.amazonaws.com/images/MarvelRivals3.png',
          title: 'RandomTitle',
        ),
        GameScreenshot(
          url: 'https://xstrela-alpha.s3.amazonaws.com/images/MarioKarts.png',
          title: 'RandomTitle',
        ),
        GameScreenshot(
          url:
              'https://xstrela-alpha.s3.amazonaws.com/images/HeroesOfMavia.jpeg',
          title: 'RandomTitle',
        ),
      ];

      final updatedDetails = GameDetails(
        gameSlug: details.gameSlug,
        gameTitle: details.gameTitle,
        shortBio: details.shortBio,
        developers: details.developers,
        releaseDate: details.releaseDate,
        genre: details.genre,
        subGenre: details.subGenre,
        languageSupported: details.languageSupported,
        modes: details.modes,
        platforms: details.platforms,
        controllers: details.controllers,
        browserSupport: details.browserSupport,
        tags: details.tags,
        gameMedia: details.gameMedia,
        gameScreenshots: screenshots,
        isBrowserBasedGame: details.isBrowserBasedGame,
        downloadUrl: details.downloadUrl,
        launcherUrl: details.launcherUrl,
        startDate: details.startDate,
        endDate: details.endDate,
        isBlockchainSupported: details.isBlockchainSupported,
        blockchainPlatform: details.blockchainPlatform,
        adSupported: details.adSupported,
        contentRating: details.contentRating,
        ageRestricted: details.ageRestricted,
        cost: details.cost,
        rentalDuration: details.rentalDuration,
        syndicated: details.syndicated,
        websiteUrl: details.websiteUrl,
        twitterLink: details.twitterLink,
        discordLink: details.discordLink,
        whitePaperLink: details.whitePaperLink,
        telegramLink: details.telegramLink,
        storageRequirements: details.storageRequirements,
        ramRequirements: details.ramRequirements,
        processorRequirements: details.processorRequirements,
        osRequirements: details.osRequirements,
        gamePlayModes: details.gamePlayModes,
        inAppPurchases: details.inAppPurchases,
        isGameFeatured: details.isGameFeatured,
        isFromVerifiedPublisher: details.isFromVerifiedPublisher,
        gameFranchise: details.gameFranchise,
        iframable: details.iframable,
        publisherId: details.publisherId,
        publisherDisplayName: details.publisherDisplayName,
        publisherType: details.publisherType,
        parentCompanyId: details.parentCompanyId,
        parentCompanyName: details.parentCompanyName,
        parentCompanyDisplayName: details.parentCompanyDisplayName,
        parentCompanyType: details.parentCompanyType,
        esrbRatingImgUrl: details.esrbRatingImgUrl,
        pegiRatingImgUrl: details.pegiRatingImgUrl,
        rainwayGameId: details.rainwayGameId,
      );

      setState(() => _gameDetails = updatedDetails);
      // if (details?.publisherId != null) {
      //   _fetchPublisherGames(details!.publisherId!);
      // }
    } catch (e) {
      print("Error fetching game details: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchPublisherGames(String publisherId) async {
    setState(() => _isPublisherGamesLoading = true);

    try {
      final filters = GamePayload(
        publisherId: [publisherId],
      );
      final games = await _gameService.getMarketplaceGames(filters: filters);
      setState(() => _publisherGames = games.data
          .map((game) => GameDetails.fromJson(game.toJson()))
          .toList());
    } catch (e) {
      print("Error fetching publisher games: $e");
    } finally {
      setState(() => _isPublisherGamesLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("${_gameDetails?.gameTitle} _gameDetails");
    return BaseLayout(
      title: 'Game',
      child: SingleChildScrollView(
        child: _isLoading
            ? Center(
                child: CircularLoad(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner Section - No Padding
                  GameBanner(
                    imageUrl:
                        'https://xstrela-alpha.s3.amazonaws.com/images/NeonCarsPoster.jpeg',
                    gameTitle:
                        _gameDetails?.gameTitle.toUpperCase() ?? 'GAME TITLE',
                    gameSubtitle:
                        _gameDetails?.publisherDisplayName?.toUpperCase() ?? '',
                    badgeText: _gameDetails?.isGameFeatured == true
                        ? 'Featured'
                        : null,
                    rating: 4.5, // TODO: Add rating to game model
                    playerCount: 254300, // TODO: Add player count to game model
                    gameGenre: _gameDetails?.genre.join(', ') ?? '',
                    releaseDate: _formatDate(_gameDetails?.releaseDate ?? 0),
                    platforms: _gameDetails?.platforms
                            .map((p) => p.name ?? '')
                            .toList() ??
                        [],
                    onPlayTap: () {
                      // Handle play now tap
                    },
                  ),
                  // Action Buttons Row
                  Container(
                    color:
                        Theme.of(context).extension<AppTheme>()!.get('bgColor'),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left side buttons
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .extension<AppTheme>()!
                                    .get('primary'),
                                foregroundColor: Theme.of(context)
                                    .extension<AppTheme>()!
                                    .get('textOnPrimary'),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text('Play Now'),
                            ),
                            SizedBox(width: 12),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Theme.of(context)
                                    .extension<AppTheme>()!
                                    .get('text'),
                                side: BorderSide(
                                    color: Theme.of(context)
                                        .extension<AppTheme>()!
                                        .get('text')
                                        .withOpacity(0.3)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text('Start Free Trial'),
                            ),
                            SizedBox(width: 12),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Theme.of(context)
                                    .extension<AppTheme>()!
                                    .get('text'),
                                side: BorderSide(
                                    color: Theme.of(context)
                                        .extension<AppTheme>()!
                                        .get('text')
                                        .withOpacity(0.3)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text('Follow Game'),
                            ),
                          ],
                        ),
                        // Right side icon buttons
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.bookmark_border),
                              color: Theme.of(context)
                                  .extension<AppTheme>()!
                                  .get('text'),
                              style: IconButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .extension<AppTheme>()!
                                    .get('cardBg'),
                                shape: CircleBorder(),
                              ),
                            ),
                            SizedBox(width: 8),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.favorite_border),
                              color: Theme.of(context)
                                  .extension<AppTheme>()!
                                  .get('text'),
                              style: IconButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .extension<AppTheme>()!
                                    .get('cardBg'),
                                shape: CircleBorder(),
                              ),
                            ),
                            SizedBox(width: 8),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.share),
                              color: Theme.of(context)
                                  .extension<AppTheme>()!
                                  .get('text'),
                              style: IconButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .extension<AppTheme>()!
                                    .get('cardBg'),
                                shape: CircleBorder(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Other Sections with Padding
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Screenshots Section
                        _buildSection(
                          context,
                          'Screenshots',
                          SizedBox(
                            height: 180,
                            child: _gameDetails?.gameScreenshots.isEmpty == true
                                ? Center(
                                    child: Text(
                                      'No screenshots available',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .extension<AppTheme>()!
                                            .get('textSecondary'),
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        _gameDetails?.gameScreenshots.length ??
                                            0,
                                    itemBuilder: (context, index) {
                                      final screenshot =
                                          _gameDetails!.gameScreenshots[index];
                                      return ScreenshotCard(
                                        imageUrl: screenshot.url,
                                        onTap: () {
                                          // Optional additional handling when screenshot is tapped
                                        },
                                      );
                                    },
                                  ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Description Section with Grid
                        _buildSection(
                          context,
                          'Description',
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _gameDetails?.shortBio ??
                                            'Game description not available.',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .extension<AppTheme>()!
                                              .get('text'),
                                          fontSize: 14,
                                          height: 1.5,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Game Categories:',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .extension<AppTheme>()!
                                              .get('text'),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Wrap(
                                        spacing: 8.0,
                                        runSpacing: 8.0,
                                        children: [
                                          ..._gameDetails?.genre.map(
                                                (genre) => _buildCategoryChip(
                                                    context, genre),
                                              ) ??
                                              [],
                                          ..._gameDetails?.subGenre.map(
                                                (subGenre) =>
                                                    _buildCategoryChip(
                                                        context, subGenre),
                                              ) ??
                                              [],
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .extension<AppTheme>()!
                                        .get('cardBg'),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Game Details',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .extension<AppTheme>()!
                                              .get('text'),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      _buildGameInfoItem(
                                          context, 'Game Rating', '4/5 Stars'),
                                      Divider(
                                          color: Theme.of(context)
                                              .extension<AppTheme>()!
                                              .get('textSecondary')
                                              .withOpacity(0.2)),
                                      _buildGameInfoItem(
                                          context,
                                          'Release Date',
                                          _formatDate(
                                              _gameDetails?.releaseDate ?? 0)),
                                      Divider(
                                          color: Theme.of(context)
                                              .extension<AppTheme>()!
                                              .get('textSecondary')
                                              .withOpacity(0.2)),
                                      _buildGameInfoItem(
                                          context,
                                          'Developer',
                                          _gameDetails?.developers.join(', ') ??
                                              'N/A'),
                                      Divider(
                                          color: Theme.of(context)
                                              .extension<AppTheme>()!
                                              .get('textSecondary')
                                              .withOpacity(0.2)),
                                      _buildGameInfoItem(
                                          context,
                                          'Publisher',
                                          _gameDetails?.publisherDisplayName ??
                                              'N/A'),
                                      Divider(
                                          color: Theme.of(context)
                                              .extension<AppTheme>()!
                                              .get('textSecondary')
                                              .withOpacity(0.2)),
                                      _buildGameInfoItem(
                                          context,
                                          'Platforms',
                                          _gameDetails?.platforms
                                                  .map((p) => p.name)
                                                  .where((name) => name != null)
                                                  .join(', ') ??
                                              'N/A'),
                                      Divider(
                                          color: Theme.of(context)
                                              .extension<AppTheme>()!
                                              .get('textSecondary')
                                              .withOpacity(0.2)),
                                      _buildGameInfoItem(
                                          context,
                                          'Controller Options',
                                          _gameDetails?.controllers
                                                  .map((c) => c.name)
                                                  .where((name) => name != null)
                                                  .join(', ') ??
                                              'N/A'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Gameplay Previews Section
                        _buildSection(
                          context,
                          'Gameplay Previews',
                          SizedBox(
                            height: 320,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                GameplayClipCard(
                                  thumbnailUrl:
                                      'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/game-page-tv-screen/game-page-tv-screen/gameplay-previews/gp1/gp1.jpg',
                                  timeAgo: 'New',
                                  duration: '0:00',
                                  username:
                                      _gameDetails!.publisherDisplayName ??
                                          'Publisher',
                                  userAvatarUrl:
                                      'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/game-page-tv-screen/game-page-tv-screen/gameplay-previews/gp1/logo.png',
                                  isVerified:
                                      _gameDetails?.isFromVerifiedPublisher ??
                                          false,
                                  clipTitle:
                                      'Yooka-Laylee Rave Reviews Trailer ',
                                ),
                                GameplayClipCard(
                                  thumbnailUrl:
                                      'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/game-page-tv-screen/gameplay-previews/updates-/tile-2.jpg',
                                  timeAgo: 'New',
                                  duration: '0:00',
                                  username:
                                      _gameDetails!.publisherDisplayName ??
                                          'Publisher',
                                  userAvatarUrl:
                                      'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/game-page-tv-screen/game-page-tv-screen/gameplay-previews/gp1/logo.png',
                                  isVerified:
                                      _gameDetails?.isFromVerifiedPublisher ??
                                          false,
                                  clipTitle:
                                      'Explore Exciting and Unique Levels',
                                ),
                                GameplayClipCard(
                                  thumbnailUrl:
                                      'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/game-page-tv-screen/gameplay-previews/updates-/tile-3.webp',
                                  timeAgo: 'New',
                                  duration: '0:00',
                                  username:
                                      _gameDetails!.publisherDisplayName ??
                                          'Publisher',
                                  userAvatarUrl:
                                      'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/game-page-tv-screen/game-page-tv-screen/gameplay-previews/gp1/logo.png',
                                  isVerified:
                                      _gameDetails?.isFromVerifiedPublisher ??
                                          false,
                                  clipTitle:
                                      'Yooka-Laylee Gameplay Walkthrough',
                                ),
                                GameplayClipCard(
                                  thumbnailUrl:
                                      'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/game-page-tv-screen/gameplay-previews/updates-/tile-4-(2).webp',
                                  timeAgo: 'New',
                                  duration: '0:00',
                                  username:
                                      _gameDetails!.publisherDisplayName ??
                                          'Publisher',
                                  userAvatarUrl:
                                      'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/game-page-tv-screen/game-page-tv-screen/gameplay-previews/gp1/logo.png',
                                  isVerified:
                                      _gameDetails?.isFromVerifiedPublisher ??
                                          false,
                                  clipTitle: 'First Level Walkthrough',
                                )
                              ],
                            ),
                            // child: _gameDetails?.gameMedia.isEmpty == true
                            //     ? Center(
                            //         child: Text(
                            //           'No gameplay previews available',
                            //           style: TextStyle(
                            //             color: Theme.of(context)
                            //                 .extension<AppTheme>()!
                            //                 .get('textSecondary'),
                            //           ),
                            //         ),
                            //       )
                            //     : ListView.builder(
                            //         scrollDirection: Axis.horizontal,
                            //         itemCount: _gameDetails?.gameMedia
                            //                 .where((m) =>
                            //                     m.mediaType ==
                            //                     GameOvMediaType.video)
                            //                 .length ??
                            //             0,
                            //         itemBuilder: (context, index) {
                            //           final media = _gameDetails!.gameMedia
                            //               .where((m) =>
                            //                   m.mediaType ==
                            //                   GameOvMediaType.video)
                            //               .toList()[index];
                            //           return GameplayClipCard(
                            //             thumbnailUrl: media.url,
                            //             timeAgo: 'New',
                            //             duration: '0:00',
                            //             username: _gameDetails!
                            //                     .publisherDisplayName ??
                            //                 'Publisher',
                            //             userAvatarUrl:
                            //                 'https://via.placeholder.com/40x40',
                            //             isVerified: _gameDetails
                            //                     ?.isFromVerifiedPublisher ??
                            //                 false,
                            //             clipTitle: media.title,
                            //           );
                            //         },
                            //       ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Events and Offers Section
                        _buildSection(
                            context,
                            'Events and Offers',
                            SizedBox(
                              height: 200,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TournamentCard(
                                      imageUrl:
                                          'https://xstrela-alpha.s3.amazonaws.com/images/TournamentBanner.jpeg',
                                      onRegisterTap: () {},
                                      onBookmarkTap: () {},
                                    ),
                                  ),
                                  Expanded(
                                    child: TournamentCard(
                                      imageUrl:
                                          'https://xstrela-alpha.s3.amazonaws.com/images/valorantBanner.jpeg',
                                      tournamentTitle: 'CHAMPIONSHIP',
                                      sponsorNames: const [
                                        'XBOX',
                                        'EA',
                                        'PlayStation'
                                      ],
                                      onRegisterTap: () {},
                                      onBookmarkTap: () {},
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        const SizedBox(height: 24),
                        // Recent Clips and Streams Section
                        _buildSection(
                          context,
                          'Recent Clips and Streams',
                          SizedBox(
                            height: 280,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                // Ad card
                                AdCard(
                                  onWatchTap: () {
                                    // Handle watch ad tap
                                  },
                                  onShopTap: () {
                                    // Handle shop now tap
                                  },
                                ),
                                // Game clips
                                for (int i = 0; i < 3; i++)
                                  GameplayClipCard(
                                    thumbnailUrl:
                                        'https://xstrela-alpha.s3.amazonaws.com/images/MarvelRivals.png',
                                    timeAgo: '${i + 1}d ago',
                                    duration: '${5 + i}:${10 + i * 5}',
                                    username: 'John Doe',
                                    userAvatarUrl:
                                        'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                    isVerified: true,
                                    clipTitle:
                                        'Winning my first round in Season 6',
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // More From This Publisher Section
                        _buildSection(
                          context,
                          'More From This Publisher',
                          SizedBox(
                            height: 200,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                AdCard(
                                  onWatchTap: () {
                                    // Handle watch ad tap
                                  },
                                  onShopTap: () {
                                    // Handle shop now tap
                                  },
                                ),
                                // Game 1
                                GamePromoCard(
                                  imageUrl:
                                      'https://xstrela-alpha.s3.amazonaws.com/images/BrawlStars.jpeg',
                                  gameTitle: 'Brawl Star',
                                  badgeText: 'Free Trial',
                                  rating: 5.0,
                                  onTap: () {
                                    // Handle game tap
                                  },
                                ),

                                // Game 2
                                GamePromoCard(
                                  imageUrl:
                                      'https://xstrela-alpha.s3.amazonaws.com/images/fortniteHeros.jpeg',
                                  gameTitle: 'Fortnite',
                                  rating: 4.5,
                                  badgeText: 'Trending',
                                  onTap: () {
                                    // Handle game tap
                                  },
                                ),

                                // Game 3
                                GamePromoCard(
                                  imageUrl:
                                      'https://xstrela-alpha.s3.amazonaws.com/images/NeonCarsPoster.jpeg',
                                  gameTitle: 'Neon Racers',
                                  rating: 4.8,
                                  badgeText: 'Trending',
                                  onTap: () {
                                    // Handle game tap
                                  },
                                ),

                                // Game 4
                                GamePromoCard(
                                  imageUrl:
                                      'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                  gameTitle: 'Spyro Reignited Trilogy',
                                  rating: 4.7,
                                  badgeText: 'PHYND Exclusive',
                                  onTap: () {
                                    // Handle game tap
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    dynamic content,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).extension<AppTheme>()!.get('text'),
          ),
        ),
        const SizedBox(height: 16),
        if (content is String)
          Text(
            content,
            style: TextStyle(
              color: Theme.of(context).extension<AppTheme>()!.get('text'),
            ),
          )
        else if (content is Widget)
          content,
      ],
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          color: Theme.of(context).extension<AppTheme>()!.get('primary'),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).extension<AppTheme>()!.get('text'),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).extension<AppTheme>()!.get('text'),
          ),
        ),
      ],
    );
  }

  Widget _buildGridItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).extension<AppTheme>()!.get('text'),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Theme.of(context).extension<AppTheme>()!.get('text'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, String label) {
    final theme = Theme.of(context).extension<AppTheme>()!;
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          color: theme.get('textOnPrimary'),
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: theme.get('primary'),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Widget _buildGameInfoItem(BuildContext context, String label, String value) {
    final theme = Theme.of(context).extension<AppTheme>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: theme.get('text'),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                color: theme.get('textSecondary'),
                fontSize: 14,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(int timestamp) {
    if (timestamp == 0) return 'TBA';
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
}
