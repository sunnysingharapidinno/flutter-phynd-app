import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/layouts/base_layout.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Game',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Game Header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .extension<AppTheme>()!
                            .get('primary'),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.games,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Game Title',
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
                            'Publisher Name',
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
              'This is a detailed description of the game. It includes information about gameplay, features, and other relevant details.',
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
                  itemCount: 3,
                  itemBuilder: (context, index) => Container(
                    width: 300,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .extension<AppTheme>()!
                          .get('primary'),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Screenshot ${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
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
