import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phynd_app/core/constants/ui_constants.dart';
import 'package:phynd_app/core/enums/player_profile_section_type.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/data/models/response/player_profile_game.dart';
import 'package:phynd_app/data/models/response/player_profile_stats.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/data/services/user_service.dart';
import 'package:phynd_app/data/models/response/profile_model.dart';
import 'package:phynd_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:phynd_app/presentation/bloc/auth/auth_state.dart';
import 'package:phynd_app/presentation/widgets/cards/clip_card/game_clip_card.dart';
import 'package:phynd_app/presentation/widgets/cards/fav_game_card.dart';
import 'package:phynd_app/presentation/widgets/cards/friends_play_card.dart';
import 'package:phynd_app/presentation/widgets/profile/achievements_section.dart';
import 'package:phynd_app/presentation/widgets/profile/profile_header.dart';
import 'package:phynd_app/presentation/widgets/profile/quests_in_progress.dart';
import 'package:phynd_app/presentation/widgets/profile/recently_uploaded_clips.dart';
import 'package:phynd_app/presentation/widgets/ratings/ratings.dart';
import 'package:phynd_app/presentation/widgets/section/home_section.dart';

class PlayerProfilePage<T> extends StatefulWidget {
  final String? userId;

  const PlayerProfilePage({
    super.key,
    required this.userId,
  });

  @override
  State<PlayerProfilePage> createState() => _PlayerProfilePageState();
}

class _PlayerProfilePageState<T> extends State<PlayerProfilePage<T>> {
  final UserService _userService = UserService();
  Profile? _userProfile;
  bool _isLoading = false;
  final GameService _gameService = GameService();

  bool _favoriteGamesLoading = false;
  List<PlayerProfileGame> _favoriteGames = [];
  bool _continuePlayingGamesLoading = false;
  List<PlayerProfileGame> _continuePlayingGames = [];
  bool _friendGamesLoading = false;
  List<PlayerProfileGame> _friendGames = [];
  PlayerProfileStats? _profileStats;
  bool _profileStatsLoading = false;

  bool _isCurrentUser = false;
  Profile? _currentUserProfileFromAuth;

  @override
  void initState() {
    super.initState();
    _isCurrentUser = widget.userId == null;

    if (!_isCurrentUser) {
      _fetchUserProfileById(widget.userId!);
    }
  }

