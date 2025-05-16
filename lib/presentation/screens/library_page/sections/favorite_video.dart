import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/ui_constants.dart';
import 'package:phynd_app/core/enums/media_type.dart';
import 'package:phynd_app/data/models/response/favorite_content_model.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/cards/video_cards.dart';
import 'package:phynd_app/presentation/widgets/section/home_section.dart';

class FavoriteVideoSection extends StatefulWidget {
  const FavoriteVideoSection({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteVideoSection> createState() => _FavoriteVideoState();
}

class _FavoriteVideoState extends State<FavoriteVideoSection> {
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

      final result = await _gameService.getFavoriteContent(
        page: _currentPage,
        limit: UIConstants.defaultPageSize,
        contentType: MediaType.video.value,
      );

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
    return HomeSection(
      cardSpacing: UIConstants.cardSpacing,
      cardsPerView: UIConstants.defaultCardsPerView,
      heading: 'Favorited Videos',
      items: _content,
      cardBuilder: (context, content, width, index) {
        return VideoCard(
          thumbnailUrl:
              'https://xstrela-dev.s3.us-east-1.amazonaws.com/general/22_05_2024/65ecb31b797e4e1aba1ff46fd30eeb3b.png',
          videoUrl: content.url,
          height: 250,
          timeAgo: content.createdAt.toString(),
          duration: '12:00',
          title: content.title ?? '',
          publisherAvatarUrl:
              'https://xstrela-alpha.s3.us-east-1.amazonaws.com/images/temp/DP_IMAGE_URL/PNG/8005f2f1-6d23-4521-84d4-91f16ac200ca',
          isVerified: true,
          publisherName: 'NetEase Studios',
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
