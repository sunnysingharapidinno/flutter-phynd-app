import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme = theme.extension<AppTheme>()!;

    return RemoteControlWrapper(
      onTap: onPressed,
      child: SizedBox(
        width: isFullWidth ? double.infinity : width,
        height: height ?? 48,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ??
                (isTransparent ? Colors.transparent : appTheme.get('primary')),
            foregroundColor: textColor ??
                (isTransparent ? appTheme.get('text') : appTheme.get('text')),
            side: isTransparent
                ? BorderSide(color: appTheme.get('text').withOpacity(0.3))
                : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isTransparent ? appTheme.get('text') : Colors.white,
                    ),
                  ),
                )
              : Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
