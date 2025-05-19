import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/widgets/app_idle.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';
import 'package:phynd_app/presentation/widgets/shared_app_bar.dart';
import 'package:phynd_app/presentation/widgets/sidebar.dart';
import 'package:phynd_app/data/models/response/screen_saver_setting_model.dart';

class BaseLayout extends StatefulWidget {
  final Widget child;
  final bool isFullScreen;
  final int screenId;

  const BaseLayout({
    super.key,
    required this.child,
    this.isFullScreen = false,
    this.screenId = 1,
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
  final FocusNode _baseLayoutKeyboardListenerFocusNode =
      FocusNode(); // Managed FocusNode

  final GameService _gameService = GameService();

  // int screenTimeOut = 0; // Unused variable

  // Timer? _idleTimer; // Unused variable
  // static const _idleDuration = Duration(seconds: 0);

  Timer? _screenSaverTimer;
  bool _showScreenSaver = false;

  // Variables to store fetched screen saver settings and manage fetching state
  ScreenSaverSettingModel? _fetchedScreenSaverSetting;
  bool _isFetchingSettings = false;

  int _currentIdleIndex = 0;
  Timer? _idleScreenRotationTimer;
  static const Duration _idleRotationDuration = Duration(seconds: 5);

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

  @override
  void initState() {
    super.initState();
    getScreenSaverSetting();
  }

  @override
  void dispose() {
    // _idleTimer?.cancel(); // Was already commented or removed if unused
    _screenSaverTimer?.cancel();
    _idleScreenRotationTimer?.cancel();
    _sidebarFocusNode.dispose();
    _contentFocusNode.dispose();
    _baseLayoutKeyboardListenerFocusNode.dispose();
    super.dispose();
  }

  Future<void> getScreenSaverSetting() async {
    // Always cancel the current timer when this function is called to reset inactivity
    _screenSaverTimer?.cancel();

    // Check if settings are already being fetched to avoid concurrent calls
    if (_isFetchingSettings) return;

    // Fetch settings only if they haven't been fetched before
    if (_fetchedScreenSaverSetting == null) {
      _isFetchingSettings = true;
      try {
        final screenSaverSetting =
            await _gameService.getScreenSaverSetting(screenId: widget.screenId);
        if (mounted) {
          // Store the fetched settings
          _fetchedScreenSaverSetting = screenSaverSetting;
        }
      } catch (e) {
        debugPrint('Error fetching screen saver setting: ${e.toString()}');
        // Optionally, handle the error, e.g., by using default settings or preventing timer start
        _isFetchingSettings = false;
        return; // Early return if fetching failed
      } finally {
        _isFetchingSettings = false;
      }
    }

    // Proceed to set/reset the timer only if settings are available
    if (_fetchedScreenSaverSetting != null &&
        _fetchedScreenSaverSetting!.timeOutSeconds != null) {
      _screenSaverTimer = Timer(
          Duration(seconds: _fetchedScreenSaverSetting!.timeOutSeconds!), () {
        // debugPrint('Screen saver timeout reached. Timeout was: ${_fetchedScreenSaverSetting!.timeOutSeconds}s');
        if (mounted) {
          // Ensure widget is still mounted before calling setState
          setState(() {
            _showScreenSaver = true;
            _currentIdleIndex = 0; // Reset idle index when screensaver starts
          });
          _startIdleScreenRotation();
        }
      });
    } else {
      debugPrint('Screen saver settings not available, timer not started.');
    }
  }

  void _startIdleScreenRotation() {
    _idleScreenRotationTimer?.cancel();
    if (_showScreenSaver && mockGameData.isNotEmpty) {
      _idleScreenRotationTimer = Timer.periodic(_idleRotationDuration, (timer) {
        _rotateIdleScreen();
      });
    }
  }

  void _rotateIdleScreen() {
    if (mounted && _showScreenSaver && mockGameData.isNotEmpty) {
      setState(() {
        _currentIdleIndex = (_currentIdleIndex + 1) % mockGameData.length;
      });
    } else {
      _idleScreenRotationTimer?.cancel();
    }
  }

  void _hideScreenSaver() {
    if (mounted && _showScreenSaver) {
      setState(() {
        _showScreenSaver = false;
      });
      _idleScreenRotationTimer?.cancel();
      getScreenSaverSetting();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final backgroundColor = theme?.get('bgColor');
    final double minExpWidth = SizeUtils.pxToDp(context, 100);
    final double maxExpWidth = SizeUtils.pxToDp(context, 400);

    return KeyboardListener(
      focusNode: _baseLayoutKeyboardListenerFocusNode,
      onKeyEvent: (KeyEvent event) {
        if (_showScreenSaver) {
          _hideScreenSaver();
        } else {
          getScreenSaverSetting();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: backgroundColor,
        appBar: !widget.isFullScreen && !_showScreenSaver
            ? const SharedAppBar()
            : null,
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
                        FocusScope.of(context).requestFocus(_contentFocusNode);
                      }
                    },
                    child: Focus(
                      focusNode: _sidebarFocusNode,
                      autofocus: true,
                      child: Shortcuts(
                        shortcuts: {
                          LogicalKeySet(LogicalKeyboardKey.select):
                              const ActivateIntent(),
                          LogicalKeySet(LogicalKeyboardKey.enter):
                              const ActivateIntent(),
                          LogicalKeySet(LogicalKeyboardKey.gameButtonA):
                              const ActivateIntent(),
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
                            event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                          FocusScope.of(context)
                              .requestFocus(_sidebarFocusNode);
                        }
                      },
                      child: Focus(
                        focusNode: _contentFocusNode,
                        child: GestureDetector(
                          onTap: () {
                            if (_showScreenSaver) {
                              _hideScreenSaver();
                            } else {
                              getScreenSaverSetting();
                              FocusScope.of(context)
                                  .requestFocus(_contentFocusNode);
                            }
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: widget.isFullScreen
                                ? widget.child
                                : Padding(
                                    padding: EdgeInsets.only(
                                        bottom: SizeUtils.pxToDp(context, 40)),
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
            _showScreenSaver && mockGameData.isNotEmpty
                ? Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AppIdle(
                      backgroundImg: mockGameData[_currentIdleIndex]
                          ['backgroundImg'],
                      gameTextImg: mockGameData[_currentIdleIndex]
                          ['gameTextImg'],
                      releaseYear: mockGameData[_currentIdleIndex]
                          ['releaseYear'],
                      publisherName: mockGameData[_currentIdleIndex]
                          ['publisherName'],
                      esrb: mockGameData[_currentIdleIndex]['esrb'],
                      friendsCount: mockGameData[_currentIdleIndex]
                          ['friendsCount'],
                      onlineCount: mockGameData[_currentIdleIndex]
                          ['onlineCount'],
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