  Future<void> _fetchUserProfileById(String userId) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final profile = await _userService.getUserById(userId: userId);
      setState(() {
        _userProfile = profile;
        _isLoading = false;
      });
      if (mounted) {
        _loadAssociatedPlayerData(profile.user.id);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      debugPrint('Error fetching profile by ID: $e');
      // Handle error, e.g., show a snackbar or error message
    }
  }

  Future<void> _loadAssociatedPlayerData(String profileUserId) async {
    if (profileUserId.isEmpty) {
      debugPrint("Cannot load associated player data: profileUserId is empty.");
      return;
    }
    debugPrint("Loading associated player data for user id: ${profileUserId}");
    // Trigger all loads, they manage their own loading states
    _getPlayerStats(profileUserId);
    _getPlayerFavoriteGames(profileUserId);
    if (_isCurrentUser) {
      _getPlayerContinuePlayingGames(profileUserId);
    }
    _getPlayerFriendsGames(profileUserId);
  }

  Future<void> _getPlayerStats(String userId) async {
    try {
      setState(() {
        _profileStatsLoading = true;
      });
      final response = await _userService.getPlayerProfileStats(
        userId: userId,
      );

      setState(() {
        _profileStats = response;
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        _profileStatsLoading = false;
      });
    }
  }

  Future<void> _getPlayerFavoriteGames(String userId) async {
    try {
      setState(() {
        _favoriteGamesLoading = true;
      });
      final response = await _gameService.getPlayerProfileSectionGames(
        sectionType: PlayerProfileSectionType.favoriteDesc,
        userId: userId,
      );

      setState(() {
        _favoriteGames = response.data;
      });
      print("favorite games: ${_favoriteGames}");
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        _favoriteGamesLoading = false;
      });
    }
  }

  Future<void> _getPlayerContinuePlayingGames(String userId) async {
    try {
      setState(() {
        _continuePlayingGamesLoading = true;
      });
      final response = await _gameService.getPlayerProfileSectionGames(
        sectionType: PlayerProfileSectionType.continuePlayingDesc,
        userId: userId,
      );

      setState(() {
        _continuePlayingGames = response.data;
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        _continuePlayingGamesLoading = false;
      });
    }
  }

  Future<void> _getPlayerFriendsGames(String userId) async {
    try {
      setState(() {
        _friendGamesLoading = true;
      });
      final response = await _gameService.getPlayerProfileSectionGames(
        sectionType: _isCurrentUser
            ? PlayerProfileSectionType.friendGameDesc
            : PlayerProfileSectionType.continuePlayingMutualDesc,
        userId: userId,
      );

      print("friend games: ${response.data}");

      setState(() {
        _friendGames = response.data;
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        _friendGamesLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isCurrentUser) {
      return BlocConsumer<AuthBloc, AuthState>(
        listener: (context, authState) {
          if (authState.status == AuthStatus.authenticated &&
              authState.profile != null) {
            if (_currentUserProfileFromAuth == null ||
                _currentUserProfileFromAuth!.user.id !=
                    authState.profile!.user.id) {
              if (mounted) {
                setState(() {
                  _userProfile = authState.profile;
                  _currentUserProfileFromAuth = authState.profile;
                  _isLoading = false;
                });
                _loadAssociatedPlayerData(authState.profile!.user.id);
              }
            }
          } else if (authState.status == AuthStatus.unauthenticated) {
            if (mounted) {
              setState(() {
                _userProfile = null;
                _currentUserProfileFromAuth = null;
                _isLoading = false;
                _favoriteGames = [];
                _continuePlayingGames = [];
                _friendGames = [];
              });
            }
          } else if (authState.status == AuthStatus.loading) {
            if (mounted) {
              setState(() {
                _isLoading = true;
              });
            }
          } else if (authState.status == AuthStatus.error) {
            if (mounted) {
              setState(() {
                _isLoading = false;
                _userProfile = null;
                _currentUserProfileFromAuth = null;
              });
            }
          }
        },
        builder: (context, authState) {
          if (authState.status == AuthStatus.loading ||
              (authState.status == AuthStatus.initial &&
                  _userProfile == null)) {
            return const Center(
                child:
                    CircularProgressIndicator(key: ValueKey("auth_loading")));
          }

          if (authState.status == AuthStatus.authenticated &&
              _userProfile != null) {
            return _buildProfileContent();
          } else if (authState.status == AuthStatus.unauthenticated) {
            return const Center(
                child: Text("User not authenticated. Please login."));
          } else if (authState.status == AuthStatus.error) {
            return Center(
                child: Text(
                    "Authentication error: ${authState.errorMessage ?? 'Unknown error'}"));
          } else if (_isLoading) {
            return const Center(
                child: CircularProgressIndicator(
                    key: ValueKey("auth_fallback_loading")));
          }
          return const Center(child: Text("Profile not available."));
        },
      );
    } else {
      return _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                  key: ValueKey("other_user_loading")))
          : _userProfile != null
              ? _buildProfileContent()
              : const Center(child: Text("User profile not found."));
    }
  }

  Widget _buildProfileContent() {
    final String displayName = _userProfile != null
        ? "${_userProfile!.user.first_name} ${_userProfile!.user.last_name}"
        : "User";

    if (_isLoading && !_isCurrentUser) {
      return const Center(
          child: CircularProgressIndicator(
              key: ValueKey("profile_content_outer_loading")));
    }

    if (_userProfile == null) {
      return const Center(child: Text("Profile data is unavailable."));
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileHeader(
            username: displayName,
            isOnline: true,
            avatar: _userProfile?.user.dp_url,
            currentlyPlaying: 'Marvel Rivals',
            isOtherProfile: widget.userId != null,
            friendsCount: _profileStats?.friendCount,
            followingCount: _profileStats?.userFollowings,
            mutualFriendsCount: _profileStats?.mutualFriendCount,
          ),
          SizedBox(height: SizeUtils.pxToDp(context, 48)),
          Padding(
              padding: EdgeInsets.fromLTRB(SizeUtils.pxToDp(context, 32), 0,
                  SizeUtils.pxToDp(context, 100), 0),
              child: Column(
                children: [
                  HomeSection(
                    cardSpacing: 60,
                    cardsPerView: 5,
                    heading: 'Favorite Games',
                    sectionHeight: 470,
                    items: _favoriteGames,
                    isLoading: _favoriteGamesLoading,
                    cardBuilder: (context, game, width, index) {
                      return FavGameCard(
                        width: double.infinity,
                        height: 300,
                        imageUrl: game.thumbnail ?? '',
                        rank: index + 1,
                        title: game.name ?? 'N/A',
                      );
                    },
                  ),
                  SizedBox(height: SizeUtils.pxToDp(context, 48)),
                  if (_isCurrentUser) ...[
                    HomeSection(
                      cardSpacing: UIConstants.cardSpacing,
                      cardsPerView: UIConstants.defaultCardsPerView,
                      heading: 'Continue Playing',
                      sectionHeight: 350,
                      items: _continuePlayingGames,
                      isLoading: _continuePlayingGamesLoading,
                      onEndOfScroll: () {
                        print('onEndOfScroll');
                      },
                      cardBuilder: (context, game, width, index) {
                        return GameClipCard(
                          height: 233,
                          thumbnailUrl: game.thumbnail,
                          videoUrl:
                              'https://cdn.pixabay.com/video/2025/04/29/275633_large.mp4',
                          title: game.name,
                          rating: 5,
                          esrbRatingImageUrl: game.esrbRatingImgUrl,
                        );
                      },
                    ),
                    SizedBox(height: SizeUtils.pxToDp(context, 48)),
                  ],
                  HomeSection(
                    cardSpacing: UIConstants.cardSpacing,
                    cardsPerView: UIConstants.defaultCardsPerView,
                    heading: 'Games Your Friends Are Playing',
                    sectionHeight: 350,
                    items: _friendGames,
                    isLoading: _friendGamesLoading,
                    cardBuilder: (context, game, width, index) {
                      return GameClipCard(
                        height: 233,
                        thumbnailUrl: game.thumbnail,
                        videoUrl:
                            'https://cdn.pixabay.com/video/2025/04/29/275633_large.mp4',
                        title: game.name,
                        rating: 5,
                        esrbRatingImageUrl: game.esrbRatingImgUrl,
                      );
                    },
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
