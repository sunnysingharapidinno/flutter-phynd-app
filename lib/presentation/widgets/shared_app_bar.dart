import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool showMenuButton;
  final bool showNotifications;
  final List<Widget>? actions;
  final VoidCallback? onMenuPressed;

  const SharedAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.showMenuButton = true,
    this.showNotifications = true,
    this.actions,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text') ?? Colors.black;
    final backgroundColor = theme?.get('background') ?? Colors.white;

    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: textColor,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : showMenuButton
              ? RemoteControlWrapper(
                  onTap: onMenuPressed,
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: textColor,
                    ),
                    onPressed: onMenuPressed,
                  ),
                )
              : null,
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        if (showNotifications)
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: textColor,
            ),
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
        if (actions != null) ...actions!,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
