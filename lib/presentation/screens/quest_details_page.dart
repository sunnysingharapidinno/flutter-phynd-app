import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/widgets/quest/quest_header.dart';
import 'package:phynd_app/presentation/widgets/quest/quest_creator_section.dart';
import 'package:phynd_app/presentation/widgets/quest/quest_rewards_section.dart';
import 'package:phynd_app/presentation/widgets/quest/quest_missions_section.dart';

class QuestDetailsPage extends StatelessWidget {
  final Map<String, dynamic>? questData;

  const QuestDetailsPage({
    super.key,
    this.questData,
  });

  @override
  Widget build(BuildContext context) {
    // Sample quest data if not provided
    final quest = questData ??
        {
          'name': 'The Chatty Explorer',
          'description': 'Follow more users and join the conversation',
          'image':
              'https://xstrela-alpha.s3.us-east-1.amazonaws.com/general/2025/03/12/0724cd4ae01c4754a70fa91a0a574e13.png',
          'timeLeft': '153D 18H 47M 01S',
          'totalMissions': 2,
          'completedMissions': 0,
          'participants': 0,
          'completed': 0,
          'rewards': 0,
          'activeParticipants': 0,
          'creator': 'PHYND',
          'missions': {
            'required': [
              {
                'title': 'User Accepted Chat Request',
                'count': '0/2',
                'isCompleted': false,
              },
              {
                'title': 'User Sent Chat Message',
                'count': '0/10',
                'isCompleted': false,
              },
            ],
            'optional': [
              {
                'title': 'Follow user',
                'count': '',
                'isCompleted': false,
              },
            ],
          },
        };

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.more_horiz, color: Colors.white),
                ),
                onPressed: () {},
              ),
            ],
          ),

          // Quest Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  QuestHeader(
                    questData: quest,
                  ),
                  QuestCreatorSection(
                    questData: quest,
                  ),
                  QuestRewardsSection(
                    questData: quest,
                  ),
                  QuestMissionsSection(
                    questData: quest,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
