import 'package:flutter/material.dart';

class SizeUtils {
  /// Converts a px value to logical pixels based on the current devicePixelRatio
  static double pxToDp(BuildContext context, double? px) {
    final dpr = MediaQuery.of(context).devicePixelRatio;
    return px != null ? px / dpr : 0;
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

  /// Converts px values to BorderRadius based on the current devicePixelRatio
  static BorderRadius pxToBorderRadius(BuildContext context,
      {double topLeft = 0,
      double topRight = 0,
      double bottomLeft = 0,
      double bottomRight = 0}) {
    return BorderRadius.only(
      topLeft: Radius.circular(pxToDp(context, topLeft)),
      topRight: Radius.circular(pxToDp(context, topRight)),
      bottomLeft: Radius.circular(pxToDp(context, bottomLeft)),
      bottomRight: Radius.circular(pxToDp(context, bottomRight)),
    );
  }

  /// Shortcut for uniform BorderRadius
  static BorderRadius pxToAllBorderRadius(BuildContext context,
      {double radius = 0}) {
    return BorderRadius.all(Radius.circular(pxToDp(context, radius)));
  }
}
