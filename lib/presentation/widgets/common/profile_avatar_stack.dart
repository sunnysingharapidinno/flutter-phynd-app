import 'package:flutter/material.dart';

class ProfileAvatarStack extends StatelessWidget {
  final List<String> avatarUrls;
  final double avatarSize;
  final double overlap;

  const ProfileAvatarStack({
    Key? key,
    required this.avatarUrls,
    this.avatarSize = 36.0,
    this.overlap = 0.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (avatarUrls.isEmpty) {
      return const SizedBox();
    }

    return SizedBox(
      height: avatarSize,
      width: avatarUrls.length > 1
          ? avatarSize + (avatarUrls.length - 1) * (avatarSize * (1 - overlap))
          : avatarSize,
      child: Stack(
        children: [
          for (int i = 0; i < avatarUrls.length; i++)
            Positioned(
              left: i * (avatarSize * (1 - overlap)),
              child: Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1.5),
                  image: DecorationImage(
                    image: NetworkImage(avatarUrls[i]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
