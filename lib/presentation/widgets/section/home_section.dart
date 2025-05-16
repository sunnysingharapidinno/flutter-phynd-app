import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';

class HomeSection<T> extends StatefulWidget {
  final String heading;
  final List<T> items;
  final Widget Function(BuildContext, T, double, int) cardBuilder;
  final double cardSpacing;
  final int cardsPerView;
  final double sectionHeight;
  final VoidCallback? onEndOfScroll;
  final bool isLoading;
  final bool isLoadingMore;

  const HomeSection({
    super.key,
    required this.heading,
    required this.items,
    required this.cardBuilder,
    this.cardSpacing = 20,
    this.cardsPerView = 5,
    this.sectionHeight = 550,
    this.onEndOfScroll,
    this.isLoading = false,
    this.isLoadingMore = false,
  });

  @override
  State<HomeSection<T>> createState() => _HomeSectionState<T>();
}

class _HomeSectionState<T> extends State<HomeSection<T>> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  int _lastFetchItemsCount = 0;

  @override
  void initState() {
    super.initState();
    _lastFetchItemsCount = widget.items.length;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoadingMore &&
          widget.onEndOfScroll != null) {
        setState(() {
          _isLoadingMore = true;
        });
        widget.onEndOfScroll!();
      }
    });
  }

  @override
  void didUpdateWidget(covariant HomeSection<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items.length > _lastFetchItemsCount) {
      setState(() {
        _isLoadingMore = false;
        _lastFetchItemsCount = widget.items.length;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text');

    return SizedBox(
      height: SizeUtils.pxToDp(context, widget.sectionHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.heading,
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
                    SizeUtils.pxToDp(context, widget.cardSpacing) *
                        (widget.cardsPerView - 1);
                final itemWidth =
                    (constraints.maxWidth - totalSpacing) / widget.cardsPerView;

                return ListView.separated(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.items.length,
                  separatorBuilder: (_, __) => SizedBox(
                      width: SizeUtils.pxToDp(context, widget.cardSpacing)),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: itemWidth,
                      child: widget.cardBuilder(
                        context,
                        widget.items[index],
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
