import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: Theme.of(context).extension<AppTheme>()!.get('primary'),
    );
  }
}
