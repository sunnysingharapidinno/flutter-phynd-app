import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phynd_app/core/constants/remote_keys.dart';

class RemoteControlWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onFocus;
  final VoidCallback? onBlur;
  final bool autofocus;
  final FocusNode? focusNode;

  const RemoteControlWrapper({
    super.key,
    required this.child,
    this.onTap,
    this.onFocus,
    this.onBlur,
    this.autofocus = false,
    this.focusNode,
  });

  @override
  State<RemoteControlWrapper> createState() => _RemoteControlWrapperState();
}

class _RemoteControlWrapperState extends State<RemoteControlWrapper> {
  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus != _isFocused) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
      if (_isFocused) {
        widget.onFocus?.call();
      } else {
        widget.onBlur?.call();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      focusNode: _focusNode,
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
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
        LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
        LogicalKeySet(LogicalKeyboardKey.gameButtonA): const ActivateIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowUp):
            const DirectionalFocusIntent(TraversalDirection.up),
        LogicalKeySet(LogicalKeyboardKey.arrowDown):
            const DirectionalFocusIntent(TraversalDirection.down),
        LogicalKeySet(LogicalKeyboardKey.arrowLeft):
            const DirectionalFocusIntent(TraversalDirection.left),
        LogicalKeySet(LogicalKeyboardKey.arrowRight):
            const DirectionalFocusIntent(TraversalDirection.right),
      },
      child: GestureDetector(
        onTap: () {
          _focusNode.requestFocus();
          widget.onTap?.call();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            border: Border.all(
              color: _isFocused
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
