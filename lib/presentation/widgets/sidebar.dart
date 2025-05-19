import 'package:flutter/material.dart';
import 'package:phynd_app/core/routing/app_routes.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/presentation/widgets/list/follower_publisher_list.dart';
import 'package:phynd_app/presentation/widgets/list/friend_list.dart';
import 'package:phynd_app/presentation/widgets/modals/modal.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';

class Sidebar extends StatelessWidget {
  final bool isSidebarExpanded;
  final double minExpWidth;
  final double maxExpWidth;
  final ValueChanged<bool>? onFocus;

  const Sidebar({
    super.key,
    this.isSidebarExpanded = false,
    required this.minExpWidth,
    required this.maxExpWidth,
    this.onFocus,
  });

  static const List<Map<String, dynamic>> _navigationItems = [
    {
      'title': 'Profile',
      'icon': Icons.person,
      'route': AppRoutes.playerProfile,
    },
    {
      'title': 'Home',
      'icon': Icons.home,
      'route': AppRoutes.home,
    },
    {
      'title': 'Search',
      'icon': Icons.search,
      'route': AppRoutes.search,
    },
    {
      'title': 'Library',
      'icon': Icons.library_add,
      'route': AppRoutes.library,
    },
    {
      'title': 'Friends',
      'icon': Icons.people,
      'modal': FriendList(),
    },
    {
      'title': 'Following',
      'icon': Icons.list,
      'route': AppRoutes.following,
      'modal': FollowerPublisherList(),
    },
    {
      'title': 'Account',
      'icon': Icons.settings,
      'route': AppRoutes.account,
    },
    {
      'title': 'Login',
      'icon': Icons.login,
      'route': AppRoutes.login,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text') ?? Colors.black;
    final backgroundColor = theme?.get('bgColor') ?? Colors.white;

    return Drawer(
      width: isSidebarExpanded ? maxExpWidth : minExpWidth,
      backgroundColor: backgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ..._navigationItems.map((item) {
            return RemoteControlWrapper(
              onFocus: () {
                onFocus?.call(true);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: EdgeInsets.symmetric(
                    horizontal: isSidebarExpanded ? 16 : 0),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    final currentRoute = ModalRoute.of(context)?.settings.name;
                    if (currentRoute == item['route']) {
                      return;
                    }

                    if (item['modal'] != null) {
                      SharedModal.show(
                        context: context,
                        child: item['modal']!,
                      );
                    } else {
                      Navigator.pushNamed(context, item['route'] as String);
                    }
                  },
                  title: Row(
                    children: [
                      if (!isSidebarExpanded)
                        Expanded(
                          child: Center(
                            child: Icon(
                              item['icon'] as IconData,
                              color: textColor,
                            ),
                          ),
                        )
                      else ...[
                        Icon(
                          item['icon'] as IconData,
                          color: textColor,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          item['title'] as String,
                          style: TextStyle(
                            color: textColor,
                            fontSize: FontUtils.pxToSp(context, 26),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
