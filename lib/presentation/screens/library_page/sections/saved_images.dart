import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/ui_constants.dart';
import 'package:phynd_app/core/enums/media_type.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/carousel/carousel_row.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';

class SavedImagesSection extends StatefulWidget {
  final GameService? gameService;
  const SavedImagesSection({super.key, this.gameService});

  @override
  State<SavedImagesSection> createState() => _SavedImagesSectionState();
}

class _SavedImagesSectionState extends State<SavedImagesSection> {
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
      cardsPerView: UIConstants.defaultCardsPerView,
      heading: 'Saved Images',
      handleApiCall: (page) {
        return _gameService.getSavedContent(
          page: page,
          limit: UIConstants.defaultPageSize,
          contentType: MediaType.image.value,
        );
      },
      cardBuilder: (context, content, width, index) {
        return ImageThumbnail(
          imageUrl: content.url,
          height: 207,
          width: 369,
        );
      },
    );
  }
}
