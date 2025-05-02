import 'package:flutter/material.dart';
import 'package:phynd_app/data/models/response/quest_model.dart';

class QuestRewardsSection extends StatelessWidget {
  final QuestModel questData;

  const QuestRewardsSection({
    super.key,
    required this.questData,
  });

  @override
  Widget build(BuildContext context) {
    // Sample rewards data - in production, this would come from questData
    final List<Map<String, dynamic>> rewards = [
      {
        'type': 'physical',
        'title': 'Physical Rewards',
        'image':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/general/2025/02/25/a983065aa4ea45cd914674110c3ab905.png',
      },
      {
        'type': 'coins',
        'title': '${questData.phyndCoins} PHYND Coins',
        'image': 'https://xstrela-alpha.s3.amazonaws.com/images/PhyndCoin.png',
      },
      {
        'type': 'bonus',
        'title': '${questData.phyndCoinsBonus} PHYND Coins bonus',
        'image': 'https://xstrela-alpha.s3.amazonaws.com/images/PhyndCoin.png'
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Rewards',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '0/3 Completed',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Rewards Grid
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 24,
              children: rewards.map((reward) {
                return Column(
                  children: [
                    // Image Box
                    Container(
                      width: 275,
                      height: 275,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1B1E),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: Colors.grey.shade800,
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          reward['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Title below box
                    const SizedBox(height: 12),
                    Text(
                      reward['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
