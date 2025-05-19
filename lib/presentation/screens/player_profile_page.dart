import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phynd_app/core/constants/ui_constants.dart';
import 'package:phynd_app/core/enums/friend_status.dart';
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
import 'package:phynd_app/presentation/widgets/loader/circular_load.dart';
import 'package:phynd_app/presentation/widgets/notifier.dart';
import 'package:phynd_app/presentation/widgets/profile/profile_header.dart';
import 'package:phynd_app/presentation/widgets/carousel/carousel_row.dart';

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
  bool _isFriend = false;
  FriendStatus? _friendStatus;

  bool _isCurrentUser = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isCurrentUser = widget.userId == null;
    });

    if (widget.userId != null) {
      _checkFriendStatus();
    } else {
      setState(() {
        _isCurrentUser = true;
        _isFriend = true;
      });
    }

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
      final response = await _userService.getPlayerProfileStats(
        userId: userId,
      );

      setState(() {
        _profileStats = response;
      });
    } catch (e) {
      debugPrint(e.toString());
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

      debugPrint("friend games: ${response.data}");

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

  Future<void> _checkFriendStatus() async {
    try {
      final friendStatus =
          await _userService.checkFriendStatus(userId: widget.userId!);
      setState(() {
        _isFriend = friendStatus.status == FriendStatus.accepted;
        _isCurrentUser = false;
        _friendStatus = friendStatus.status;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, authState) async {
        debugPrint("auth state: ${authState}, ${widget.userId}");
        if (widget.userId != null) {
          _checkFriendStatus();
        } else {
          setState(() {
            _isCurrentUser = true;
            _isFriend = true;
          });
        }
      },
      builder: (context, authState) {
        if (authState.status == AuthStatus.loading || _isLoading) {
          return const Center(
              child: CircularLoad(key: ValueKey("auth_loading")));
        }

        if (authState.status == AuthStatus.authenticated) {
          return _buildProfileContent(userProfile: _userProfile);
        } else if (authState.status == AuthStatus.unauthenticated) {
          return const Center(
              child: Text("User not authenticated. Please login."));
        } else if (authState.status == AuthStatus.error) {
          return Center(
              child: Text(
                  "Authentication error: ${authState.errorMessage ?? 'Unknown error'}"));
        }
        return const Center(child: Text("Profile not available."));
      },
    );
  }

  Widget _buildProfileContent({Profile? userProfile}) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeUtils.pxToDp(context, 32),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            ProfileHeader(
              username: userProfile?.user.display_name ?? '',
              isOnline: true,
              avatar: userProfile?.user.dp_url,
              currentlyPlaying: 'Marvel Rivals',
              isOtherProfile: widget.userId != null,
              friendsCount: _profileStats?.friendCount,
              followingCount: _profileStats?.userFollowings,
              mutualFriendsCount: _profileStats?.mutualFriendCount,
              friendStatus: _friendStatus,
              onFriendButtonPressed: (friendStatus) async {
                try {
                  if (friendStatus == FriendStatus.accepted) {
                    await _userService.unFriendUser(userId: widget.userId!);
                    if (mounted) {
                      Notifier.show(
                        context,
                        '${userProfile?.user.display_name} is removed from your friends list',
                      );
                    }
                  } else {
                    await _userService.sendFriendRequest(
                        userId: widget.userId!);
                    if (mounted) {
                      Notifier.show(context, 'Friend request sent');
                    }
                  }
                } finally {
                  await _checkFriendStatus();
                }
              },
            ),
            SizedBox(height: SizeUtils.pxToDp(context, 48)),

            // Only render game carousels if friend
            if (_isFriend) ...[
              CarouselRow(
                cardSpacing: 60,
                cardsPerView: 5,
                heading: 'Favorite Games',
                sectionHeight: 470,
                items: _favoriteGames,
                isLoading: _favoriteGamesLoading,
                handleApiCall: (page) {
                  _gameService.getPlayerProfileSectionGames(
                    sectionType: PlayerProfileSectionType.favoriteDesc,
                    userId: userProfile?.user.id ?? '',
                  );
                },
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
                CarouselRow(
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
              CarouselRow(
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
          ],
        ),
      ),
    );
  }
}
