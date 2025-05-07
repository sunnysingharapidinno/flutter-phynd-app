import 'package:flutter/material.dart';

class SizeUtils {
  /// Converts a px value to logical pixels based on the current devicePixelRatio
  static double pxToDp(BuildContext context, double px) {
    final dpr = MediaQuery.of(context).devicePixelRatio;
    return px / dpr;
  }

  /// Converts a list of pixel values to logical pixels (e.g. EdgeInsets)
  static EdgeInsets pxToEdgeInsets(BuildContext context,
      {double left = 0, double top = 0, double right = 0, double bottom = 0}) {
    return EdgeInsets.only(
      left: pxToDp(context, left),
      top: pxToDp(context, top),
      right: pxToDp(context, right),
      bottom: pxToDp(context, bottom),
    );
  }

  /// Shortcut for symmetric padding/margin
  static EdgeInsets pxToSymmetricEdgeInsets(
    BuildContext context, {
    double vertical = 0,
    double horizontal = 0,
  }) {
    return EdgeInsets.symmetric(
      vertical: pxToDp(context, vertical),
      horizontal: pxToDp(context, horizontal),
    );
  }
}
