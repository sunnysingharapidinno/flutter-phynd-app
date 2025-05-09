import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/screens/library_page/library_hero.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        LibraryHero(),
        // FavoriteGameSection(),
        // SavedGameSection(),
        // SavedContentSection(),
        // FavoriteContentSection(),
      ],
    );
  }
}
