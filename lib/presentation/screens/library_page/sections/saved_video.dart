import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/ui_constants.dart';
import 'package:phynd_app/core/enums/media_type.dart';
import 'package:phynd_app/data/models/response/favorite_content_model.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/cards/video_cards.dart';
import 'package:phynd_app/presentation/widgets/carousel/carousel_row.dart';

class SavedVideoSection extends StatefulWidget {
  const SavedVideoSection({
    Key? key,
  }) : super(key: key);

  @override
  State<SavedVideoSection> createState() => _SavedVideoState();
}

class _SavedVideoState extends State<SavedVideoSection> {
  final GameService _gameService = GameService();
  List<FavoriteContent> _content = [];
  bool _isLoading = true;
  int _currentPage = UIConstants.initialPage;
  bool _hasMoreContent = true;

  @override
  void initState() {
    super.initState();
    _fetchContent();
  }

  Future<void> _fetchContent() async {
    if (_currentPage > 1 && (!_hasMoreContent || _isLoading)) return;

    try {
      setState(() {
        _isLoading = true;
      });

      final result = await _gameService.getSavedContent(
          page: _currentPage,
          limit: UIConstants.defaultPageSize,
          contentType: MediaType.video.value);

      setState(() {
        if (result.data.isEmpty) {
          _hasMoreContent = false;
        } else {
          if (_currentPage == 1) {
            _content = result.data;
          } else {
            _content.addAll(result.data);
          }
          _hasMoreContent = _currentPage < result.totalPage;
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Error fetching content: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CarouselRow(
      cardSpacing: UIConstants.cardSpacing,
      cardsPerView: UIConstants.defaultCardsPerView,
      heading: 'Saved Videos',
      items: _content,
      cardBuilder: (context, content, width, index) {
        return VideoCard(
          thumbnailUrl: content.thumbnailUrl ?? '',
          videoUrl: content.url,
          height: 250,
          timeAgo: content.createdAt.toString(),
          duration: '12:00',
          title: content.title ?? '',
          publisherAvatarUrl: content.companyImage ?? '',
          isVerified: true,
          publisherName: content.companyName ?? '',
          friendsWatchedCount: 10,
        );
      },
      onEndOfScroll: () {
        _currentPage++;
        _fetchContent();
      },
      isLoading: _isLoading,
      isLoadingMore: _isLoading,
    );
  }
}
