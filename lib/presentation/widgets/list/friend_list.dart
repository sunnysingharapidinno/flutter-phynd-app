import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/ui_constants.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/data/models/response/friend_item.dart';
import 'package:phynd_app/data/services/user_service.dart';
import 'package:phynd_app/presentation/widgets/buttons/primary_button.dart';
import 'package:phynd_app/presentation/widgets/carousel/carousel_col.dart';
import 'package:phynd_app/presentation/widgets/list/friend_list_item.dart';
import 'package:phynd_app/presentation/widgets/input_fields/search_input_field.dart';
import 'package:phynd_app/presentation/widgets/loader/circular_load.dart';
import 'package:phynd_app/presentation/widgets/skeletons/list_item_skeleton.dart';

class FriendList extends StatefulWidget {
  const FriendList({super.key});

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList>
    with SingleTickerProviderStateMixin {
  final userService = UserService();

  final _friendsKey =
      GlobalKey<CarouselColState<FriendItem, Map<String, dynamic>>>();
  final _requestsKey =
      GlobalKey<CarouselColState<FriendItem, Map<String, dynamic>>>();

  bool _isMyFriendsList = true;

  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _acceptRequest(String requestId) async {
    try {
      await userService.acceptFriendRequest(requestId: requestId);
    } catch (e) {
      throw Exception('Error accepting request: $e');
    }
  }

  Future<void> _rejectRequest(String requestId) async {
    try {
      await userService.rejectFriendRequest(requestId: requestId);
    } catch (e) {
      throw Exception('Error rejecting request: $e');
    }
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
              'Friends',
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
                    text: 'My Friends',
                    height: 74,
                    textColor: _isMyFriendsList ? bgColor : textColor,
                    backgroundColor:
                        _isMyFriendsList ? activeTabColor : inActiveTabColor,
                    onPressed: () {
                      if (!_isMyFriendsList) {
                        setState(() {
                          _isMyFriendsList = true;
                        });
                      }
                    }),
              ),
              SizedBox(width: SizeUtils.pxToDp(context, 32)),
              Expanded(
                child: PrimaryButton(
                    text: 'Requests',
                    height: 74,
                    textColor: _isMyFriendsList ? textColor : bgColor,
                    backgroundColor:
                        _isMyFriendsList ? inActiveTabColor : activeTabColor,
                    onPressed: () {
                      if (_isMyFriendsList) {
                        setState(() {
                          _isMyFriendsList = false;
                        });
                      }
                    }),
              ),
            ],
          ),
          SizedBox(height: SizeUtils.pxToDp(context, 40)),
          SearchInputField(
            hintText: _isMyFriendsList
                ? 'PHYND a Friend...'
                : 'PHYND a Friend Request...',
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
            child: _isMyFriendsList
                ? CarouselCol(
                    key: _friendsKey,
                    handleApiCall: (page, args) => userService.getFriendsList(
                        page: page, search: args['search']),
                    cardsPerView: 3,
                    cardSpacing: 40,
                    sectionHeight: 300,
                    extraArgs: {
                      'search': _searchQuery,
                    },
                    cardBuilder: (context, friend, itemWidth, index) =>
                        FriendListItem(
                      gamerTag: friend.friendDisplayName ?? '',
                      profileImage: friend.friendDpUrl,
                    ),
                  )
                : CarouselCol(
                    key: _requestsKey,
                    handleApiCall: (page, args) =>
                        userService.getFriendRequestList(
                            page: page, search: args['search']),
                    cardsPerView: 3,
                    cardSpacing: 40,
                    sectionHeight: 300,
                    extraArgs: {
                      'search': _searchQuery,
                    },
                    cardBuilder: (context, friend, itemWidth, index) =>
                        FriendListItem(
                      gamerTag: friend.friendDisplayName ?? '',
                      profileImage: friend.friendDpUrl,
                      requestId: friend.id,
                      onAccept: () async =>
                          await _acceptRequest(friend.id ?? ''),
                      onDecline: () async =>
                          await _rejectRequest(friend.id ?? ''),
                      isRequest: true,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
