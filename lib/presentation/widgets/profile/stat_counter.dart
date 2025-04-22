import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

class StatCounter extends StatelessWidget {
  final String label;
  final String value;

  const StatCounter({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text') ?? Colors.black;

    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: textColor.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}
