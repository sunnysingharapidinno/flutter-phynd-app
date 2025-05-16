import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/ui_constants.dart';
import 'package:phynd_app/core/enums/media_type.dart';
import 'package:phynd_app/data/models/response/favorite_content_model.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/cards/event_offer_card.dart';
import 'package:phynd_app/presentation/widgets/section/home_section.dart';

class SavedEventsSection extends StatefulWidget {
  final GameService? gameService;
  const SavedEventsSection({super.key, this.gameService});

  @override
  State<SavedEventsSection> createState() => _SavedEventsSectionState();
}

class _SavedEventsSectionState extends State<SavedEventsSection> {
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
        contentType: MediaType.image.value,
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
      cardsPerView: 2,
      heading: 'Saved Events and Offers',
      items: _content,
      sectionHeight: 700,
      cardBuilder: (context, content, width, index) {
        return EventOfferCard(
          backgroundImageUrl: content.url,
          publisherLogoUrl:
              "https://xstrela-alpha.s3.us-east-1.amazonaws.com/images/temp/DP_IMAGE_URL/PNG/8005f2f1-6d23-4521-84d4-91f16ac200ca",
          gameTitle: "Valorant",
          isVerified: true,
          friendsSavedCount: 86,
          width: double.infinity,
          height: 400,
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
