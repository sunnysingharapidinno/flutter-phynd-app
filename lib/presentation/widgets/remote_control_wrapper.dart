import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RemoteControlWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onFocus;
  final VoidCallback? onBlur;
  final bool autofocus;

  const RemoteControlWrapper({
    super.key,
    required this.child,
    this.onTap,
    this.onFocus,
    this.onBlur,
    this.autofocus = false,
  });

  @override
  State<RemoteControlWrapper> createState() => _RemoteControlWrapperState();
}

class _RemoteControlWrapperState extends State<RemoteControlWrapper> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      autofocus: widget.autofocus,
      onShowFocusHighlight: (_) {},
      onShowHoverHighlight: (_) {},
      onFocusChange: (focused) {
        setState(() {
          _isFocused = focused;
        });
        if (focused) {
          widget.onFocus?.call();
        } else {
          widget.onBlur?.call();
        }
      },
      actions: {
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (intent) => widget.onTap?.call(),
        ),
      },
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): ActivateIntent(),
        LogicalKeySet(LogicalKeyboardKey.enter): ActivateIntent(),
        LogicalKeySet(LogicalKeyboardKey.gameButtonA): ActivateIntent(),
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          border: Border.all(
            color: _isFocused
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
            width: 3,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
