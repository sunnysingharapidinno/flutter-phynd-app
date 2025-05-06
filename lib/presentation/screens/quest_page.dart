import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/widgets/profile/quests_in_progress.dart';
import 'package:phynd_app/presentation/widgets/profile/suggested_quest.dart';
import 'package:phynd_app/presentation/widgets/quest/phynd_badge_quests_section.dart';

class QuestPage extends StatelessWidget {
  const QuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        SizedBox(height: 24),
        // Quests in Progress
        QuestsInProgress(),
        SizedBox(height: 24),
        // Suggested Quests
        SuggestedQuest(
          title: 'Recommended',
          isTrending: true,
        ),
        SuggestedQuest(
          title: 'Top Earning and Rewards',
        ),
        SuggestedQuest(
          title: 'Trending',
          isTrending: true,
        ),
        SuggestedQuest(
          title: 'Play Later List',
          isFeatured: true,
        ),

        // PHYND Badge Quests Section
        PhyndBadgeQuestsSection(),
      ],
    );
  }
}
