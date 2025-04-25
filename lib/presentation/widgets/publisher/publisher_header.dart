import 'package:flutter/material.dart';

class PublisherHeader extends StatelessWidget {
  final String name;
  final String profileImageUrl;
  final String bannerImageUrl;
  final bool isVerified;
  final Map<String, int> stats;

  const PublisherHeader({
    super.key,
    required this.name,
    required this.profileImageUrl,
    required this.bannerImageUrl,
    this.isVerified = false,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen height to set banner height to 80% of viewport
    final screenHeight = MediaQuery.of(context).size.height;
    final bannerHeight = screenHeight * 0.8;

    return Container(
      height: bannerHeight,
      width: double.infinity,
      child: Stack(
        children: [
          // Banner image with gradient overlay
          Container(
            height: bannerHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(bannerImageUrl),
                fit: BoxFit.cover,
              ),
            ),
            // Gradient overlay from bottom to middle
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.9),
                ],
                stops: const [0.0, 0.5, 0.75, 1.0],
              ),
            ),
          ),

          // Dot indicators - positioned in banner
          Positioned(
            top: 85,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 5; i++)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i == 1 ? const Color(0xFF4CD964) : Colors.white,
                    ),
                  ),
              ],
            ),
          ),

          // "me to U" text on top left
          Positioned(
            left: 35,
            top: 30,
            child: const Text(
              "me to U",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Profile picture with publisher name and verification badge
          Positioned(
            left: 30,
            top: bannerHeight * 0.45, // Position at about 45% from the top
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile image
                Container(
                  width: 120,
                  height: 120,
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      profileImageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Publisher name with verification badge
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFFA2E0E0), Color(0xFF6CACDF)],
                            ).createShader(bounds);
                          },
                          child: Text(
                            name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize:
                                  64, // Slightly smaller to fit with profile pic
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              height: 1.0,
                            ),
                          ),
                        ),
                        if (isVerified)
                          Container(
                            margin: const EdgeInsets.only(left: 12),
                            width: 45,
                            height: 45,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF9C5BBF),
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Stats row at the bottom of the banner
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 100,
              width: double.infinity,
              color:
                  Colors.black.withOpacity(0.3), // Semi-transparent background
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _buildStatsItems(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildStatsItems() {
    List<Widget> items = [];

    final statsList = [
      {'key': 'Followers', 'value': stats['followers'] ?? 0},
      {'key': 'Games', 'value': stats['games'] ?? 0},
      {'key': 'Clans', 'value': stats['clans'] ?? 0},
      {'key': 'Trials', 'value': stats['trials'] ?? 0},
      {'key': 'Drops', 'value': stats['drops'] ?? 0},
      {'key': 'Upcoming Events', 'value': stats['upcomingEvents'] ?? 0},
      {'key': 'Quests', 'value': stats['quests'] ?? 0},
    ];

    for (int i = 0; i < statsList.length; i++) {
      // Add divider before all items except the first one
      if (i > 0) {
        items.add(
          Container(
            width: 1,
            height: 50,
            color: const Color(0xFF5A4EBB),
          ),
        );
      }

      // Add the stat item
      items.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                statsList[i]['value'].toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                statsList[i]['key'].toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return items;
  }
}
