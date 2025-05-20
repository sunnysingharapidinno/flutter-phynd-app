import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/ui_constants.dart';
import 'package:phynd_app/core/enums/media_type.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/cards/event_offer_card.dart';
import 'package:phynd_app/presentation/widgets/carousel/carousel_row.dart';

class SavedEventsSection extends StatefulWidget {
  final GameService? gameService;
  const SavedEventsSection({super.key, this.gameService});

  @override
  State<SavedEventsSection> createState() => _SavedEventsSectionState();
}

class _SavedEventsSectionState extends State<SavedEventsSection> {
  late final GameService _gameService;
  int _refreshTrigger = 0;

  @override
  void initState() {
    super.initState();
    _gameService = widget.gameService ?? GameService();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselRow(
      key: ValueKey(_refreshTrigger),
      cardSpacing: UIConstants.cardSpacing,
      cardsPerView: 2,
      heading: 'Saved Events and Offers',
      sectionHeight: 700,
      handleApiCall: (page) {
        return _gameService.getSavedEvents(
          page: page,
          limit: UIConstants.defaultPageSize,
        );
      },
      cardBuilder: (context, content, width, index) {
        return EventOfferCard(
          backgroundImageUrl: content.imageUrl,
          publisherLogoUrl: content.dpUrl ?? "",
          gameTitle: content.title,
          isVerified: content.isVerified ?? false,
          friendsSavedCount: content.friendsSaved,
          width: double.infinity,
          height: 400,
          isSaved: true,
          onSavePressed: () async {
            content.type == 'Offer'
                ? await _gameService.removeSavedOffer(offerId: content.eventId)
                : await _gameService.removeSavedEvent(eventId: content.eventId);
            if (mounted) {
              setState(() {
                _refreshTrigger++;
              });
            }
          },
        );
      },
    );
  }
}
