import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/screens/quest_details_page.dart';

class QuestInProgressCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String gameName;
  final int completedMissions;
  final int totalMissions;
  final Color cardColor;
  final bool showProgressBar;
  final VoidCallback? onTap;
  final Map<String, dynamic>? questData;

  const QuestInProgressCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.gameName,
    required this.completedMissions,
    required this.totalMissions,
    this.cardColor = Colors.amber,
    this.showProgressBar = false,
    this.onTap,
    this.questData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            // Create quest data map if not provided
            final quest = questData ??
                {
                  'name': title,
                  'description': 'Complete missions in $gameName',
                  'image': imageUrl,
                  'timeLeft': '153D 18H 47M 01S',
                  'totalMissions': totalMissions,
                  'completedMissions': completedMissions,
                  'participants': 0,
                  'completed': 0,
                  'rewards': 0,
                };

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuestDetailsPage(questData: quest),
              ),
            );
          },
      child: Container(
        width: 250,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black,
        ),
        clipBehavior: Clip.hardEdge,
        child: AspectRatio(
          aspectRatio: 3 / 4,
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),

              // Color overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timer
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.timer_outlined,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '153D 18H 47M 01S',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // Quest Title
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Game name
                    Row(
                      children: [
                        const Text(
                          'Game: ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          gameName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Progress bar (conditionally shown)
                    if (showProgressBar) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: totalMissions > 0
                              ? completedMissions / totalMissions
                              : 0,
                          minHeight: 12,
                          backgroundColor: Colors.white.withOpacity(0.15),
                          valueColor: AlwaysStoppedAnimation<Color>(cardColor),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$completedMissions/$totalMissions missions completed',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
