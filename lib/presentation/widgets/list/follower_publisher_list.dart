import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/data/models/response/game_follow_model.dart';
import 'package:phynd_app/data/models/response/pub_following_model.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/data/services/user_service.dart';
import 'package:phynd_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:phynd_app/presentation/bloc/auth/auth_state.dart';
import 'package:phynd_app/presentation/widgets/buttons/primary_button.dart';
import 'package:phynd_app/presentation/widgets/carousel/carousel_col.dart';
import 'package:phynd_app/presentation/widgets/list/friend_list_item.dart';
import 'package:phynd_app/presentation/widgets/input_fields/search_input_field.dart';

class FollowerPublisherList extends StatefulWidget {
  const FollowerPublisherList({super.key});

  @override
  State<FollowerPublisherList> createState() => _FollowerPublisherListState();
}

class _FollowerPublisherListState extends State<FollowerPublisherList>
    with SingleTickerProviderStateMixin {
  final gameService = GameService();
  final userService = UserService();

  final _gamesKey =
      GlobalKey<CarouselColState<GameFollow, Map<String, dynamic>>>();
  final _publisherKey =
      GlobalKey<CarouselColState<PubFollowing, Map<String, dynamic>>>();

  bool _isGamesList = true;

  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final bgColor = theme?.get('bgColor');
    final textColor = theme?.get('text');
    final activeTabColor = theme?.get('subText2');
    final inActiveTabColor = theme?.get('inActiveTab');

    return Container(
      padding: EdgeInsets.all(SizeUtils.pxToDp(context, 40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              'Following',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
          SizedBox(height: SizeUtils.pxToDp(context, 60)),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  text: 'Games',
                  height: 74,
                  textColor: _isGamesList ? bgColor : textColor,
                  backgroundColor:
                      _isGamesList ? activeTabColor : inActiveTabColor,
                  onPressed: () => setState(() {
                    _isGamesList = true;
                  }),
                ),
              ),
              SizedBox(width: SizeUtils.pxToDp(context, 32)),
              Expanded(
                child: PrimaryButton(
                  text: 'Publishers',
                  height: 74,
                  textColor: _isGamesList ? textColor : bgColor,
                  backgroundColor:
                      _isGamesList ? inActiveTabColor : activeTabColor,
                  onPressed: () => setState(() {
                    _isGamesList = false;
                  }),
                ),
              ),
            ],
          ),
          SizedBox(height: SizeUtils.pxToDp(context, 40)),
          SearchInputField(
            hintText: 'PHYND a Game...',
            backgroundColor: bgColor,
            showMic: false,
            borderRadius: SizeUtils.pxToDp(context, 14),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          SizedBox(height: SizeUtils.pxToDp(context, 40)),
          Expanded(
            child: _isGamesList
                ? CarouselCol(
                    key: _gamesKey,
                    handleApiCall: (page, args) => gameService.getGameFollowers(
                        page: page, search: args['search']),
                    cardsPerView: 3,
                    cardSpacing: 40,
                    sectionHeight: 300,
                    extraArgs: {
                      'search': _searchQuery,
                    },
                    cardBuilder: (context, game, itemWidth, index) =>
                        FriendListItem(
                      gamerTag: game.name ?? '',
                      isGame: true,
                      gameImage: game.thumbnail,
                    ),
                  )
                : BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, authState) {
                      return CarouselCol(
                        key: _publisherKey,
                        handleApiCall: (page, args) =>
                            userService.getPubFollowing(
                                page: page,
                                search: args['search'],
                                userId: authState.profile?.user.id ?? ''),
                        cardsPerView: 3,
                        cardSpacing: 40,
                        sectionHeight: 300,
                        extraArgs: {
                          'search': _searchQuery,
                        },
                        cardBuilder: (context, follower, itemWidth, index) =>
                            FriendListItem(
                          gamerTag: follower.followingDisplayName ?? '',
                          profileImage: follower.followingDpUrl,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
