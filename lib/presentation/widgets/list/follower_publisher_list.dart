import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/buttons/primary_button.dart';
import 'package:phynd_app/presentation/widgets/list/friend_list_item.dart';
import 'package:phynd_app/presentation/widgets/input_fields/search_input_field.dart';

class FollowerPublisherList extends StatefulWidget {
  const FollowerPublisherList({super.key});

  @override
  State<FollowerPublisherList> createState() => _FollowerPublisherListState();
}

class _FollowerPublisherListState extends State<FollowerPublisherList>
    with SingleTickerProviderStateMixin {
  final List<String> _gamesList =
      List.generate(10, (index) => 'Gamertag${index + 1}');
  final List<String> _publisherList =
      List.generate(3, (index) => 'NewRequest${index + 1}');

  bool _isGamesList = true;

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
          ),
          SizedBox(height: SizeUtils.pxToDp(context, 40)),
          Expanded(
            child: _isGamesList
                ? _buildListView(context, _gamesList, false)
                : _buildListView(context, _publisherList, true),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(
    BuildContext context,
    List<String> games,
    bool isRequest,
  ) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text');

    if (games.isEmpty) {
      return Center(
        child: Text(
          'No friends to show.',
          style: TextStyle(color: textColor),
        ),
      );
    }

    return ListView.separated(
      itemCount: games.length,
      itemBuilder: (context, index) {
        return FriendListItem(
          gamerTag: "Hello Check",
          isRequest: isRequest,
          isGame: true,
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: SizeUtils.pxToDp(context, 40), // Add vertical spacing here
      ),
    );
  }
}
