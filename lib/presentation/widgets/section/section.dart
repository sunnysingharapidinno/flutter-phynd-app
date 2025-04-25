import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/styles/app_typography.dart';

class Section extends StatelessWidget {
  final String title;
  final Widget child;
  final bool showViewAll;
  final VoidCallback? onViewAll;

  const Section({
    Key? key,
    required this.title,
    required this.child,
    this.showViewAll = false,
    this.onViewAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppTypography.heading5(
                  title,
                  context: context,
                ),
              ),
              if (showViewAll)
                TextButton(
                  onPressed: onViewAll,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View All',
                        style: TextStyle(
                          color: theme.get('primary'),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: theme.get('primary'),
                        size: 16,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        child,
      ],
    );
  }
}
