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
        thumbnailUrl:
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
        videoUrl: 'https://cdn.pixabay.com/video/2025/04/29/275633_large.mp4',
        title: 'Heroes of Mavia',
        rating: 5,
        esrbRatingImageUrl:
            'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/everyone.png',
      ),
      GameClipCard(
        thumbnailUrl:
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
        videoUrl: 'https://cdn.pixabay.com/video/2025/04/29/275633_large.mp4',
        title: 'Heroes of Mavia',
        rating: 5,
        esrbRatingImageUrl:
            'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/everyone.png',
      ),
      GameClipCard(
        thumbnailUrl:
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
        videoUrl: 'https://cdn.pixabay.com/video/2025/04/29/275633_large.mp4',
        title: 'Heroes of Mavia',
        rating: 5,
        esrbRatingImageUrl:
            'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/everyone.png',
      ),
      GameClipCard(
        thumbnailUrl:
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
        videoUrl: 'https://cdn.pixabay.com/video/2025/04/29/275633_large.mp4',
        title: 'Heroes of Mavia',
        rating: 5,
        esrbRatingImageUrl:
            'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/everyone.png',
      ),
      GameClipCard(
        thumbnailUrl:
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
        videoUrl: 'https://cdn.pixabay.com/video/2025/04/29/275633_large.mp4',
        title: 'Heroes of Mavia',
        rating: 5,
        esrbRatingImageUrl:
            'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/everyone.png',
      ),
      GameClipCard(
        thumbnailUrl:
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
        videoUrl: 'https://cdn.pixabay.com/video/2025/04/29/275633_large.mp4',
        title: 'Heroes of Mavia',
        rating: 5,
        esrbRatingImageUrl:
            'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/everyone.png',
      ),
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
