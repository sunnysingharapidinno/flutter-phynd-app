import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/ui_constants.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
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
      children: [
        const LibraryHero(),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.pxToDp(context, 56),
            vertical: SizeUtils.pxToDp(context, 0),
          ),
          child: Column(
            children: [
              const RecentHistorySection(),
              SizedBox(
                  height:
                      SizeUtils.pxToDp(context, UIConstants.sectionSpacing)),
              const FavoriteGameSection(),
              SizedBox(
                  height:
                      SizeUtils.pxToDp(context, UIConstants.sectionSpacing)),
              const SavedGameSection(),
              SizedBox(
                  height:
                      SizeUtils.pxToDp(context, UIConstants.sectionSpacing)),
              const FavoriteVideoSection(),
              SizedBox(
                  height:
                      SizeUtils.pxToDp(context, UIConstants.sectionSpacing)),
              const SavedVideoSection(),
              SizedBox(
                  height:
                      SizeUtils.pxToDp(context, UIConstants.sectionSpacing)),
              const FavoriteImagesSection(),
              SizedBox(
                  height:
                      SizeUtils.pxToDp(context, UIConstants.sectionSpacing)),
              const SavedImagesSection(),
              SizedBox(
                  height:
                      SizeUtils.pxToDp(context, UIConstants.sectionSpacing)),
              const SavedEventsSection(),
            ],
          ),
        ),
      ],
    );
  }
}
