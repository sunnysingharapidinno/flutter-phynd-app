import 'package:flutter/material.dart';

class QuestInProgressCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String gameName;
  final int completedMissions;
  final int totalMissions;
  final Color cardColor;
  final bool showProgressBar;

  const QuestInProgressCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.gameName,
    required this.completedMissions,
    required this.totalMissions,
    this.cardColor = Colors.amber,
    this.showProgressBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black,
      ),
      clipBehavior: Clip.hardEdge,
      child: AspectRatio(
        aspectRatio: 3 / 4, // 4:3 aspect ratio (vertical)
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '00d 00h 00m 00s',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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
                    LinearProgressIndicator(
                      value: completedMissions / totalMissions,
                      backgroundColor: Colors.grey.withOpacity(0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 8.0, // Increased height from default 4.0
                    ),

                    const SizedBox(height: 8),

                    // Missions completed text
                    Text(
                      'Missions Completed $completedMissions/$totalMissions',
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
    );
  }
}
