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
  // bool _showIdleScreen = false; // No longer needed for overlay approach

  final FocusNode _sidebarFocusNode = FocusNode();
  final FocusNode _contentFocusNode = FocusNode();
  bool _hasContentBeenFocused = false;

  Timer? _idleTimer;
  static const _idleDuration = Duration(seconds: 3000);

  int _currentIdleIndex = 0;
  Timer? _idleScreenRotationTimer;
  OverlayEntry? _appIdleOverlayEntry; // For managing the AppIdle overlay

  final List<Map<String, dynamic>> mockGameData = [
    {
      'backgroundImg':
          'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/game-page-tv-screen/more-from-publisher/yooka-laylee-and-the-impossible-lair-walkthrough-part-1/yooka-laylee-and-the-impossible-lair-walkthrough-part-1.jpg',
      'gameTextImg':
          'https://static.wikia.nocookie.net/project-ukulele/images/5/5b/YLIL.png/revision/latest?cb=20190607204228',
      'releaseYear': '2022',
      'publisherName': 'Epic Games',
      'esrb': 'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/Teen.png',
      'friendsCount': 5,
      'onlineCount': 12,
    },
    {
      'backgroundImg':
          'https://xstrela-alpha.s3.us-east-1.amazonaws.com/palworld/Palworld.png',
      'gameTextImg': 'https://www.dafont.com/forum/attach/orig/1/1/1149828.png',
      'releaseYear': '2023',
      'publisherName': 'Ubisoft',
      'esrb': 'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/mature.png',
      'friendsCount': 8,
      'onlineCount': 20,
    },
    {
      'backgroundImg':
          'https://xstrela-alpha.s3.us-east-1.amazonaws.com/general/2025/03/15/7536ec7e66f648fdb0363440a9fc537d.jpeg',
      'gameTextImg':
          'https://upload.wikimedia.org/wikipedia/commons/4/4d/Need-For-Speed-Logo-2014-2020.png',
      'releaseYear': '2021',
      'publisherName': 'Nintendo',
      'esrb':
          'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/everyoneten.png',
      'friendsCount': 2,
      'onlineCount': 6,
    },
    {
      'backgroundImg':
          'https://images.igdb.com/igdb/image/upload/t_1080p/co2v6p.jpg',
      'gameTextImg':
          'https://static.wikia.nocookie.net/sonic/images/0/0c/Sonic_Unleashed_logo.png/revision/latest/scale-to-width-down/1200?cb=20201116084425',
      'releaseYear': '2020',
      'publisherName': 'Rockstar Games',
      'esrb': 'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/mature.png',
      'friendsCount': 10,
      'onlineCount': 34,
    },
    {
      'backgroundImg':
          'https://images.igdb.com/igdb/image/upload/t_1080p/co2t97.jpg',
      'gameTextImg':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRp2v1RsYYmLGhpLiMQQ38MSr-B0fR4dkaXkQ&s',
      'releaseYear': '2019',
      'publisherName': 'Valve',
      'esrb': 'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/Teen.png',
      'friendsCount': 3,
      'onlineCount': 7,
    },
  ];

  void _showAppIdleOverlay() {
    if (_appIdleOverlayEntry != null) return;
    print("BaseLayout: Showing AppIdle overlay."); // Added for debugging

    _currentIdleIndex = 0;
    _appIdleOverlayEntry = OverlayEntry(
      builder: (context) {
        return Material(
          type: MaterialType.transparency,
          child: AppIdle(
            key: ValueKey(_currentIdleIndex),
            backgroundImg: mockGameData[_currentIdleIndex]['backgroundImg'],
            esrb: mockGameData[_currentIdleIndex]['esrb'],
            friendsCount: mockGameData[_currentIdleIndex]['friendsCount'],
            gameTextImg: mockGameData[_currentIdleIndex]['gameTextImg'],
            onlineCount: mockGameData[_currentIdleIndex]['onlineCount'],
            publisherName: mockGameData[_currentIdleIndex]['publisherName'],
            releaseYear: mockGameData[_currentIdleIndex]['releaseYear'],
          ),
        );
      },
    );
    Overlay.of(context).insert(_appIdleOverlayEntry!);

    _idleScreenRotationTimer?.cancel();
    _idleScreenRotationTimer =
        Timer.periodic(const Duration(seconds: 30), (timer) {
      if (mounted && _appIdleOverlayEntry != null) {
        // print("BaseLayout: Rotating idle screen content."); // Optional: for very verbose logging
        setState(() {
          _currentIdleIndex = (_currentIdleIndex + 1) % mockGameData.length;
        });
        _appIdleOverlayEntry?.markNeedsBuild();
      } else {
        timer.cancel();
      }
    });
  }

  void _removeAppIdleOverlay() {
    print("BaseLayout: _removeAppIdleOverlay called"); // Debug print
    _appIdleOverlayEntry?.remove();
    _appIdleOverlayEntry = null;
    _idleScreenRotationTimer?.cancel();
  }

  void _startIdleTimer() {
    _idleTimer?.cancel();
    _idleTimer = Timer(_idleDuration, () {
      print("BaseLayout: Idle timer expired."); // Debug print
      if (mounted) {
        _showAppIdleOverlay();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    print("BaseLayout: initState - starting idle timer."); // Debug print
    _startIdleTimer();

    _sidebarFocusNode.addListener(() {
      // print("Sidebar focus: ${_sidebarFocusNode.hasFocus}"); // Debug focus changes
      if (_sidebarFocusNode.hasFocus && _hasContentBeenFocused) {
        if (mounted) {
          setState(() {
            _isSidebarExpanded = true;
          });
        }
      }
    });

    _contentFocusNode.addListener(() {
      // print("Content focus: ${_contentFocusNode.hasFocus}"); // Debug focus changes
      if (_contentFocusNode.hasFocus) {
        _hasContentBeenFocused = true;
        if (mounted) {
          setState(() {
            _isSidebarExpanded = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    print("BaseLayout: dispose called."); // Debug print
    _idleTimer?.cancel();
    _removeAppIdleOverlay();
    _sidebarFocusNode.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  void _onUserInteraction() {
    print("BaseLayout: _onUserInteraction triggered!"); // Debug print
    _startIdleTimer();
    if (_appIdleOverlayEntry != null) {
      _removeAppIdleOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final backgroundColor = theme?.get('bgColor') ?? Colors.black;
    final double minExpWidth = SizeUtils.pxToDp(context, 100);
    final double maxExpWidth = SizeUtils.pxToDp(context, 400);

    return Listener(
      onPointerDown: (_) =>
          _onUserInteraction(), // Only listen to onPointerDown for now
      // onPointerMove: (_) => _onUserInteraction(), // Temporarily disable
      // onPointerHover: (_) => _onUserInteraction(), // Temporarily disable
      child: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (_) => _onUserInteraction(),
        child: Scaffold(
          // Removed the conditional logic for _showIdleScreen
          key: _scaffoldKey,
          backgroundColor: backgroundColor,
          appBar: SharedAppBar(),
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
                                  if (mounted) {
                                    setState(() {
                                      _isSidebarExpanded = !_isSidebarExpanded;
                                    });
                                  }
                                  return null;
                                },
                              ),
                            },
                            child: RemoteControlWrapper(
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    _isSidebarExpanded = !_isSidebarExpanded;
                                  });
                                }
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
                                      if (mounted) {
                                        setState(() {
                                          _isSidebarExpanded = true;
                                        });
                                      }
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
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    0, 0, 0, SizeUtils.pxToDp(context, 48)),
                                child: widget.child,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
