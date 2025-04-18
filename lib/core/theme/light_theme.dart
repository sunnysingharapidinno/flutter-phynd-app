import 'package:flutter/material.dart';
import 'package:phynd_app/core/theme/app_colors.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

final lightThemeColors = {
  'background': AppColors.white,
  'text': AppColors.black,
  'primary': AppColors.amethyst,
  'secondary': AppColors.blueMagentaViolet,
  'accent': AppColors.purple,
  'error': AppColors.red,
  'success': AppColors.green,
  'warning': AppColors.yellow,
  'info': AppColors.blue,
};

final ThemeData lightTheme = ThemeData(
  extensions: [AppTheme(lightThemeColors)],
  colorScheme: ColorScheme.light(
    primary: AppColors.amethyst,
    secondary: AppColors.blueMagentaViolet,
    error: AppColors.red,
  ),
  useMaterial3: true,
);
