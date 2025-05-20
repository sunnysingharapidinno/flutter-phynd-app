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
import 'package:phynd_app/presentation/screens/library_page/models/hero_data.dart';
import 'package:phynd_app/data/services/game_service.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  late HeroData _currentHeroData;
  late HeroData _initialHeroData;
  List<dynamic> _recentHistory = [];
  List<dynamic> _favoriteGames = [];
  List<dynamic> _savedGames = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initialHeroData = const HeroData(
      imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
      videoUrl: 'https://cdn.pixabay.com/video/2025/04/29/275633_large.mp4',
      gameTextImg: 'https://www.forgottenplayland.com/_next/image?url=%2Fassets%2Flogo.webp&w=640&q=75',
      releaseYear: '2024',
      companyName: 'Top Secret Games',
      esrb: 'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/everyone.png',
      friendsCount: 86,
      onlineCount: 12,
      gameTitle: 'Game Title',
    );
    _currentHeroData = _initialHeroData;
    _fetchAllData();
  }

  Future<void> _fetchAllData() async {
    final gameService = GameService();
    final recent = await gameService.getRecentHistory(page: 1, limit: UIConstants.defaultPageSize);
    final favorites = await gameService.getFavoriteGames(page: 1, limit: UIConstants.defaultPageSize);
    final saved = await gameService.getSavedGames(page: 1, limit: UIConstants.defaultPageSize);
    setState(() {
      _recentHistory = recent.data;
      _favoriteGames = favorites.data;
      _savedGames = saved.data;
      _loading = false;
    });
  }

  void _updateHeroData(HeroData newData) {
    setState(() {
      _currentHeroData = newData;
    });
  }

  void _resetHeroData() {
    setState(() {
      _currentHeroData = _initialHeroData;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    final hasAnyData = _recentHistory.isNotEmpty || _favoriteGames.isNotEmpty || _savedGames.isNotEmpty;
    return ListView(
      children: [
        if (hasAnyData)
          LibraryHero(heroData: _currentHeroData),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.pxToDp(context, 56),
            vertical: SizeUtils.pxToDp(context, 0),
          ),
          child: Column(
            children: [
              RecentHistorySection(
                onHover: _updateHeroData,
                onHoverExit: _resetHeroData,

              ),  
              SizedBox(
                  height:
                      SizeUtils.pxToDp(context, UIConstants.sectionSpacing)),
              FavoriteGameSection(
                onHover: _updateHeroData,
                onHoverExit: _resetHeroData,
              ),
              SizedBox(
                  height:
                      SizeUtils.pxToDp(context, UIConstants.sectionSpacing)),
              SavedGameSection(
                onHover: _updateHeroData,
                onHoverExit: _resetHeroData,
              ),
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
              const SavedEventsSection(),
              SizedBox(
                  height:
                      SizeUtils.pxToDp(context, UIConstants.sectionSpacing)),
              const FavoriteImagesSection(),
              SizedBox(
                  height:
                      SizeUtils.pxToDp(context, UIConstants.sectionSpacing)),
              const SavedImagesSection(),
            ],
          ),
        ),
      ],
    );
  }
}
