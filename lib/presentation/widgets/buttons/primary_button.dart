import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isTransparent;
  final IconData? icon;
  final double? iconSize;
  final double? fontSize;
  final Color? iconColor;

  const PrimaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.isTransparent = false,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme = theme.extension<AppTheme>()!;

    final bgColor = backgroundColor ??
        (isTransparent ? Colors.transparent : appTheme.get('primary'));
    final fgColor = textColor ?? appTheme.get('text');

    return RemoteControlWrapper(
      onTap: onPressed,
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: SizeUtils.pxToAllBorderRadius(context, radius: 6),
        child: Container(
          width: isFullWidth ? double.infinity : width,
          height: height ?? 48,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: SizeUtils.pxToAllBorderRadius(context, radius: 6),
            border: isTransparent
                ? Border.all(color: fgColor.withOpacity(0.3))
                : null,
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isTransparent ? fgColor : Colors.white,
                    ),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      Icon(
                        icon,
                        size: iconSize ?? SizeUtils.pxToDp(context, 40),
                        color: iconColor ?? fgColor,
                      ),
                      if (text.isNotEmpty) const SizedBox(width: 8),
                    ],
                    if (text.isNotEmpty)
                      Flexible(
                        child: Text(
                          text,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: fontSize ?? FontUtils.pxToSp(context, 25),
                            fontWeight: FontWeight.w600,
                            color: fgColor,
                            fontFamily: 'Rubik',
                          ),
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
