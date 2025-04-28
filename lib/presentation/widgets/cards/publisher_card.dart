import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

class PublisherCard extends StatelessWidget {
  final String? logoUrl;
  final String name;
  final VoidCallback? onTap;

  const PublisherCard({
    Key? key,
    this.logoUrl,
    required this.name,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: theme.get('cardBg'),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.get('borderColor')),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.get('surface'),
              ),
              child: logoUrl != null && logoUrl!.isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        logoUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.business,
                          size: 32,
                          color: theme.get('text'),
                        ),
                      ),
                    )
                  : Icon(
                      Icons.business,
                      size: 32,
                      color: theme.get('text'),
                    ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                color: theme.get('text'),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
