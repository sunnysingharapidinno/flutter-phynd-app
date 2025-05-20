import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/data/models/response/pagination_model.dart';
import 'package:shimmer/shimmer.dart';

class CarouselRow<T> extends StatefulWidget {
  final String heading;
  final Widget Function(BuildContext, T, double, int) cardBuilder;
  final double cardSpacing;
  final int cardsPerView;
  final double sectionHeight;
  final Future<Paginated<T>> Function(int page)? handleApiCall;
  final List<T> items;
  final bool isLoading;
  final bool isLoadingMore;
  final VoidCallback? onEndOfScroll;

  const CarouselRow({
    super.key,
    required this.heading,
    required this.cardBuilder,
    this.cardSpacing = 20,
    this.cardsPerView = 5,
    this.sectionHeight = 550,
    this.handleApiCall,
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.onEndOfScroll,
  });

  @override
  State<CarouselRow<T>> createState() => _CarouselRowState<T>();
}

class _CarouselRowState<T> extends State<CarouselRow<T>> {
  final ScrollController _scrollController = ScrollController();

  List<T> _items = [];
  bool _isInitialLoading = true;
  bool _isLoadingMore = false;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        widget.handleApiCall != null) {
      _loadMore();
    }
  }

  Future<void> _fetchInitialData() async {
    if (widget.handleApiCall != null) {
      setState(() => _isInitialLoading = true);
      final result = await widget.handleApiCall!(1);
      setState(() {
        _items = result.data;
        _currentPage = 1;
        _isInitialLoading = false;
      });
    }
  }

  Future<void> _loadMore() async {
    if (widget.handleApiCall == null) return;
    setState(() => _isLoadingMore = true);

    final result = await widget.handleApiCall!(_currentPage + 1);
    if (result.data.isNotEmpty) {
      setState(() {
        _items.addAll(result.data);
        _currentPage++;
      });
    }
    setState(() => _isLoadingMore = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text');

    // Hide section if no data and not loading
    if (!_isInitialLoading && _items.isEmpty) return const SizedBox.shrink();

    final sectionHeight = SizeUtils.pxToDp(context, widget.sectionHeight);
    final cardSpacing = SizeUtils.pxToDp(context, widget.cardSpacing);
    final cardCount = _isInitialLoading ? widget.cardsPerView : _items.length;

    return SizedBox(
      height: sectionHeight,
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
                final totalSpacing = cardSpacing * (widget.cardsPerView - 1);
                final itemWidth =
                    (constraints.maxWidth - totalSpacing) / widget.cardsPerView;

                return ListView.separated(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      cardCount + (_isLoadingMore ? widget.cardsPerView : 0),
                  separatorBuilder: (_, __) => SizedBox(width: cardSpacing),
                  itemBuilder: (context, index) {
                    final isSkeleton = _isInitialLoading ||
                        (_isLoadingMore && index >= _items.length);

                    return SizedBox(
                      width: itemWidth,
                      child: isSkeleton
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                margin: const EdgeInsets.all(4),
                              ),
                            )
                          : widget.cardBuilder(
                              context, _items[index], itemWidth, index),
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
