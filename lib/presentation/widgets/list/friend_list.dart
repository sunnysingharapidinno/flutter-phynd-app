import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/buttons/primary_button.dart';
import 'package:phynd_app/presentation/widgets/list/friend_list_item.dart';
import 'package:phynd_app/presentation/widgets/input_fields/search_input_field.dart';

class FriendList extends StatefulWidget {
  const FriendList({super.key});

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList>
    with SingleTickerProviderStateMixin {
  final List<String> _myFriends =
      List.generate(10, (index) => 'Gamertag${index + 1}');
  final List<String> _friendRequests =
      List.generate(3, (index) => 'NewRequest${index + 1}');

  bool _isMyFriendsList = true;

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
                  onPressed: () => setState(() {
                    _isMyFriendsList = true;
                  }),
                ),
              ),
              SizedBox(width: SizeUtils.pxToDp(context, 32)),
              Expanded(
                child: PrimaryButton(
                  text: 'Requests',
                  height: 74,
                  textColor: _isMyFriendsList ? textColor : bgColor,
                  backgroundColor:
                      _isMyFriendsList ? inActiveTabColor : activeTabColor,
                  onPressed: () => setState(() {
                    _isMyFriendsList = false;
                  }),
                ),
              ),
            ],
          ),
          SizedBox(height: SizeUtils.pxToDp(context, 40)),
          SearchInputField(
            hintText: 'PHYND a Friend Request...',
            backgroundColor: bgColor,
            showMic: false,
            borderRadius: SizeUtils.pxToDp(context, 14),
          ),
          SizedBox(height: SizeUtils.pxToDp(context, 40)),
          Expanded(
            child: _isMyFriendsList
                ? _buildFriendListView(context, _myFriends, false)
                : _buildFriendListView(context, _friendRequests, true),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendListView(
    BuildContext context,
    List<String> friends,
    bool isRequest,
  ) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text');

    if (friends.isEmpty) {
      return Center(
        child: Text(
          'No friends to show.',
          style: TextStyle(color: textColor),
        ),
      );
    }

    return ListView.separated(
      itemCount: friends.length,
      itemBuilder: (context, index) {
        return FriendListItem(
          gamerTag: friends[index],
          isRequest: isRequest,
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: SizeUtils.pxToDp(context, 40), // Add vertical spacing here
      ),
    );
  }
}
