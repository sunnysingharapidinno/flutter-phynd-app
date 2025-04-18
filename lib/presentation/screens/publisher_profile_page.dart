import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/layouts/base_layout.dart';

class PublisherProfilePage extends StatelessWidget {
  const PublisherProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final primaryColor = theme?.get('primary') ?? Colors.blue;
    final textColor = theme?.get('text') ?? Colors.black;

    return BaseLayout(
      title: 'Publisher Profile',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: primaryColor,
                      child: const Icon(
                        Icons.business,
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
                            'Game Studio XYZ',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'game.studio@example.com',
                            style: TextStyle(
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _buildStatItem(
                                context,
                                'Games',
                                '12',
                                Icons.games,
                                primaryColor,
                                textColor,
                              ),
                              const SizedBox(width: 16),
                              _buildStatItem(
                                context,
                                'Players',
                                '1.2K',
                                Icons.people,
                                primaryColor,
                                textColor,
                              ),
                              const SizedBox(width: 16),
                              _buildStatItem(
                                context,
                                'Rating',
                                '4.8',
                                Icons.star,
                                primaryColor,
                                textColor,
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
            // About Section
            _buildSection(
              context,
              'About',
              'Game Studio XYZ is a leading developer of mobile games, specializing in casual and puzzle games. Founded in 2015, we have released over 12 successful games with millions of downloads worldwide.',
              textColor,
            ),
            const SizedBox(height: 24),
            // Recent Games
            _buildSection(
              context,
              'Recent Games',
              Column(
                children: [
                  _buildGameCard(
                    context,
                    'Puzzle Master',
                    'A challenging puzzle game with 100+ levels',
                    '4.7',
                    '500K+',
                    primaryColor,
                    textColor,
                  ),
                  _buildGameCard(
                    context,
                    'Word Wizard',
                    'Test your vocabulary in this word game',
                    '4.6',
                    '300K+',
                    primaryColor,
                    textColor,
                  ),
                ],
              ),
              textColor,
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
    Color textColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 16),
        if (content is String)
          Text(
            content,
            style: TextStyle(
              color: textColor,
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
    Color primaryColor,
    Color textColor,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          color: primaryColor,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildGameCard(
    BuildContext context,
    String title,
    String description,
    String rating,
    String downloads,
    Color primaryColor,
    Color textColor,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.games,
            color: Colors.white,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: TextStyle(
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.star,
                  size: 16,
                  color: primaryColor,
                ),
                const SizedBox(width: 4),
                Text(
                  rating,
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.download,
                  size: 16,
                  color: primaryColor,
                ),
                const SizedBox(width: 4),
                Text(
                  downloads,
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
