import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/screens/library_page/library_hero.dart';
import 'package:phynd_app/presentation/widgets/cards/clip_card/game_clip_card.dart';
import 'package:phynd_app/presentation/widgets/game_clip_slider/game_clip_slider.dart';
import 'package:phynd_app/presentation/widgets/ratings/ratings.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const GameClipGrid(),
      ],
    );
  }
}

class GameClipGrid extends StatelessWidget {
  const GameClipGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cards = <GameClipCard>[
      GameClipCard(
        imageUrl:
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
        videoUrl: 'https://cdn.pixabay.com/video/2025/04/29/275633_large.mp4',
        gameName: 'Heroes of Mavia',
        badge: const Ratings(rating: 1.0),
        esrbImageUrl:
            'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/everyone.png',
      ),
      GameClipCard(
          imageUrl:
              'https://images.unsplash.com/photo-1511512578047-dfb367046420',
          videoUrl: 'https://cdn.pixabay.com/video/2025/04/29/275633_large.mp4',
          gameName: 'Cyber Quest',
          badge: const Ratings(rating: 3.5),
          esrbImageUrl:
              'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/everyone.png'),
      GameClipCard(
          imageUrl:
              'https://images.unsplash.com/photo-1464983953574-0892a716854b3fb',
          videoUrl: 'https://cdn.pixabay.com/video/2025/04/29/275633_large.mp4',
          gameName: 'Jungle Run',
          badge: const Ratings(rating: 5.0),
          esrbImageUrl:
              'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/everyone.png'),
      GameClipCard(
          imageUrl:
              'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429',
          videoUrl: 'https://cdn.pixabay.com/video/2025/04/29/275633_large.mp4',
          gameName: 'Sky Legends',
          badge: const Ratings(rating: 2.5),
          esrbImageUrl:
              'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/everyone.png'),
      GameClipCard(
          imageUrl:
              'https://images.unsplash.com/photo-1509228468518-180dd4864904',
          videoUrl: 'https://cdn.pixabay.com/video/2025/04/29/275633_large.mp4',
          gameName: 'Pixel Adventure',
          badge: const Ratings(rating: 4.5),
          esrbImageUrl:
              'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/everyone.png'),
      GameClipCard(
          imageUrl:
              'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
          videoUrl: 'https://cdn.pixabay.com/video/2025/04/29/275633_large.mp4',
          gameName: 'Mystic Valley',
          badge: const Ratings(rating: 4.2),
          esrbImageUrl:
              'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/everyone.png'),
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LibraryHero(),
          GameClipSlider(
            title: 'Favorited Games',
            cards: cards,
          ),
          const SizedBox(height: 32),
          GameClipSlider(
            title: 'Saved Games',
            cards: cards.reversed.toList(),
          ),
          const SizedBox(height: 32),
          GameClipSlider(
            title: 'Favorited Content',
            cards: cards,
          ),
          const SizedBox(height: 32),
          GameClipSlider(
            title: 'Saved Content',
            cards: cards,
          ),
        ],
      ),
    );
  }
}
