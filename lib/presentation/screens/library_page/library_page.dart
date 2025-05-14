import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/screens/library_page/library_hero.dart';
import 'package:phynd_app/presentation/widgets/cards/clip_card/game_clip_card.dart';
import 'package:phynd_app/presentation/widgets/ratings/ratings.dart';
import 'package:phynd_app/presentation/widgets/section/home_section.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

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

    return ListView(
      children: [
        const LibraryHero(),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.pxToDp(context, 56),
              vertical: SizeUtils.pxToDp(context, 0)),
          child: Column(children: [
            HomeSection(
              cardSpacing: 20,
              cardsPerView: 4,
              heading: 'Featured Games',
              sectionHeight: 600,
              items: games,
              cardBuilder: (context, game, width, index) {
                return GameClipCard(
                  // imageUrl: game['image'] as String,
                  imageUrl:
                      'https://xstrela-alpha.s3.amazonaws.com/images/NeonCarsPoster.jpeg',
                  videoUrl:
                      'https://cdn.pixabay.com/video/2025/04/29/275633_large.mp4',
                  gameName: game['name'] as String,
                  badge: const Ratings(rating: 1.0),
                  esrbImageUrl:
                      'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/everyone.png',
                );
              },
            ),
          ]),
        ),

        // FavoriteGameSection(),
        // SavedGameSection(),
        // SavedContentSection(),
        // FavoriteContentSection(),
      ],
    );
  }
}
