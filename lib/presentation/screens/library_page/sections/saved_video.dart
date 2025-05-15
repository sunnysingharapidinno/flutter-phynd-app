import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/data/models/response/favorite_content_model.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/cards/video_cards.dart';
import 'package:phynd_app/presentation/widgets/common/no_data_widget.dart';
import 'package:phynd_app/presentation/widgets/heading/slider_heading.dart';
import 'package:phynd_app/presentation/widgets/section/home_section.dart';

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
  int _currentPage = 1;
  static const int _pageSize = 10;
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
          page: _currentPage, limit: _pageSize, contentType: 'VIDEO');

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
    return Column(
      children: [
        if (_isLoading)
          const Text('Loading...')
        else if (_content.isEmpty)
          const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SliderHeading('Saved Videos'),
              SizedBox(height: 16),
              NoDataWidget(
                title: 'No Saved Videos',
                subtitle: 'You haven\'t saved any videos yet',
                icon: Icons.bookmark_border,
              ),
            ],
          )
        else
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.pxToDp(context, 56),
              vertical: SizeUtils.pxToDp(context, 0),
            ),
            child: HomeSection(
              cardSpacing: 20,
              cardsPerView: 4,
              heading: 'Saved Videos',
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
                _fetchContent();
                _currentPage++;
              },
            ),
          ),
        const SizedBox(height: 32),
      ],
    );
  }
}
