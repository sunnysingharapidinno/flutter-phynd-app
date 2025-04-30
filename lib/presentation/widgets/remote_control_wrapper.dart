import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phynd_app/core/constants/remote_keys.dart';

class RemoteControlWrapper extends StatefulWidget {
  final Widget child;
  final Function(KeyEvent)? onKey;
  final Function()? onUp;
  final Function()? onDown;
  final Function()? onLeft;
  final Function()? onRight;
  final Function()? onEnter;
  final Function()? onBack;
  final Function()? onRed;
  final Function()? onGreen;
  final Function()? onYellow;
  final Function()? onBlue;
  final Function()? onPlay;
  final Function()? onPause;
  final Function()? onStop;
  final Function()? onTap;
  final bool autofocus;
  final FocusNode? focusNode;

  const RemoteControlWrapper({
    Key? key,
    required this.child,
    this.onKey,
    this.onUp,
    this.onDown,
    this.onLeft,
    this.onRight,
    this.onEnter,
    this.onBack,
    this.onRed,
    this.onGreen,
    this.onYellow,
    this.onBlue,
    this.onPlay,
    this.onPause,
    this.onStop,
    this.onTap,
    this.autofocus = true,
    this.focusNode,
  }) : super(key: key);

  @override
  State<RemoteControlWrapper> createState() => _RemoteControlWrapperState();
}

class _RemoteControlWrapperState extends State<RemoteControlWrapper> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    final logicalKey = event.logicalKey;
    widget.onKey?.call(event);
    debugPrint('Remote key press: ${logicalKey.keyId}');

    switch (logicalKey.keyId) {
      case RemoteKeys.KEY_UP:
        widget.onUp?.call();
        return KeyEventResult.handled;
      case RemoteKeys.KEY_DOWN:
        widget.onDown?.call();
        return KeyEventResult.handled;
      case RemoteKeys.KEY_LEFT:
        widget.onLeft?.call();
        return KeyEventResult.handled;
      case RemoteKeys.KEY_RIGHT:
        widget.onRight?.call();
        return KeyEventResult.handled;
      case RemoteKeys.KEY_ENTER:
        widget.onEnter?.call();
        widget.onTap?.call(); // Also trigger tap on enter key
        return KeyEventResult.handled;
      case RemoteKeys.KEY_BACK:
      case RemoteKeys.KEY_RETURN:
        widget.onBack?.call();
        return KeyEventResult.handled;
      case RemoteKeys.KEY_RED:
        widget.onRed?.call();
        return KeyEventResult.handled;
      case RemoteKeys.KEY_GREEN:
        widget.onGreen?.call();
        return KeyEventResult.handled;
      case RemoteKeys.KEY_YELLOW:
        widget.onYellow?.call();
        return KeyEventResult.handled;
      case RemoteKeys.KEY_BLUE:
        widget.onBlue?.call();
        return KeyEventResult.handled;
      case RemoteKeys.KEY_PLAY:
      case RemoteKeys.KEY_PLAY_PAUSE:
        widget.onPlay?.call();
        return KeyEventResult.handled;
      case RemoteKeys.KEY_PAUSE:
        widget.onPause?.call();
        return KeyEventResult.handled;
      case RemoteKeys.KEY_STOP:
        widget.onStop?.call();
        return KeyEventResult.handled;
      default:
        return KeyEventResult.ignored;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_focusNode);
      },
      behavior: HitTestBehavior.translucent,
      child: Focus(
        focusNode: _focusNode,
        autofocus: widget.autofocus,
        onKeyEvent: _handleKeyEvent,
        child: Builder(
          builder: (context) {
            final isFocused = Focus.of(context).hasFocus;

            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    widget.onTap?.call();
                    FocusScope.of(context).requestFocus(_focusNode);
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isFocused
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                        width: 3,
                      ),
                      boxShadow: isFocused
                          ? [
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.5),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: widget.child,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
