import 'package:flutter/material.dart';
import 'package:phynd_app/core/theme/app_colors.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

final darkThemeColors = {
  'bgColor': AppColors.darkBackground,
  'text': AppColors.white,
  'textSecondary': AppColors.textSecondaryDark,
  'primary': AppColors.primaryPurple,
  'secondary': AppColors.secondaryTeal,
  'tagBg': AppColors.translucentLavender,
  'cardBg': AppColors.darkCardBg,
  'accent': AppColors.accentGold,
  'textOnPrimary': AppColors.textOnPrimaryDark,
  'overlay': AppColors.overlayDark,
  'dividerColor': AppColors.dividerColorDark,
  'borderColor': AppColors.borderColorDark,
  'clipCardBg': AppColors.clipCardBg,
  'clipCardOverlay': AppColors.clipCardOverlay,
  'clipGradientStart': AppColors.clipCardGradientStart,
  'clipGradientEnd': AppColors.clipCardGradientEnd,
  'darkBlueOverlay': AppColors.darkBlueOverlay,
  'iconInactive': AppColors.iconInactive,
  'pillBg': AppColors.pillBackground,
  'clipTextPrimary': AppColors.clipTextPrimary,
  'clipTextSecondary': AppColors.clipTextSecondary,
  'verifiedBadgeClip': AppColors.verifiedBadgeClip,
};

final ThemeData darkTheme = ThemeData(extensions: [AppTheme(darkThemeColors)]);
