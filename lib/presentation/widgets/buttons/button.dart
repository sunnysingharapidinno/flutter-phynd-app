import 'package:flutter/material.dart';
import 'package:phynd_app/core/helpers/responsive_helper.dart';

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
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double iconSize;
  final bool isCircular;

  const Button({
    super.key,
    this.text,
    this.icon,
    this.variant = ButtonVariant.primary,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black87,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    this.iconSize = 20.0,
    this.isCircular = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Get responsive sizes
    final baseIconSize = variant == ButtonVariant.icon ? 24.0 : 20.0;
    final iconSizes = variant == ButtonVariant.icon
        ? [48.0, 40.0, 32.0, 24.0]
        : [32.0, 28.0, 24.0, 20.0];

    final actualIconSize = ResponsiveHelper.getResponsiveSize(
      screenWidth,
      baseIconSize,
      iconSizes,
    );

    final actualPadding = ResponsiveHelper.getResponsiveSize(
      screenWidth,
      20.0,
      [42.0, 36.0, 32.0, 20.0],
    );

    final actualBorderRadius = ResponsiveHelper.getResponsiveSize(
      screenWidth,
      borderRadius,
      [12.0, 10.0, 8.0, 8.0],
    );

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: actualIconSize * 2,
        minWidth: variant == ButtonVariant.icon ? actualIconSize * 2 : 0,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: _getButtonStyle(context, actualBorderRadius, actualPadding),
        child: _buildChild(context, actualIconSize),
      ),
    );
  }

  Widget _buildChild(BuildContext context, double iconSize) {
    if (isLoading) {
      return SizedBox(
        width: iconSize,
        height: iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(_getTextColor(context)),
        ),
      );
    }

    if (variant == ButtonVariant.icon && icon != null) {
      return Icon(icon, size: iconSize, color: _getTextColor(context));
    }

    if (text == null && icon != null) {
      return Icon(icon, size: iconSize, color: _getTextColor(context));
    }

    if (text == null && icon == null) {
      return const SizedBox.shrink();
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final baseSize = variant == ButtonVariant.icon ? 16.0 : 25.0;
    final sizes = variant == ButtonVariant.icon
        ? [42.0, 32.0, 24.0, 16.0]
        : [42.0, 32.0, 24.0, 18.0];

    final fontSize = ResponsiveHelper.getResponsiveSize(
      screenWidth,
      baseSize,
      sizes,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: iconSize, color: _getTextColor(context)),
          if (text != null) SizedBox(width: iconSize * 0.4),
        ],
        if (text != null)
          Flexible(
            child: Text(
              text!,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                color: _getTextColor(context),
                fontFamily: 'Rubik',
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }

  Color _getTextColor(BuildContext context) {
    switch (variant) {
      case ButtonVariant.secondary:
        return Colors.black87;
      case ButtonVariant.primary:
      case ButtonVariant.transparent:
      case ButtonVariant.icon:
        return Colors.white;
    }
  }

  ButtonStyle _getButtonStyle(
      BuildContext context, double borderRadius, double padding) {
    final shape = (variant == ButtonVariant.icon || isCircular)
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
          padding: EdgeInsets.symmetric(
            horizontal: padding,
            vertical: padding * 0.5,
          ),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
      case ButtonVariant.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[200],
          foregroundColor: Colors.black87,
          shape: shape.copyWith(
            side: const BorderSide(color: Colors.white, width: 1),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: padding,
            vertical: padding * 0.5,
          ),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
      case ButtonVariant.transparent:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.2),
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: shape,
          padding: EdgeInsets.symmetric(
            horizontal: padding,
            vertical: padding * 0.5,
          ),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
      case ButtonVariant.icon:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.2),
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: shape,
          padding: EdgeInsets.all(padding * 0.4),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
    }
  }
}
