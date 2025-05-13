import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';

class HomeSection<T> extends StatelessWidget {
  final String heading;
  final List<T> items;
  final Widget Function(BuildContext, T, double, int) cardBuilder;
  final double cardSpacing;
  final double cardsPerView;
  final double sectionHeight;

  const HomeSection({
    super.key,
    required this.heading,
    required this.items,
    required this.cardBuilder,
    this.cardSpacing = 20,
    this.cardsPerView = 5,
    this.sectionHeight = 550,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text');

    return SizedBox(
      height: SizeUtils.pxToDp(context, sectionHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(
              fontSize: FontUtils.pxToSp(context, 48),
              fontWeight: FontWeight.w600,
              color: textColor,
              fontFamily: 'Exo2',
            ),
          ),
          SizedBox(height: SizeUtils.pxToDp(context, 24)),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final totalSpacing =
                    SizeUtils.pxToDp(context, cardSpacing) * (cardsPerView - 1);
                final itemWidth =
                    (constraints.maxWidth - totalSpacing) / cardsPerView;

                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(width: SizeUtils.pxToDp(context, cardSpacing)),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: itemWidth,
                      child: cardBuilder(
                        context,
                        items[index],
                        itemWidth,
                        index,
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
