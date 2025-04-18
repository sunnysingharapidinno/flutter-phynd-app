import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/layouts/base_layout.dart';

class QuestPage extends StatelessWidget {
  const QuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Quests',
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Active Quests
          _buildSection(
            context,
            'Active Quests',
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) => _buildQuestCard(
                context,
                'Quest ${index + 1}',
                'Complete this quest to earn rewards',
                '100 XP',
                Icons.flag,
                Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Completed Quests
          _buildSection(
            context,
            'Completed Quests',
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) => _buildQuestCard(
                context,
                'Completed Quest ${index + 1}',
                'You have completed this quest',
                '50 XP',
                Icons.check_circle,
                Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    Widget content,
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
        content,
      ],
    );
  }

  Widget _buildQuestCard(
    BuildContext context,
    String title,
    String description,
    String reward,
    IconData icon,
    Color iconColor,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).extension<AppTheme>()!.get('text'),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: TextStyle(
                color: Theme.of(context).extension<AppTheme>()!.get('text'),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.star,
                  size: 16,
                  color:
                      Theme.of(context).extension<AppTheme>()!.get('primary'),
                ),
                const SizedBox(width: 4),
                Text(
                  reward,
                  style: TextStyle(
                    color: Theme.of(context).extension<AppTheme>()!.get('text'),
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
