import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/screens/library_page/library_hero.dart';
import 'package:phynd_app/presentation/screens/library_page/sections/favorite_game.dart';
import 'package:phynd_app/presentation/screens/library_page/sections/favorite_images.dart';
import 'package:phynd_app/presentation/screens/library_page/sections/favorite_video.dart';
import 'package:phynd_app/presentation/screens/library_page/sections/recent_history.dart';
import 'package:phynd_app/presentation/screens/library_page/sections/saved_events.dart';
import 'package:phynd_app/presentation/screens/library_page/sections/saved_video.dart';
import 'package:phynd_app/presentation/screens/library_page/sections/saved_game.dart';
import 'package:phynd_app/presentation/screens/library_page/sections/saved_images.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        LibraryHero(),
        RecentHistorySection(),
        FavoriteGameSection(),
        SavedGameSection(),
        FavoriteVideoSection(),
        SavedVideoSection(),
        FavoriteImagesSection(),
        SavedImagesSection(),
        SavedEventsSection(),
      ],
    );
  }
}
