import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/ui_constants.dart';
import 'package:phynd_app/core/enums/media_type.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/carousel/carousel_row.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';

class FavoriteImagesSection extends StatefulWidget {
  final GameService? gameService;
  const FavoriteImagesSection({super.key, this.gameService});

  @override
  State<FavoriteImagesSection> createState() => _FavoriteImagesSectionState();
}

class _FavoriteImagesSectionState extends State<FavoriteImagesSection> {
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
      heading: 'Favorited Images',
      handleApiCall: (page) {
        return _gameService.getFavoriteContent(
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
