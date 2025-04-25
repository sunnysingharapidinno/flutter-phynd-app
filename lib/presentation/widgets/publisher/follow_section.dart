import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

class FollowSection extends StatelessWidget {
  final String publisherName;
  final int followersCount;
  final List<String> followerAvatars;
  final VoidCallback onFollowPressed;

  const FollowSection({
    super.key,
    required this.publisherName,
    required this.followersCount,
    required this.followerAvatars,
    required this.onFollowPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final primaryColor = theme?.get('primary') ?? Colors.purple;
    final textColor = theme?.get('text') ?? Colors.black;
    final backgroundColor = theme?.get('background') ?? Colors.white;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Follow button - takes up 50% width
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 56,
            child: ElevatedButton(
              onPressed: onFollowPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Follow',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // Followers info with avatar stack
          Row(
            children: [
              // Avatar stack
              SizedBox(
                width: 200,
                height: 40,
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: _buildAvatarStack(),
                ),
              ),
              const SizedBox(width: 8),
              // Text showing number of friends who follow
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor,
                  ),
                  children: [
                    TextSpan(
                      text: '$followersCount ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    const TextSpan(
                      text: 'Friends Follow ',
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    TextSpan(
                      text: publisherName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAvatarStack() {
    // Display at most 4 avatars in the stack
    final int avatarsToShow =
        followerAvatars.length > 4 ? 4 : followerAvatars.length;

    List<Widget> avatars = [];

    for (int i = 0; i < avatarsToShow; i++) {
      avatars.add(
        Positioned(
          right: i * 20.0, // Each avatar is offset to the left
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(followerAvatars[i]),
            ),
          ),
        ),
      );
    }

    // If there are more followers than we can show, add a +X indicator
    if (followerAvatars.length > avatarsToShow) {
      avatars.add(
        Positioned(
          right: avatarsToShow * 20.0,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              color: Colors.grey.shade300,
            ),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey.shade300,
              child: Text(
                '+${followerAvatars.length - avatarsToShow}',
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return avatars;
  }
}
