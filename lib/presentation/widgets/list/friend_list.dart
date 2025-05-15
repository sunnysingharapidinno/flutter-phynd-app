import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/data/models/response/friend_item.dart';
import 'package:phynd_app/data/services/user_service.dart';
import 'package:phynd_app/presentation/widgets/buttons/primary_button.dart';
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
  final ScrollController _scrollController = ScrollController();
  final ScrollController _requestScrollController = ScrollController();

  List<FriendItem> _myFriends = [];
  bool _isFriendsLoading = false;
  bool _isFetchingMore = false;
  int _currentPage = 1;
  bool _hasMoreFriends = true;

  List<FriendItem> _friendRequests = [];
  bool _isRequestsLoading = false;
  bool _isFetchingMoreRequests = false;
  int _currentRequestPage = 1;
  bool _hasMoreRequests = true;

  bool _isMyFriendsList = true;

  @override
  void initState() {
    super.initState();
    _getFriendsList();
    _getFriendRequests();
    _scrollController.addListener(_scrollListener);
    _requestScrollController.addListener(_requestScrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _requestScrollController.removeListener(_requestScrollListener);
    _requestScrollController.dispose();
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

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isFetchingMore &&
        _hasMoreFriends &&
        _isMyFriendsList) {
      _getFriendsList(fetchMore: true);
    }
  }

  void _requestScrollListener() {
    if (_requestScrollController.position.pixels ==
            _requestScrollController.position.maxScrollExtent &&
        !_isFetchingMoreRequests &&
        _hasMoreRequests &&
        !_isMyFriendsList) {
      _getFriendRequests(fetchMore: true);
    }
  }

  void _getFriendsList({bool fetchMore = false}) async {
    if (fetchMore) {
      if (_isFetchingMore || !_hasMoreFriends) return;
      setState(() {
        _isFetchingMore = true;
      });
      _currentPage++;
    } else {
      setState(() {
        _isFriendsLoading = true;
        _myFriends = [];
        _currentPage = 1;
        _hasMoreFriends = true;
      });
    }

    try {
      final response = await userService.getFriendsList(page: _currentPage);
      final newFriends = response.data;

      if (!mounted) return;
      setState(() {
        if (fetchMore) {
          _myFriends.addAll(newFriends ?? []);
        } else {
          _myFriends = newFriends ?? [];
        }
        _hasMoreFriends = newFriends != null && newFriends.isNotEmpty;
      });
    } catch (e) {
      debugPrint('Error fetching friends list: $e');
      if (fetchMore) _currentPage--;
    } finally {
      if (mounted) {
        setState(() {
          if (fetchMore) {
            _isFetchingMore = false;
          } else {
            _isFriendsLoading = false;
          }
        });
      }
    }
  }

  Future<void> _getFriendRequests({bool fetchMore = false}) async {
    if (fetchMore) {
      if (_isFetchingMoreRequests || !_hasMoreRequests) return;
      setState(() {
        _isFetchingMoreRequests = true;
      });
      _currentRequestPage++;
    } else {
      if (_isRequestsLoading && _friendRequests.isNotEmpty) return;
      setState(() {
        _isRequestsLoading = true;
        if (!fetchMore) _friendRequests = [];
        _currentRequestPage = 1;
        _hasMoreRequests = true;
      });
    }

    try {
      final response =
          await userService.getFriendRequestList(page: _currentRequestPage);
      final newRequests = response.data;
      if (!mounted) return;
      setState(() {
        if (fetchMore) {
          _friendRequests.addAll(newRequests ?? []);
        } else {
          _friendRequests = newRequests ?? [];
        }
        _hasMoreRequests = newRequests != null && newRequests.isNotEmpty;
      });
    } catch (e) {
      debugPrint('Error fetching friend requests: $e');
      if (fetchMore) _currentRequestPage--;
    } finally {
      if (mounted) {
        setState(() {
          if (fetchMore) {
            _isFetchingMoreRequests = false;
          } else {
            _isRequestsLoading = false;
          }
        });
      }
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
                          if (_myFriends.isEmpty && !_isFriendsLoading) {
                            _getFriendsList();
                          }
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
                          if (_friendRequests.isEmpty && !_isRequestsLoading) {
                            _getFriendRequests();
                          }
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
          ),
          SizedBox(height: SizeUtils.pxToDp(context, 40)),
          Expanded(
            child: _isMyFriendsList
                ? (_isFriendsLoading && _myFriends.isEmpty)
                    ? _buildInitialSkeletonList()
                    : _buildFriendListView(context, _myFriends, false)
                : (_isRequestsLoading && _friendRequests.isEmpty)
                    ? _buildInitialSkeletonList()
                    : _buildFriendListView(context, _friendRequests, true),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialSkeletonList() {
    return ListView.separated(
      itemCount: 5,
      itemBuilder: (context, index) => const ListItemSkeleton(),
      separatorBuilder: (context, index) => SizedBox(
        height: SizeUtils.pxToDp(context, 10),
      ),
    );
  }

  Widget _buildFriendListView(
    BuildContext context,
    List<FriendItem> friends,
    bool isRequest,
  ) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text');

    if (friends.isEmpty) {
      if ((isRequest && _isRequestsLoading) ||
          (!isRequest && _isFriendsLoading)) {
        return const Center(child: CircularLoad());
      }
      return Center(
        child: Text(
          isRequest ? 'No friend requests to show.' : 'No friends to show.',
          style: TextStyle(color: textColor),
        ),
      );
    }

    return ListView.separated(
      controller: isRequest ? _requestScrollController : _scrollController,
      itemCount: friends.length +
          (isRequest
              ? (_isFetchingMoreRequests ? 1 : 0)
              : (_isFetchingMore ? 1 : 0)),
      itemBuilder: (context, index) {
        bool isFetchingThisListMore =
            isRequest ? _isFetchingMoreRequests : _isFetchingMore;
        if (isFetchingThisListMore && index == friends.length) {
          return const ListItemSkeleton(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
          );
        }
        return FriendListItem(
          gamerTag: friends[index].friendDisplayName ?? '',
          profileImage: friends[index].friendDpUrl,
          isRequest: isRequest,
          requestId: friends[index].id,
          onAccept: () async => await _acceptRequest(friends[index].id ?? ''),
          onDecline: () async => await _rejectRequest(friends[index].id ?? ''),
          onActionCompleted:
              isRequest ? () => _getFriendRequests(fetchMore: false) : null,
        );
      },
      separatorBuilder: (context, index) {
        bool isFetchingThisListMore =
            isRequest ? _isFetchingMoreRequests : _isFetchingMore;
        if (isFetchingThisListMore && index == friends.length - 1) {
          return const SizedBox.shrink();
        }
        return SizedBox(
          height: SizeUtils.pxToDp(context, 40),
        );
      },
    );
  }
}
