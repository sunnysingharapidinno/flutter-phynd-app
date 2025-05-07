import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';
import 'package:phynd_app/presentation/widgets/sidebar.dart';
import 'package:phynd_app/presentation/widgets/shared_app_bar.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';
import 'package:phynd_app/presentation/widgets/shared_app_bar.dart';
import 'package:phynd_app/presentation/widgets/sidebar.dart';

class BaseLayout extends StatefulWidget {
  final Widget child;

  const BaseLayout({
    super.key,
    required this.child,
  });

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isSidebarExpanded = false;

  // Focus management
  final FocusNode _sidebarFocusNode = FocusNode();
  final FocusNode _contentFocusNode = FocusNode();
  bool _hasContentBeenFocused = false;

  @override
  void initState() {
    super.initState();

    // Listen to focus changes
    _sidebarFocusNode.addListener(() {
      if (_sidebarFocusNode.hasFocus) {
        debugPrint('Sidebar focused');
        // Only expand if we've previously had content focus
        if (_hasContentBeenFocused) {
          setState(() {
            _isSidebarExpanded = true;
          });
        }
      }
    });

    _contentFocusNode.addListener(() {
      if (_contentFocusNode.hasFocus) {
        debugPrint('Content focused');
        _hasContentBeenFocused = true;
        setState(() {
          _isSidebarExpanded = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _sidebarFocusNode.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final backgroundColor = theme?.get('bgColor');

    final double minExpWidth = SizeUtils.pxToDp(context, 100);
    final double maxExpWidth = SizeUtils.pxToDp(context, 400);

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: backgroundColor,
        appBar: SharedAppBar(),
        body: Row(
          children: [
            // Sidebar
            FocusTraversalGroup(
              child: KeyboardListener(
                focusNode: FocusNode(),
                onKeyEvent: (KeyEvent event) {
                  if (event is KeyDownEvent) {
                    if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
                      // Only move to content if we're not handling internal navigation
                      if (!_isSidebarExpanded) {
                        FocusScope.of(context).requestFocus(_contentFocusNode);
                      }
                    }
                  }
                },
                child: Focus(
                  focusNode: _sidebarFocusNode,
                  autofocus: true,
                  child: Shortcuts(
                    shortcuts: <LogicalKeySet, Intent>{
                      LogicalKeySet(LogicalKeyboardKey.select):
                          ActivateIntent(),
                      LogicalKeySet(LogicalKeyboardKey.enter): ActivateIntent(),
                      LogicalKeySet(LogicalKeyboardKey.gameButtonA):
                          ActivateIntent(),
                    },
                    child: Actions(
                      actions: <Type, Action<Intent>>{
                        ActivateIntent: CallbackAction<ActivateIntent>(
                          onInvoke: (intent) {
                            debugPrint('Sidebar activated');
                            setState(() {
                              _isSidebarExpanded = !_isSidebarExpanded;
                            });
                            return null;
                          },
                        ),
                      },
                      child: RemoteControlWrapper(
                        onTap: () {
                          debugPrint('Sidebar tapped');
                          setState(() {
                            _isSidebarExpanded = !_isSidebarExpanded;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: _isSidebarExpanded ? maxExpWidth : minExpWidth,
                          child: Sidebar(
                            isSidebarExpanded: _isSidebarExpanded,
                            maxExpWidth: maxExpWidth,
                            minExpWidth: minExpWidth,
                            onFocus: (focused) {
                              if (focused && !_isSidebarExpanded) {
                                setState(() {
                                  _isSidebarExpanded = true;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Content
            Expanded(
              child: SafeArea(
                child: KeyboardListener(
                  focusNode: FocusNode(),
                  onKeyEvent: (KeyEvent event) {
                    if (event is KeyDownEvent) {
                      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                        FocusScope.of(context).requestFocus(_sidebarFocusNode);
                      }
                    }
                  },
                  child: Focus(
                    focusNode: _contentFocusNode,
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(_contentFocusNode);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: widget.child,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
