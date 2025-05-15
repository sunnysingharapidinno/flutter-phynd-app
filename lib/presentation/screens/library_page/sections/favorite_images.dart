import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/data/models/response/favorite_content_model.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/common/no_data_widget.dart';
import 'package:phynd_app/presentation/widgets/heading/slider_heading.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';
import 'package:phynd_app/presentation/widgets/section/home_section.dart';

class FavoriteImagesSection extends StatefulWidget {
  final GameService? gameService;
  const FavoriteImagesSection({super.key, this.gameService});

  @override
  State<FavoriteImagesSection> createState() => _FavoriteImagesSectionState();
}

class _FavoriteImagesSectionState extends State<FavoriteImagesSection> {
  late final GameService _gameService;
  List<FavoriteContent> _content = [];
  bool _isLoading = true;
  int _currentPage = 1;
  static const int _pageSize = 10;
  bool _hasMoreContent = true;

  @override
  void initState() {
    super.initState();
    _gameService = widget.gameService ?? GameService();
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
        contentType: 'IMAGE',
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
              SliderHeading('Favorited Images'),
              SizedBox(height: 16),
              NoDataWidget(
                title: 'No Favorited Images',
                subtitle: 'You haven\'t favorited any images yet',
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
              heading: 'Favorited Images',
              items: _content,
              cardBuilder: (context, content, width, index) {
                return ImageThumbnail(
                  imageUrl: content.url,
                  height: 200,
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
