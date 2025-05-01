import 'package:flutter/material.dart';
import 'package:phynd_app/data/models/response/quest_model.dart';

class QuestHeader extends StatelessWidget {
  final QuestModel questData;
  final VoidCallback? onJoinPressed;

  const QuestHeader({
    super.key,
    required this.questData,
    this.onJoinPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top row with timer and badges
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Timer pill
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black54,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'ENDS IN ${questData.timeLeft ?? '153D 18H 47M 01S'}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Live badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'LIVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Featured Quest badge
            ],
          ),
        ),

        // Quest Image and Info in a Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quest Image
            Container(
              height: 250,
              width: 450,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(questData.image),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  color: Colors.purple,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            ),

            const SizedBox(
                width: 16), // Added gap between image and info section

            // Quest Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (questData.isFeatured)
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.purple.withOpacity(0.3),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.hexagon_outlined,
                                    color: Colors.purple,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 6),
                              ],
                            ),
                          ),
                          const Text(
                            'Featured Quest',
                            style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            questData.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      questData.description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Stats row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStat((questData.participants ?? 0).toString(),
                            'Participants'),
                        _buildDivider(),
                        _buildStat((questData.completed == true ? 'Yes' : 'No'),
                            'Completed'),
                        _buildDivider(),
                        _buildStat((questData.totalMissions ?? 0).toString(),
                            'Missions'),
                        _buildDivider(),
                        _buildStat(
                            (questData.phyndCoins ?? 0).toString(), 'Rewards'),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 24,
      width: 1,
      color: Colors.white24,
      margin: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
