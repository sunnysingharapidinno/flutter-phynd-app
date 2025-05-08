class ResponsiveHelper {
  static double getResponsiveSize(
      double screenWidth, double baseSize, List<double> sizes) {
    // Fixed breakpoints
    final breakpoints = [3840.0, 3200.0, 2560.0, 1200.0];

    // Find the first breakpoint that matches the screen width
    for (int i = 0; i < breakpoints.length; i++) {
      if (screenWidth >= breakpoints[i]) {
        return sizes[i];
      }
    }

    return baseSize;
  }

  /// Returns a responsive aspect ratio based on screen width.
  ///
  /// [screenWidth] - The current screen width
  /// [baseRatio] - The base aspect ratio to use for smaller screens
  /// [ratios] - List of aspect ratios for different breakpoints
  ///
  /// Example usage:
  /// ```dart
  /// final ratio = ResponsiveHelper.getResponsiveRatio(
  ///   screenWidth,
  ///   16/9,  // base ratio
  ///   [21/9, 18/9, 16/9, 4/3]  // ratios for different breakpoints
  /// );
  /// ```
  static double getResponsiveRatio(
      double screenWidth, double baseRatio, List<double> ratios) {
    // Fixed breakpoints
    final breakpoints = [3840.0, 3200.0, 2560.0, 1200.0];

    // Find the first breakpoint that matches the screen width
    for (int i = 0; i < breakpoints.length; i++) {
      if (screenWidth >= breakpoints[i]) {
        return ratios[i];
      }
    }

    return baseRatio;
  }
}
