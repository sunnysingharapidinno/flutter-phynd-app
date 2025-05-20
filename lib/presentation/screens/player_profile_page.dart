import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phynd_app/core/constants/ui_constants.dart';
import 'package:phynd_app/core/enums/friend_status.dart';
import 'package:phynd_app/core/enums/player_profile_section_type.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
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
    this.userId,
  });

  @override
  State<PlayerProfilePage> createState() => _PlayerProfilePageState();
}

class _PlayerProfilePageState<T> extends State<PlayerProfilePage<T>> {
  final UserService _userService = UserService();
  Profile? _userProfile;
  bool _isLoading = false;
  final GameService _gameService = GameService();

  PlayerProfileStats? _profileStats;
  bool _isFriend = false;
  FriendStatus? _friendStatus;

  bool _isCurrentUser = false;

  @override
  void initState() {
    super.initState();

    bool isCurrentUser = widget.userId == null;

    setState(() {
      _isCurrentUser = isCurrentUser;
    });

    if (isCurrentUser) {
      _isFriend = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final userId = context.read<AuthBloc>().state.profile?.user.id;
        if (userId != null) _getPlayerStats(userId);
      });
    } else {
      _checkFriendStatus();
      _fetchUserProfileById(widget.userId!);
      _getPlayerStats(widget.userId!);
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
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      debugPrint('Error fetching profile by ID: $e');
    }
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
      listener: (context, authState) async {},
      builder: (context, authState) {
        if (authState.status == AuthStatus.loading || _isLoading) {
          return const Center(
              child: CircularLoad(key: ValueKey("auth_loading")));
        }

        if (authState.status == AuthStatus.authenticated) {
          return _buildProfileContent(
              userProfile: _isCurrentUser ? authState.profile : _userProfile);
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
                  } else if (friendStatus == FriendStatus.pending) {
                    return;
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
            if (_isFriend) ...[
              CarouselRow(
                cardSpacing: 60,
                cardsPerView: 5,
                heading: 'Favorite Games',
                sectionHeight: 470,
                handleApiCall: (page) {
                  return _gameService.getPlayerProfileSectionGames(
                    page: page,
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
                  handleApiCall: (page) {
                    return _gameService.getPlayerProfileSectionGames(
                      page: page,
                      sectionType: PlayerProfileSectionType.continuePlayingDesc,
                      userId: userProfile?.user.id ?? '',
                    );
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
                heading: _isCurrentUser
                    ? 'Games Your Friends Are Playing'
                    : 'Games Your Mutual Friends Are Playing',
                sectionHeight: 350,
                handleApiCall: (page) {
                  return _gameService.getPlayerProfileSectionGames(
                    page: page,
                    sectionType: _isCurrentUser
                        ? PlayerProfileSectionType.friendGameDesc
                        : PlayerProfileSectionType.continuePlayingMutualDesc,
                    userId: userProfile?.user.id ?? '',
                  );
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
            ],
          ],
        ),
      ),
    );
  }
}
