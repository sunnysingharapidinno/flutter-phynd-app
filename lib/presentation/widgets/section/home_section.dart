import 'package:flutter/material.dart';

class HomeSection<T> extends StatelessWidget {
  final String heading;
  final List<T> items;
  final Widget Function(BuildContext, T) cardBuilder;

  const HomeSection({
    super.key,
    required this.heading,
    required this.items,
    required this.cardBuilder,
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
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        SizedBox(
          height: 220,
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
