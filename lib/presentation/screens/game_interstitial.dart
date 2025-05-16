import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/app_images.dart';
import 'package:phynd_app/core/routing/app_routes.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/data/models/response/game_model.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/buttons/primary_button.dart';
import 'package:phynd_app/presentation/widgets/buttons/primary_icon_button.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';
import 'package:phynd_app/presentation/widgets/image_video.dart';
import 'package:phynd_app/presentation/widgets/loader/circular_load.dart';
import 'package:phynd_app/presentation/widgets/notifier.dart';

class GameInterstitialPage extends StatefulWidget {
  const GameInterstitialPage({super.key});

  @override
  State<GameInterstitialPage> createState() => _GameInterstitialPageState();
}

class _GameInterstitialPageState extends State<GameInterstitialPage> {
  final _gameSlug = 'xst-electric-sheep-9a116e1e';

  late bool _isLoading = false;
  GameDetails? _gameDetails;
  final GameService _gameService = GameService();
  bool _checkingFavorite = false;
  bool _checkingFollow = false;
  bool _isFollowed = false;
  bool _isFavorite = false;
  int _friendsCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchGameDetails();
    _checkFollowFavoriteStatus();
  }

  Future<void> _checkFollowFavoriteStatus() async {
    try {
      final status =
          await _gameService.checkLikeFollowGameStatus(gameSlug: _gameSlug);
      setState(
        () => _isFollowed = status.isFollow ?? false,
      );
      setState(() => _isFavorite = status.isFavorite ?? false);
      setState(() => _friendsCount = status.friendsCount ?? 0);
    } catch (e) {
      debugPrint("Error checking follow status: $e");
    }
  }

  Future<void> _fetchGameDetails() async {
    setState(() => _isLoading = true);

    try {
      final details = await _gameService.getGameDetails(gameSlug: _gameSlug);

      setState(() => _gameDetails = details);
    } catch (e) {
      debugPrint("Error fetching game details: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleFavoriteBtn() async {
    try {
      setState(() => _checkingFavorite = true);

      if (_isFavorite) {
        await _gameService.removeFavoriteSaveGame(
            gameSlug: _gameSlug, favorite: true);
      } else {
        await _gameService.favoriteSaveGame(
            gameSlug: _gameSlug, favorite: true);
      }

      Notifier.show(context,
          '${_gameDetails?.gameTitle ?? "Game"} is  ${!_isFavorite ? 'added to' : 'removed from'} favorite successfully');

      await _checkFollowFavoriteStatus();
    } catch (e) {
      Notifier.show(context,
          'Error ${!_isFavorite ? 'adding' : 'removing'} favorite ${_gameDetails?.gameTitle ?? "Game"}');
    } finally {
      setState(() => _checkingFavorite = false);
    }
  }

  Future<void> _handleFollowBtn() async {
    try {
      setState(() => _checkingFollow = true);
      if (_isFollowed) {
        await _gameService.unFollowGame(gameSlug: _gameSlug);
      } else {
        await _gameService.followGame(gameSlug: _gameSlug);
      }

      Notifier.show(context,
          '${_gameDetails?.gameTitle ?? "Game"} ${_isFollowed ? 'unfollowed' : 'followed'} successfully');

      await _checkFollowFavoriteStatus();
    } catch (e) {
      Notifier.show(context,
          'Error ${_isFollowed ? 'unfollowing' : 'following'} ${_gameDetails?.gameTitle ?? "Game"}');
    } finally {
      setState(() => _checkingFollow = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final theme = appTheme.extension<AppTheme>();
    final instParaColor = theme?.get('instPara');
    final textColor = theme?.get('text');
    final favoriteColor = theme?.get('favorite');
    final buttonBg2 = theme?.get('buttonBg2');
    final btnText = theme?.get('btnText');
    final subText2 = theme?.get('subText2');
    final onlineColor = theme?.get('onlineIndicator');
    final textLight = theme?.get('textLight');

    if (_isLoading) {
      return const Center(child: CircularLoad());
    }

    return Stack(
      children: [
        // Background Image
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              // Color filter with darken effect
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  textLight?.withOpacity(0.5) ?? Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                ),
                child: ImageVideo(
                  imageUrl: _gameDetails?.thumbnail,
                  videoUrl:
                      'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),

        // Content
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeUtils.pxToDp(context, 56),
                vertical: SizeUtils.pxToDp(context, 80)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Game Title Row
                Row(
                  children: [
                    // Game Logo (network image)
                    ImageThumbnail(
                      imageUrl: _gameDetails?.gameTextImageURL,
                      width: SizeUtils.pxToDp(context, 606),
                      height: SizeUtils.pxToDp(context, 238),
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: SizeUtils.pxToDp(context, 48)),
                    // ESRB Rating (also a network image)
                    ImageThumbnail(
                      imageUrl: _gameDetails?.esrbRatingImgUrl,
                      width: SizeUtils.pxToDp(context, 92),
                      height: SizeUtils.pxToDp(context, 111),
                      fit: BoxFit.contain,
                    ),
                  ],
                ),

                SizedBox(height: SizeUtils.pxToDp(context, 32)),

                // Game Tags
                Row(
                  children: [
                    ..._gameDetails?.genre
                            .map((e) => [
                                  _buildTag(e, context),
                                  SizedBox(
                                      width: SizeUtils.pxToDp(context, 24)),
                                ])
                            .expand((widgetList) => widgetList)
                            .toList() ??
                        [],
                  ],
                ),

                SizedBox(height: SizeUtils.pxToDp(context, 40)),

                // Game Description

                Container(
                  constraints:
                      BoxConstraints(maxWidth: SizeUtils.pxToDp(context, 928)),
                  child: Text(
                    _gameDetails?.shortBio ?? '',
                    maxLines: 3,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: FontUtils.pxToSp(context, 28),
                      color: instParaColor,
                      height: 1.5,
                    ),
                  ),
                ),

                SizedBox(height: SizeUtils.pxToDp(context, 40)),

                // Action Buttons Row
                Row(
                  children: [
                    PrimaryButton(
                      text: 'Play',
                      height: 72,
                      width: 199,
                      textColor: btnText,
                      onPressed: () {},
                      backgroundColor: textColor,
                      icon: Icons.play_arrow,
                      iconColor: btnText,
                      iconSize: 43,
                      borderRadius: 6,
                    ),
                    SizedBox(width: SizeUtils.pxToDp(context, 32)),
                    PrimaryButton(
                      text: 'More Info',
                      width: 264,
                      height: 72,
                      borderRadius: 6,
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.game,
                            arguments: _gameSlug);
                      },
                      backgroundColor: buttonBg2,
                      textColor: textColor,
                      icon: Icons.info_outline,
                      iconColor: textColor,
                      iconSize: 43,
                    ),
                    SizedBox(width: SizeUtils.pxToDp(context, 32)),
                    PrimaryButton(
                      width: 240,
                      height: 72,
                      borderRadius: 6,
                      text: _isFollowed ? 'Following' : 'Follow',
                      isLoading: _checkingFollow,
                      onPressed: () {
                        _handleFollowBtn();
                      },
                      backgroundColor: buttonBg2,
                      textColor: textColor,
                      icon: _isFollowed ? null : Icons.add_circle_outline,
                      iconColor: textColor,
                      iconSize: 43,
                    ),
                    SizedBox(width: SizeUtils.pxToDp(context, 32)),
                    PrimaryIconButton(
                      buttonColor: buttonBg2!,
                      icon: Icons.favorite,
                      iconColor: _isFavorite ? favoriteColor : textColor,
                      isLoading: _checkingFavorite,
                      iconSize: 43,
                      onPressed: () {
                        _handleFavoriteBtn();
                      },
                    ),
                  ],
                ),

                SizedBox(height: SizeUtils.pxToDp(context, 40)),

                // Friends Playing Section
                Row(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const ImageThumbnail(
                          imageUrl: AppImages.peopleLogoGreyBg,
                          width: 90,
                          height: 90,
                          fit: BoxFit.contain,
                          isNetwork: false,
                        ),
                        SizedBox(width: SizeUtils.pxToDp(context, 19)),
                        Text(
                          '$_friendsCount Friends Play',
                          style: TextStyle(
                            color: subText2,
                            fontSize: FontUtils.pxToSp(context, 48),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: SizeUtils.pxToDp(context, 28)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: SizeUtils.pxToDp(context, 40),
                          height: SizeUtils.pxToDp(context, 40),
                          decoration: BoxDecoration(
                            color: onlineColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 19),
                        Text(
                          '12 online',
                          style: TextStyle(
                            color: subText2,
                            fontSize: FontUtils.pxToSp(context, 40),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String text, BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text');

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: FontUtils.pxToSp(context, 24),
          ),
        ),
        SizedBox(width: SizeUtils.pxToDp(context, 24)),
        Container(
          width: SizeUtils.pxToDp(context, 20),
          height: SizeUtils.pxToDp(context, 20),
          decoration: BoxDecoration(
            color: textColor,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
