import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/size_utils.dart';

class SharedModal {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    bool barrierDismissible = true,
    Color? backgroundColor,
    double? borderRadius,
    double? height,
    double? width,
  }) {
    final theme = Theme.of(context).extension<AppTheme>();
    final bgColor = theme?.get('bgColor');

    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: SizeUtils.pxToAllBorderRadius(context,
                radius: borderRadius ?? 16),
          ),
          backgroundColor: backgroundColor ?? bgColor,
          child: SizedBox(
            height: height,
            width: SizeUtils.pxToDp(context, width ?? 850),
            child: child,
          ),
        );
      },
    );
  }
}
