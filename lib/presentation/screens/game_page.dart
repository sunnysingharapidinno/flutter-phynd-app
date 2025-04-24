import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/data/models/response/game_model.dart';
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
  late bool _isLoading = false;
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
      setState(() => _gameDetails = details);
    } catch (e) {
      print("Error fetching game details: $e");
    } finally {
      setState(() => _isLoading = false);
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
                        'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    gameTitle: 'CALL OF DUTY',
                    gameSubtitle: 'MODERN WARFARE III',
                    badgeText: 'Featured',
                    rating: 4.5,
                    playerCount: 254300,
                    gameGenre: 'FPS, Action, Multiplayer',
                    releaseDate: 'Nov 10, 2023',
                    platforms: const ['PC', 'Xbox', 'PlayStation'],
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
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return ScreenshotCard(
                                  imageUrl:
                                      'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
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
                                            'This is where the description of the game will render, including info about the type of game, the objective of the game, and any other details we want to include here. The description will be aggregated from the actual game.',
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
                                          _buildCategoryChip(context, 'Action'),
                                          _buildCategoryChip(
                                              context, 'Adventure'),
                                          _buildCategoryChip(context, 'Racing'),
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
                                          context, 'Release Date', '11/2/2023'),
                                      Divider(
                                          color: Theme.of(context)
                                              .extension<AppTheme>()!
                                              .get('textSecondary')
                                              .withOpacity(0.2)),
                                      _buildGameInfoItem(
                                          context, 'Developer', 'Dev Name'),
                                      Divider(
                                          color: Theme.of(context)
                                              .extension<AppTheme>()!
                                              .get('textSecondary')
                                              .withOpacity(0.2)),
                                      _buildGameInfoItem(
                                          context, 'Publisher', 'Pub Name'),
                                      Divider(
                                          color: Theme.of(context)
                                              .extension<AppTheme>()!
                                              .get('textSecondary')
                                              .withOpacity(0.2)),
                                      _buildGameInfoItem(context, 'Platforms',
                                          'Platforms Icons'),
                                      Divider(
                                          color: Theme.of(context)
                                              .extension<AppTheme>()!
                                              .get('textSecondary')
                                              .withOpacity(0.2)),
                                      _buildGameInfoItem(
                                          context,
                                          'Controller Options',
                                          'Controller Icons'),
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
                            height: 160,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return GameplayClipCard(
                                  imageUrl:
                                      'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                  timeSincePosted: '${2 + index} Hrs Ago',
                                  duration: '8:14',
                                  onTap: () {
                                    // Handle gameplay clip tap
                                  },
                                );
                              },
                            ),
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
                                          'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                      onRegisterTap: () {},
                                      onBookmarkTap: () {},
                                    ),
                                  ),
                                  Expanded(
                                    child: TournamentCard(
                                      imageUrl:
                                          'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
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
                            height: 160,
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
                                    imageUrl:
                                        'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                    timeSincePosted: '${i + 1}d ago',
                                    duration: '${5 + i}:${10 + i * 5}',
                                    onTap: () {
                                      // Handle recent clip tap
                                    },
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
                                // Game 1
                                GamePromoCard(
                                  imageUrl:
                                      'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                  gameTitle: 'Crash Bandicoot 4',
                                  badgeText: 'Free Trial',
                                  rating: 5.0,
                                  onTap: () {
                                    // Handle game tap
                                  },
                                ),

                                // Game 2
                                GamePromoCard(
                                  imageUrl:
                                      'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                  gameTitle: 'Crash Team Racing',
                                  rating: 4.5,
                                  badgeText: 'Trending',
                                  onTap: () {
                                    // Handle game tap
                                  },
                                ),

                                // Game 3
                                GamePromoCard(
                                  imageUrl:
                                      'https://images.unsplash.com/photo-1558981396-5fcf84bdf14d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                  gameTitle: 'Crash Bandicoot N. Sane Trilogy',
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
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${date.month}/${date.day}/${date.year}';
  }
}
