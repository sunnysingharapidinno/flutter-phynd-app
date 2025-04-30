import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phynd_app/core/routing/app_routes.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:phynd_app/presentation/bloc/auth/auth_event.dart';
import 'package:phynd_app/presentation/bloc/auth/auth_state.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  static const _appName = 'Phynd';
  static const _appSubtitle = 'Navigation Menu';

  static const List<Map<String, dynamic>> _navigationItems = [
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
    // {
    //   'title': 'Games',
    //   'icon': Icons.games,
    //   'route': AppRoutes.game,
    //   'isDivider': false,
    // },
    {
      'title': 'Quests',
      'icon': Icons.emoji_events,
      'route': AppRoutes.quest,
      'isDivider': false,
    },
    {
      'title': 'Player Profile',
      'icon': Icons.person,
      'route': AppRoutes.playerProfile,
      'isDivider': true,
    },
    {
      'title': 'Publisher Profile',
      'icon': Icons.business,
      'route': AppRoutes.publisherProfile,
      'isDivider': false,
    },
    {
      'title': 'Login',
      'icon': Icons.login,
      'route': AppRoutes.login,
      'isDivider': true,
      'showWhenAuthenticated': false,
    },
    {
      'title': 'Register',
      'icon': Icons.person_add,
      'route': AppRoutes.registration,
      'isDivider': false,
      'showWhenAuthenticated': false,
    },
    {
      'title': 'Support',
      'icon': Icons.help,
      'route': AppRoutes.support,
      'isDivider': true,
    },
    {
      'title': 'Terms & Conditions',
      'icon': Icons.description,
      'route': AppRoutes.termsAndConditions,
      'isDivider': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final primaryColor = theme?.get('primary') ?? Colors.blue;
    final textColor = theme?.get('text') ?? Colors.black;
    final backgroundColor = theme?.get('background') ?? Colors.white;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isAuthenticated = state.status == AuthStatus.authenticated;

        return Drawer(
          backgroundColor: backgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _appName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _appSubtitle,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              ..._navigationItems
                  .where((item) =>
                      !item.containsKey('showWhenAuthenticated') ||
                      item['showWhenAuthenticated'] == isAuthenticated)
                  .map((item) {
                    final List<Widget> widgets = [];

                    if (item['isDivider'] == true) {
                      widgets.add(Divider(color: textColor.withOpacity(0.2)));
                    }

                    widgets.add(
                      RemoteControlWrapper(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, item['route'] as String);
                        },
                        child: ListTile(
                          leading: Icon(
                            item['icon'] as IconData,
                            color: textColor,
                          ),
                          title: Text(
                            item['title'] as String,
                            style: TextStyle(color: textColor),
                          ),
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, item['route'] as String);
                          },
                        ),
                      ),
                    );

                    return widgets;
                  })
                  .expand((widgets) => widgets)
                  .toList(),
              if (isAuthenticated) ...[
                Divider(color: textColor.withOpacity(0.2)),
                RemoteControlWrapper(
                  onTap: () {
                    context.read<AuthBloc>().add(LogoutUser());
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: textColor,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(color: textColor),
                    ),
                    onTap: () {
                      context.read<AuthBloc>().add(LogoutUser());
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    },
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
