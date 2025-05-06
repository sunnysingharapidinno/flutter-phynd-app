import 'package:flutter/material.dart';

enum ButtonVariant {
  primary,
  secondary,
  transparent,
  icon,
}

class Button extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final ButtonVariant variant;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final bool isCircular;

  const Button({
    super.key,
    this.text,
    this.icon,
    this.variant = ButtonVariant.primary,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.height = 48.0,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.isCircular = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: _getButtonStyle(context),
        child: _buildChild(),
      ),
    );
  }

  Widget _buildChild() {
    if (isLoading) {
      return const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    if (variant == ButtonVariant.icon && icon != null) {
      return Icon(icon);
    }

    if (text != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20),
            const SizedBox(width: 8),
          ],
          Text(
            text!,
            style: _getTextStyle(),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    final shape = isCircular
        ? const CircleBorder()
        : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          );

    switch (variant) {
      case ButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          shape: shape,
          padding: padding,
        );
      case ButtonVariant.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[200],
          foregroundColor: Colors.black87,
          shape: shape.copyWith(
            side: const BorderSide(color: Colors.white, width: 1),
          ),
          padding: padding,
        );
      case ButtonVariant.transparent:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.2),
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: shape,
          padding: padding,
        );
      case ButtonVariant.icon:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.2),
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: shape,
          padding: const EdgeInsets.all(8),
        );
    }
  }

  TextStyle _getTextStyle() {
    switch (variant) {
      case ButtonVariant.primary:
        return const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        );
      case ButtonVariant.secondary:
        return const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        );
      case ButtonVariant.transparent:
        return const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        );
      case ButtonVariant.icon:
        return const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        );
    }
  }
}
