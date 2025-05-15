import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/data/models/response/favorite_content_model.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/common/no_data_widget.dart';
import 'package:phynd_app/presentation/widgets/heading/slider_heading.dart';
import 'package:phynd_app/presentation/widgets/publisher/events_offers_section.dart';
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

      final result = await _gameService.getSavedContent(
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
              SliderHeading('Saved Events and Offers'),
              SizedBox(height: 16),
              NoDataWidget(
                title: 'No Saved Events',
                subtitle: 'You haven\'t saved any events yet',
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
              cardsPerView: 2,
              heading: 'Saved Events and Offers',
              items: _content,
              sectionHeight: 600,
              cardBuilder: (context, content, width, index) {
                return EventOfferCard(
                  imageUrl: content.url,
                  title: 'Test Event',
                  friendsCount: 10,
                  friendAvatars: [],
                  actionText: 'Save',
                  isEvent: true,
                  primaryColor: Colors.blue,
                  textColor: Colors.white,
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
