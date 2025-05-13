import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/app_images.dart';
import 'package:phynd_app/core/routing/app_routes.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/data/models/response/game_model.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/buttons/primary_button.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';
import 'package:phynd_app/presentation/widgets/loader/circular_load.dart';
import 'package:phynd_app/presentation/widgets/notifier.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';

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
    final bgColor = theme?.get('bgColor');
    final shadowBlack = theme?.get('shadowBlack');
    final midnightGray = theme?.get('midnightGray');
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
              // Image background with gradient
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://xstrela-alpha.s3.us-east-1.amazonaws.com/general/2025/03/16/3bc8bc2f85184505aec7858df30ac041.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.3613, 0.5962, 0.8327],
                    colors: [
                      shadowBlack!,
                      midnightGray!,
                      bgColor!,
                    ],
                  ),
                ),
              ),
              // Color filter with darken effect
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  textLight?.withOpacity(0.5) ?? Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                ),
                child: ImageThumbnail(
                  imageUrl:
                      'https://xstrela-alpha.s3.us-east-1.amazonaws.com/general/2025/03/16/3bc8bc2f85184505aec7858df30ac041.png',
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
                      imageUrl:
                          'https://www.forgottenplayland.com/_next/image?url=%2Fassets%2Flogo.webp&w=640&q=75',
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
                    SizedBox(
                      width: SizeUtils.pxToDp(context, 199),
                      height: SizeUtils.pxToDp(context, 72),
                      child: PrimaryButton(
                        text: 'Play',
                        textColor: btnText,
                        onPressed: () {},
                        backgroundColor: textColor,
                        icon: Icons.play_arrow,
                        iconColor: btnText,
                        iconSize: SizeUtils.pxToDp(context, 43),
                      ),
                    ),
                    SizedBox(width: SizeUtils.pxToDp(context, 32)),
                    SizedBox(
                      width: SizeUtils.pxToDp(context, 264),
                      height: SizeUtils.pxToDp(context, 72),
                      child: PrimaryButton(
                        text: 'More Info',
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.game,
                              arguments: _gameSlug);
                        },
                        backgroundColor: buttonBg2,
                        textColor: textColor,
                        icon: Icons.info_outline,
                        iconColor: textColor,
                        iconSize: SizeUtils.pxToDp(context, 43),
                      ),
                    ),
                    SizedBox(width: SizeUtils.pxToDp(context, 32)),
                    SizedBox(
                      width: SizeUtils.pxToDp(context, 240),
                      height: SizeUtils.pxToDp(context, 72),
                      child: PrimaryButton(
                        text: _isFollowed ? 'Following' : 'Follow',
                        isLoading: _checkingFollow,
                        onPressed: () {
                          _handleFollowBtn();
                        },
                        backgroundColor: buttonBg2,
                        textColor: textColor,
                        icon: _isFollowed ? null : Icons.add_circle_outline,
                        iconColor: textColor,
                        iconSize: SizeUtils.pxToDp(context, 43),
                      ),
                    ),
                    SizedBox(width: SizeUtils.pxToDp(context, 32)),
                    RemoteControlWrapper(
                        child: CircleAvatar(
                      backgroundColor: buttonBg2,
                      radius: SizeUtils.pxToDp(context, 36),
                      child: _checkingFavorite
                          ? SizedBox(
                              width: SizeUtils.pxToDp(context, 24),
                              height: SizeUtils.pxToDp(context, 24),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(textColor!),
                              ),
                            )
                          : IconButton(
                              icon: Icon(Icons.favorite,
                                  color:
                                      _isFavorite ? favoriteColor : textColor),
                              iconSize: SizeUtils.pxToDp(context, 43),
                              onPressed: () {
                                _handleFavoriteBtn();
                              },
                            ),
                    ))
                  ],
                ),

                SizedBox(height: SizeUtils.pxToDp(context, 40)),

                // Friends Playing Section
                Row(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          AppImages.peopleLogoGreyBg,
                          height: SizeUtils.pxToDp(context, 90),
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: SizeUtils.pxToDp(context, 19)),
                        Text(
                          '86 Friends Play',
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
