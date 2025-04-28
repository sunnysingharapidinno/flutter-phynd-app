import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

class HomeSection<T> extends StatelessWidget {
  final String heading;
  final List<T> items;
  final Widget Function(BuildContext, T) cardBuilder;
  final double height; // height for the horizontal list

  const HomeSection({
    super.key,
    required this.heading,
    required this.items,
    required this.cardBuilder,
    this.height = 220, // default height
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            heading,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).extension<AppTheme>()!.get('text'),
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
          ),
        ),
        SizedBox(
          height: height,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) => cardBuilder(context, items[index]),
          ),
        ),
      ],
    );
  }
}
