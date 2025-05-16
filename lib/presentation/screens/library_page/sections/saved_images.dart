import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/ui_constants.dart';
import 'package:phynd_app/core/enums/media_type.dart';
import 'package:phynd_app/data/models/response/favorite_content_model.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';
import 'package:phynd_app/presentation/widgets/section/home_section.dart';

class SavedImagesSection extends StatefulWidget {
  final GameService? gameService;
  const SavedImagesSection({super.key, this.gameService});

  @override
  State<SavedImagesSection> createState() => _SavedImagesSectionState();
}

class _SavedImagesSectionState extends State<SavedImagesSection> {
  late final GameService _gameService;
  List<FavoriteContent> _content = [];
  bool _isLoading = true;
  int _currentPage = UIConstants.initialPage;
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

      final result = await _gameService.getSavedContent(
          page: _currentPage,
          limit: UIConstants.defaultPageSize,
          contentType: MediaType.image.value);

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
      heading: 'Saved Images',
      items: _content,
      cardBuilder: (context, content, width, index) {
        return ImageThumbnail(
          imageUrl: content.url,
          height: 200,
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
