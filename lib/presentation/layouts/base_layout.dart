import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/widgets/app_idle.dart';
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
  bool _showIdleScreen = false;

  final FocusNode _sidebarFocusNode = FocusNode();
  final FocusNode _contentFocusNode = FocusNode();
  bool _hasContentBeenFocused = false;

  Timer? _idleTimer;
  static const _idleDuration = Duration(seconds: 30);

  @override
  void initState() {
    super.initState();
    _startIdleTimer();

    _sidebarFocusNode.addListener(() {
      if (_sidebarFocusNode.hasFocus && _hasContentBeenFocused) {
        setState(() {
          _isSidebarExpanded = true;
        });
      }
    });

    _contentFocusNode.addListener(() {
      if (_contentFocusNode.hasFocus) {
        _hasContentBeenFocused = true;
        setState(() {
          _isSidebarExpanded = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _idleTimer?.cancel();
    _sidebarFocusNode.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  void _startIdleTimer() {
    _idleTimer?.cancel();
    _idleTimer = Timer(_idleDuration, () {
      setState(() {
        _showIdleScreen = true;
      });
    });
  }

  void _onUserInteraction() {
    _startIdleTimer();
    if (_showIdleScreen) {
      setState(() {
        _showIdleScreen = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final backgroundColor = theme?.get('bgColor') ?? Colors.black;

    final double minExpWidth = SizeUtils.pxToDp(context, 100);
    final double maxExpWidth = SizeUtils.pxToDp(context, 400);

    return Listener(
      onPointerDown: (_) => _onUserInteraction(),
      onPointerMove: (_) => _onUserInteraction(),
      onPointerHover: (_) => _onUserInteraction(),
      child: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (_) => _onUserInteraction(),
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: backgroundColor,
          appBar: _showIdleScreen ? null : SharedAppBar(),
          body: Stack(
            children: [
              Row(
                children: [
                  // Sidebar
                  FocusTraversalGroup(
                    child: KeyboardListener(
                      focusNode: FocusNode(),
                      onKeyEvent: (KeyEvent event) {
                        if (event is KeyDownEvent &&
                            event.logicalKey == LogicalKeyboardKey.arrowRight &&
                            !_isSidebarExpanded) {
                          FocusScope.of(context)
                              .requestFocus(_contentFocusNode);
                        }
                      },
                      child: Focus(
                        focusNode: _sidebarFocusNode,
                        autofocus: true,
                        child: Shortcuts(
                          shortcuts: {
                            LogicalKeySet(LogicalKeyboardKey.select):
                                ActivateIntent(),
                            LogicalKeySet(LogicalKeyboardKey.enter):
                                ActivateIntent(),
                            LogicalKeySet(LogicalKeyboardKey.gameButtonA):
                                ActivateIntent(),
                          },
                          child: Actions(
                            actions: {
                              ActivateIntent: CallbackAction<Intent>(
                                onInvoke: (_) {
                                  setState(() {
                                    _isSidebarExpanded = !_isSidebarExpanded;
                                  });
                                  return null;
                                },
                              ),
                            },
                            child: RemoteControlWrapper(
                              onTap: () {
                                setState(() {
                                  _isSidebarExpanded = !_isSidebarExpanded;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: _isSidebarExpanded
                                    ? maxExpWidth
                                    : minExpWidth,
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
                  // Main content
                  Expanded(
                    child: SafeArea(
                      child: KeyboardListener(
                        focusNode: FocusNode(),
                        onKeyEvent: (KeyEvent event) {
                          if (event is KeyDownEvent &&
                              event.logicalKey ==
                                  LogicalKeyboardKey.arrowLeft) {
                            FocusScope.of(context)
                                .requestFocus(_sidebarFocusNode);
                          }
                        },
                        child: Focus(
                          focusNode: _contentFocusNode,
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(_contentFocusNode);
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
              ),
              // Idle overlay (only shown when idle)
              if (_showIdleScreen)
                Positioned.fill(
                  child: AppIdle(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
