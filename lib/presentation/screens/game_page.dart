import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/data/models/response/game_model.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/layouts/base_layout.dart';
import 'package:phynd_app/presentation/widgets/image/image.dart';
import 'package:phynd_app/presentation/widgets/loader/circular_load.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  GameDetails? _gameDetails;
  late bool _isLoading = false;
  final GameService _gameService = GameService();
  final gameSlug = 'xst-electric-sheep-9a116e1e';

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
      final details = await _gameService.getGameDetails(gameSlug: gameSlug);
      setState(() => _gameDetails = details);
    } catch (e) {
      print("Error fetching game details: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Game',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(
                child: CircularLoad(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Game Header
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          GameImageThumbnail(
                              imageUrl: _gameDetails
                                  ?.gameScreenshots.firstOrNull?.url),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _gameDetails!.gameTitle,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .extension<AppTheme>()!
                                        .get('text'),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _gameDetails?.publisherDisplayName ?? "--",
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .extension<AppTheme>()!
                                        .get('text'),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    _buildStatItem(
                                      context,
                                      'Rating',
                                      '4.8',
                                      Icons.star,
                                    ),
                                    const SizedBox(width: 16),
                                    _buildStatItem(
                                      context,
                                      'Downloads',
                                      '1.2M',
                                      Icons.download,
                                    ),
                                    const SizedBox(width: 16),
                                    _buildStatItem(
                                      context,
                                      'Size',
                                      '100MB',
                                      Icons.storage,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Game Description
                  _buildSection(
                    context,
                    'Description',
                    _gameDetails!.shortBio,
                  ),
                  const SizedBox(height: 24),
                  // Screenshots
                  _buildSection(
                    context,
                    'Screenshots',
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _gameDetails?.gameScreenshots.length ??
                            0, // Ensure it uses dynamic length
                        itemBuilder: (context, index) {
                          final screenshot =
                              _gameDetails?.gameScreenshots[index];
                          return Container(
                            width: 300,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .extension<AppTheme>()!
                                  .get('primary'),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: GameImageThumbnail(
                              imageUrl: screenshot
                                  ?.url, // Use the URL of the screenshot
                              size: 300, // You can adjust the size here
                              borderRadius: BorderRadius.circular(8),
                            ),
                          );
                        },
                      ),
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
}
