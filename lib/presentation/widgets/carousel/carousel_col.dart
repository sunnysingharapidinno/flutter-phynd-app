import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/data/models/response/pagination_model.dart';
import 'package:shimmer/shimmer.dart';

class CarouselCol<T, A> extends StatefulWidget {
  final String? heading;
  final Widget Function(BuildContext, T, double, int) cardBuilder;
  final double cardSpacing;
  final int cardsPerView;
  final double sectionHeight;
  final Future<Paginated<T>> Function(int page, A args)? handleApiCall;
  final A? extraArgs;

  const CarouselCol({
    super.key,
    this.heading,
    required this.cardBuilder,
    this.cardSpacing = 20,
    this.cardsPerView = 5,
    this.sectionHeight = 550,
    this.handleApiCall,
    this.extraArgs,
  });

  @override
  State<CarouselCol<T, A>> createState() => CarouselColState<T, A>();
}

class CarouselColState<T, A> extends State<CarouselCol<T, A>> {
  final ScrollController _scrollController = ScrollController();
  final List<T> _items = [];

  int _currentPage = 1;
  bool _isInitialLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchInitialData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchInitialData() async {
    if (widget.handleApiCall == null || widget.extraArgs == null) return;

    setState(() => _isInitialLoading = true);
    final result = await widget.handleApiCall!(1, widget.extraArgs as A);

    setState(() {
      _items.clear();
      _items.addAll(result.data);
      _currentPage = 1;
      _isInitialLoading = false;
      _hasMore = result.count > result.data.length;
    });
  }

  Future<void> _loadMore() async {
    if (!_hasMore ||
        _isLoadingMore ||
        widget.handleApiCall == null ||
        widget.extraArgs == null) return;

    setState(() => _isLoadingMore = true);
    final result =
        await widget.handleApiCall!(_currentPage + 1, widget.extraArgs as A);

    setState(() {
      _items.addAll(result.data);
      _currentPage++;
      _hasMore = result.count > _items.length;
      _isLoadingMore = false;
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        _hasMore &&
        !_isLoadingMore &&
        widget.handleApiCall != null &&
        widget.extraArgs != null) {
      _loadMore();
    }
  }

  Future<void> refetch() async {
    _currentPage = 1;
    _hasMore = true;
    _items.clear();
    await _fetchInitialData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text');

    final sectionHeight = SizeUtils.pxToDp(context, widget.sectionHeight);
    final cardSpacing = SizeUtils.pxToDp(context, widget.cardSpacing);
    final itemCount = _isInitialLoading
        ? widget.cardsPerView
        : _items.length + (_isLoadingMore ? widget.cardsPerView : 0);

    if (!_isInitialLoading && _items.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: sectionHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.heading != null) ...[
            Text(
              widget.heading!,
              style: TextStyle(
                fontSize: FontUtils.pxToSp(context, 48),
                fontWeight: FontWeight.w600,
                fontFamily: 'Exo2',
                color: textColor,
              ),
            ),
            SizedBox(height: SizeUtils.pxToDp(context, 24)),
          ],
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final itemHeight = (constraints.maxHeight -
                        (cardSpacing * (widget.cardsPerView - 1))) /
                    widget.cardsPerView;

                return ListView.separated(
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  itemCount: itemCount,
                  separatorBuilder: (_, __) => SizedBox(height: cardSpacing),
                  itemBuilder: (context, index) {
                    final isSkeleton = _isInitialLoading ||
                        (_isLoadingMore && index >= _items.length);

                    return isSkeleton
                        ? SizedBox(
                            height: itemHeight,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ))
                        : widget.cardBuilder(
                            context, _items[index], itemHeight, index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
