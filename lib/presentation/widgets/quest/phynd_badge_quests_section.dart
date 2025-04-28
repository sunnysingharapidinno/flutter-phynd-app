import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/widgets/quest/quest_badge_card.dart';

class PhyndBadgeQuestsSection extends StatelessWidget {
  const PhyndBadgeQuestsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for demonstration
    final badgeQuests = [
      {
        'title': 'Socialite',
        'level': 'Level 1',
        'badgeImageUrl':
            'https://xstrela-dev.s3.amazonaws.com/BADGES/Scholar+Placeholder+Badges/Scholar+Badge+-+Level+1.png',
        'reward': 'Socialite Badge',
        'missions': 2,
        'completedMissions': 1,
        'totalMissions': 2,
      },
      {
        'title': 'Merchant',
        'level': 'Level 1',
        'badgeImageUrl':
            'https://xstrela-dev.s3.amazonaws.com/BADGES/Merchant+Placeholder+Badges/Merchant%20Badge+-+Level+1.png',
        'reward': 'Explorer Badge',
        'missions': 3,
        'completedMissions': 2,
        'totalMissions': 3,
      },
      {
        'title': 'Scholar',
        'level': 'Level 1',
        'badgeImageUrl':
            'https://xstrela-dev.s3.amazonaws.com/BADGES/Socialite+Placeholder+Badges/Socialite+Badge+-+Level+1.png',
        'reward': 'Champion Badge',
        'missions': 4,
        'completedMissions': 4,
        'totalMissions': 4,
      },
      {
        'title': 'Explorer',
        'level': 'Level 1',
        'badgeImageUrl':
            'https://xstrela-dev.s3.amazonaws.com/BADGES/Socialite+Placeholder+Badges/Socialite+Badge+-+Level+1.png',
        'reward': 'Champion Badge',
        'missions': 4,
        'completedMissions': 3,
        'totalMissions': 4,
      },
      {
        'title': 'Disciple',
        'level': 'Level 1',
        'badgeImageUrl':
            'https://xstrela-dev.s3.amazonaws.com/BADGES/Disciple+Placeholder+Badges/Disciple+Badge+-+Level+1.png',
        'reward': 'Champion Badge',
        'missions': 4,
        'completedMissions': 0,
        'totalMissions': 4,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'PHYND Badge Quests',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 340,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: badgeQuests.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final quest = badgeQuests[index];
              return QuestBadgeCard(
                title: quest['title'] as String,
                level: quest['level'] as String,
                badgeImageUrl: quest['badgeImageUrl'] as String,
                reward: quest['reward'] as String,
                missions: quest['missions'] as int,
                completedMissions: quest['completedMissions'] as int,
                totalMissions: quest['totalMissions'] as int,
              );
            },
          ),
        ),
      ],
    );
  }
}
