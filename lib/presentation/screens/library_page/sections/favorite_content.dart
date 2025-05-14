import 'package:flutter/material.dart';
import 'package:phynd_app/core/enums/media_type.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/data/models/response/favorite_content_model.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/cards/clip_card/game_clip_card.dart';
import 'package:phynd_app/presentation/widgets/common/no_data_widget.dart';
import 'package:phynd_app/presentation/widgets/heading/slider_heading.dart';
import 'package:phynd_app/presentation/widgets/section/home_section.dart';

class FavoriteContentSection extends StatefulWidget {
  const FavoriteContentSection({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteContentSection> createState() => _FavoriteContentState();
}

class _FavoriteContentState extends State<FavoriteContentSection> {
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

      final result = await _gameService.getFavoriteContent(
        page: _currentPage,
        limit: _pageSize,
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
    return Column(
      children: [
        if (_isLoading)
          const Text('Loading...')
        else if (_content.isEmpty)
          const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SliderHeading('Favorited Content'),
              SizedBox(height: 16),
              NoDataWidget(
                title: 'No Favorited Content',
                subtitle: 'You haven\'t favorited any content yet',
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
              heading: 'Favorited Content',
              items: _content,
              cardBuilder: (context, content, width, index) {
                return GameClipCard(
                  thumbnailUrl: content.url,
                  videoUrl:
                      content.mediaType == MediaType.video ? content.url : '',
                  title: content.title ?? '',
                  rating: 0.0,
                  maxRating: 5,
                  esrbRatingImageUrl: '',
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
