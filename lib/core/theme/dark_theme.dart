import 'package:flutter/material.dart';
import 'package:phynd_app/core/theme/app_colors.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

final darkThemeColors = {
  'bgColor': AppColors.charcoalBlue,
  'text': AppColors.white,
  'textSecondary': AppColors.textSecondaryDark,
  'primary': AppColors.amethyst,
  'tagBg': AppColors.translucentLavender,
  'cardBg': AppColors.cardDark,
  'accent': AppColors.accentGold,
  'textOnPrimary': AppColors.textOnPrimaryDark,
  'overlay': AppColors.overlayDark,
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
