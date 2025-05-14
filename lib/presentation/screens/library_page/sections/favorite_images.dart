import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/cards/video_cards.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';
import 'package:phynd_app/presentation/widgets/section/home_section.dart';

class FavoriteImagesSection extends StatefulWidget {
  const FavoriteImagesSection({super.key});

  @override
  State<FavoriteImagesSection> createState() => FavoriteImagesSectionState();
}

class FavoriteImagesSectionState extends State<FavoriteImagesSection> {
  @override
  Widget build(BuildContext context) {
    final games = [
      {
        'number': 1,
        'name': 'Grit',
        'image': 'https://xstrela-alpha.s3.amazonaws.com/images/Grit.png',
      },
      {
        'number': 2,
        'name': 'Brawl Stars',
        'image':
            'https://xstrela-alpha.s3.amazonaws.com/images/BrawlStars.jpeg',
      },
      {
        'number': 3,
        'name': 'Fortnite',
        'image':
            'https://xstrela-alpha.s3.amazonaws.com/images/fortniteHeros.jpeg',
      },
      {
        'number': 4,
        'name': 'Neon Racers',
        'image':
            'https://xstrela-alpha.s3.amazonaws.com/images/NeonCarsPoster.jpeg',
      },
      {
        'number': 5,
        'name': 'Mario Kart',
        'image': 'https://xstrela-alpha.s3.amazonaws.com/images/MarioKarts.png',
      },
      {
        'number': 1,
        'name': 'Grit',
        'image': 'https://xstrela-alpha.s3.amazonaws.com/images/Grit.png',
      },
      {
        'number': 2,
        'name': 'Brawl Stars',
        'image':
            'https://xstrela-alpha.s3.amazonaws.com/images/BrawlStars.jpeg',
      },
      {
        'number': 3,
        'name': 'Fortnite',
        'image':
            'https://xstrela-alpha.s3.amazonaws.com/images/fortniteHeros.jpeg',
      },
      {
        'number': 4,
        'name': 'Neon Racers',
        'image':
            'https://xstrela-alpha.s3.amazonaws.com/images/NeonCarsPoster.jpeg',
      },
      {
        'number': 5,
        'name': 'Mario Kart',
        'image': 'https://xstrela-alpha.s3.amazonaws.com/images/MarioKarts.png',
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtils.pxToDp(context, 56),
        vertical: SizeUtils.pxToDp(context, 0),
      ),
      child: HomeSection(
        cardSpacing: 20,
        cardsPerView: 4,
        heading: 'Favorite Images',
        sectionHeight: 420,
        items: games,
        cardBuilder: (context, game, width, index) {
          return const ImageThumbnail(
            imageUrl:
                'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/publisher-page-tv-screen/game-genre-action/metal-slug-awakening/metal-slug-awakening.jpg',
            height: 226,
            borderRadius: 10,
          );
        },
      ),
    );
  }
}
