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

  @override
  void initState() {
    super.initState();
    _gameService = widget.gameService ?? GameService();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselRow(
      cardSpacing: UIConstants.cardSpacing,
      cardsPerView: 2,
      heading: 'Saved Events and Offers',
      sectionHeight: 700,
      handleApiCall: (page) {
        return _gameService.getSavedContent(
          page: page,
          limit: UIConstants.defaultPageSize,
          contentType: MediaType.image.value,
        );
      },
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
    );
  }
}
