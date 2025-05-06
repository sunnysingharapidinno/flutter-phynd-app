import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/widgets/shared_app_bar.dart';
import 'package:phynd_app/presentation/widgets/sidebar.dart';

class BaseLayout extends StatefulWidget {
  final String title;
  final Widget child;
  final bool showBackButton;
  final bool showSidebar;
  final bool showNotifications;
  final List<Widget>? actions;

  const BaseLayout({
    super.key,
    required this.title,
    required this.child,
    this.showBackButton = false,
    this.showSidebar = true,
    this.showNotifications = true,
    this.actions,
  });

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final backgroundColor = theme?.get('bgColor');

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: backgroundColor,
      appBar: SharedAppBar(
        title: widget.title,
        showBackButton: widget.showBackButton,
        showMenuButton: widget.showSidebar,
        showNotifications: widget.showNotifications,
        actions: widget.actions,
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      drawer: widget.showSidebar ? const Sidebar() : null,
      body: SafeArea(
        child: widget.child,
      ),
    );
  }
}
