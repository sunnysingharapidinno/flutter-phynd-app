import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/screens/library_page/library_hero.dart';
import 'package:phynd_app/presentation/screens/library_page/sections/favorite_content.dart';
import 'package:phynd_app/presentation/screens/library_page/sections/favorite_game.dart';
import 'package:phynd_app/presentation/screens/library_page/sections/saved_content.dart';
import 'package:phynd_app/presentation/screens/library_page/sections/saved_game.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        LibraryHero(),
        FavoriteGameSection(),
        SavedGameSection(),
        SavedContentSection(),
        FavoriteContentSection(),
      ],
    );
  }
}
