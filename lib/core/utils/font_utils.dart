import 'package:flutter/widgets.dart';

class FontUtils {
  /// Converts pixel-based font size to logical pixels based on devicePixelRatio
  static double pxToSp(BuildContext context, double px) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    return px / devicePixelRatio;
  }

  /// You can also just expose it as direct font size if you're not targeting pixelRatio
  /// and assuming px == sp (standard in most designs)
  static double fromPx(double px) => px;
}
