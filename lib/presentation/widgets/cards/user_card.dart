import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

class UserCard extends StatelessWidget {
  final String avatarUrl;
  final String username;
  final String? status;
  final bool isOnline;
  final VoidCallback? onTap;

  const UserCard({
    Key? key,
    required this.avatarUrl,
    required this.username,
    this.status,
    this.isOnline = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 130,
        decoration: BoxDecoration(
          color: theme.get('cardBg'),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.get('borderColor')),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.get('borderColor'),
                      width: 2,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(avatarUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: theme.get('trialPrice'),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.get('cardBg'),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              username,
              style: TextStyle(
                color: theme.get('text'),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (status != null) ...[
              const SizedBox(height: 4),
              Text(
                status!,
                style: TextStyle(
                  color: theme.get('textSecondary'),
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
