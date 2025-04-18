import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String? email;
  final String? imageUrl;
  final IconData? icon;
  final List<Map<String, dynamic>> stats;

  const ProfileHeader({
    super.key,
    required this.name,
    this.email,
    this.imageUrl,
    this.icon = Icons.person,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final primaryColor = theme?.get('primary') ?? Colors.blue;
    final textColor = theme?.get('text') ?? Colors.black;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (imageUrl != null)
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(imageUrl!),
                  )
                else
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: primaryColor,
                    child: Icon(
                      icon,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      if (email != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          email!,
                          style: TextStyle(
                            fontSize: 16,
                            color: textColor.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: stats.map((stat) {
                return Column(
                  children: [
                    Text(
                      stat['value'].toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      stat['label'],
                      style: TextStyle(
                        fontSize: 14,
                        color: textColor.withOpacity(0.7),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
