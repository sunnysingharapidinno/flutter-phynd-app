import 'package:flutter/material.dart';
import 'package:phynd_app/core/routing/app_routes.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
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
      'isDivider': false,
    },
    {
      'title': 'Home',
      'icon': Icons.home,
      'route': AppRoutes.home,
      'isDivider': false,
    },
    {
      'title': 'Search',
      'icon': Icons.search,
      'route': AppRoutes.search,
      'isDivider': false,
    },
    {
      'title': 'Library',
      'icon': Icons.library_add,
      'route': AppRoutes.library,
      'isDivider': false,
    },
    {
      'title': 'Friends',
      'icon': Icons.people,
      'route': AppRoutes.friends,
      'isDivider': false,
    },
    {
      'title': 'Library',
      'icon': Icons.library_books,
      'route': AppRoutes.library,
      'isDivider': false,
    },
    {
      'title': 'Following',
      'icon': Icons.list,
      'route': AppRoutes.following,
      'isDivider': false,
    },
    {
      'title': 'Account',
      'icon': Icons.settings,
      'route': AppRoutes.account,
      'isDivider': false,
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
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, item['route'] as String);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: EdgeInsets.symmetric(
                    horizontal: isSidebarExpanded ? 16 : 0),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
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
                        Flexible(
                          child: Text(
                            item['title'] as String,
                            style: TextStyle(color: textColor),
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
