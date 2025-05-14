import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/data/services/user_service.dart';
import 'package:phynd_app/data/models/response/profile_model.dart';
import 'package:phynd_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:phynd_app/presentation/widgets/cards/clip_card/game_clip_card.dart';
import 'package:phynd_app/presentation/widgets/cards/fav_game_card.dart';
import 'package:phynd_app/presentation/widgets/cards/friends_play_card.dart';
import 'package:phynd_app/presentation/widgets/profile/achievements_section.dart';
import 'package:phynd_app/presentation/widgets/profile/profile_header.dart';
import 'package:phynd_app/presentation/widgets/profile/quests_in_progress.dart';
import 'package:phynd_app/presentation/widgets/profile/recently_uploaded_clips.dart';
import 'package:phynd_app/presentation/widgets/ratings/ratings.dart';
import 'package:phynd_app/presentation/widgets/section/home_section.dart';

class PlayerProfilePage extends StatefulWidget {
  final String? userId;

  const PlayerProfilePage({
    super.key,
    required this.userId,
  });

  @override
  State<PlayerProfilePage> createState() => _PlayerProfilePageState();
}

class _PlayerProfilePageState extends State<PlayerProfilePage> {
  final UserService _userService = UserService();
  Profile? _userProfile;
  bool _isLoading = false;

  final games = [
    {
      'number': 1,
      'name': 'Grit',
      'image': 'https://xstrela-alpha.s3.amazonaws.com/images/Grit.png',
    },
    {
      'number': 2,
      'name': 'Brawl Stars',
      'image': 'https://xstrela-alpha.s3.amazonaws.com/images/BrawlStars.jpeg',
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
      'image': 'https://xstrela-alpha.s3.amazonaws.com/images/BrawlStars.jpeg',
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

  @override
  void initState() {
    super.initState();
    _getUserDetails(widget.userId);
  }

  Future<void> _getUserDetails(String? userId) async {
    try {
      if (userId != null) {
        setState(() {
          _isLoading = true;
        });
        final profile = await _userService.getUserById(userId: userId);
        setState(() {
          _userProfile = profile;
        });
      } else {
        // Get current user's profile from AuthBloc
        final authState = context.read<AuthBloc>().state;
        setState(() {
          _userProfile = authState.profile;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    final String displayName = _userProfile != null
        ? "${_userProfile!.user.first_name} ${_userProfile!.user.last_name}"
        : "User";

    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileHeader(
                  username: displayName,
                  isOnline: true,
                  avatar: _userProfile?.user.dp_url,
                  currentlyPlaying: 'Marvel Rivals',
                  isOtherProfile: widget.userId != null,
                ),

                SizedBox(height: SizeUtils.pxToDp(context, 48)),

                // Favorite Games Section

                Padding(
                    padding: EdgeInsets.fromLTRB(SizeUtils.pxToDp(context, 32),
                        0, SizeUtils.pxToDp(context, 100), 0),
                    child: Column(
                      children: [
                        HomeSection(
                          cardSpacing: 60,
                          cardsPerView: 5,
                          heading: 'Favorite Games',
                          sectionHeight: SizeUtils.pxToDp(context, 740),
                          items: games,
                          cardBuilder: (context, game, width, index) {
                            return FavGameCard(
                              width: double.infinity,
                              height: 300,
                              imageUrl: game['image'] as String,
                              rank: index + 1,
                              title: game['name'] as String,
                            );
                          },
                        ),
                        SizedBox(height: SizeUtils.pxToDp(context, 48)),
                        HomeSection(
                          cardSpacing: 20,
                          cardsPerView: 4,
                          heading: 'Continue Playing',
                          sectionHeight: 350,
                          items: games,
                          onEndOfScroll: () {
                            print('onEndOfScroll');
                          },
                          cardBuilder: (context, game, width, index) {
                            return GameClipCard(
                              height: 233,
                              thumbnailUrl:
                                  'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
                              videoUrl:
                                  'https://cdn.pixabay.com/video/2025/04/29/275633_large.mp4',
                              title: 'Heroes of Mavia',
                              rating: 5,
                              esrbRatingImageUrl:
                                  'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/everyone.png',
                            );
                          },
                        ),
                        SizedBox(height: SizeUtils.pxToDp(context, 48)),
                        HomeSection(
                          cardSpacing: 20,
                          cardsPerView: 4,
                          heading: 'Games Your Friends Are Playing',
                          sectionHeight: 470,
                          items: games,
                          cardBuilder: (context, game, width, index) {
                            return FriendsPlayCard(
                              gameImageUrl:
                                  'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
                              gameTitle: 'Heroes of Mavia',
                              esrbRatingImageUrl:
                                  'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/everyone.png',
                              userAvatarUrl:
                                  'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
                              userGamertag: 'Coolgamer123',
                              currentlyPlayingGame: 'Brawl Stars',
                            );
                          },
                        ),
                      ],
                    )),

                // Recently Uploaded Clips Section
                // const RecentlyUploadedClips(),

                // Achievements Section
                // const AchievementsSection(),

                // Quests in Progress Section
                // const QuestsInProgress(),
              ],
            ),
          );
  }
}
