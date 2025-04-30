import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';

class ProfileHeader extends StatelessWidget {
  final String username;
  final bool isOnline;
  final String avatar;
  final String bannerImage;
  final String? currentlyPlaying;

  const ProfileHeader({
    super.key,
    required this.username,
    required this.isOnline,
    required this.avatar,
    required this.bannerImage,
    this.currentlyPlaying,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final primaryColor = theme?.get('primary') ?? Colors.blue;
    final textColor = theme?.get('text') ?? Colors.black;

    print('avatar: $avatar');

    return Container(
      width: double.infinity,
      height: 240,
      child: Stack(
        children: [
          // Banner image
          Positioned.fill(
            child: bannerImage.startsWith('http') ||
                    bannerImage.startsWith('https')
                ? Image.network(
                    bannerImage,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    bannerImage,
                    fit: BoxFit.cover,
                  ),
          ),

          // Dark gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3), // Subtle darkness at top
                    Colors.black.withOpacity(0.6), // Medium darkness in middle
                    Colors.black
                        .withOpacity(0.8), // Stronger darkness at bottom
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // Horizontal gradient for better text readability
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black
                        .withOpacity(0.6), // Darker on the left where text is
                    Colors.black.withOpacity(0.3), // Lighter in the middle
                    Colors.black.withOpacity(0.6), // Darker on the right
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // Profile info container positioned at the bottom
          Positioned(
            left: 16,
            bottom: 0,
            right: 16,
            top: 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Hexagonal avatar
                      _buildHexagonAvatar(avatar, primaryColor),

                      const SizedBox(width: 12),

                      // Username, online status and currently playing
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Text(
                                  username,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color:
                                        isOnline ? Colors.green : Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  isOnline ? 'Online' : 'Offline',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  '•',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  '34 Mutual Friends',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            if (currentlyPlaying != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Currently Playing: ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextSpan(
                                        text: currentlyPlaying!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Follow and Message buttons
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RemoteControlWrapper(
                            child: _buildButton(
                              icon: Icons.person_add,
                              label: 'Follow',
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 12),
                          RemoteControlWrapper(
                            child: _buildButton(
                              icon: Icons.message,
                              label: 'Message',
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHexagonAvatar(String avatarUrl, Color primaryColor) {
    return Container(
      width: 140,
      height: 150,
      child: ClipPath(
        clipper: HexagonClipper(),
        child: Container(
          padding: const EdgeInsets.all(3),
          color: Colors.white,
          child: ClipPath(
            clipper: HexagonClipper(),
            child: avatarUrl.startsWith('http') || avatarUrl.startsWith('https')
                ? Image.network(
                    avatarUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: primaryColor,
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Image.asset(
                    avatarUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: primaryColor,
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade800,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.white, width: 1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }
}

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double width = size.width;
    final double height = size.height;

    path.moveTo(width / 2, 0);
    path.lineTo(width, height / 4);
    path.lineTo(width, height * 3 / 4);
    path.lineTo(width / 2, height);
    path.lineTo(0, height * 3 / 4);
    path.lineTo(0, height / 4);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
