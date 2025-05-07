import 'package:flutter/material.dart';
import 'package:phynd_app/core/theme/app_colors.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

final lightThemeColors = {
  'bgColor': AppColors.platinum,
  'text': AppColors.black,
  'textSecondary': AppColors.textSecondaryLight,
  'primary': AppColors.primaryPurple,
  'secondary': AppColors.secondaryTeal,
  'tagBg': AppColors.translucentLavender,
  'cardBg': AppColors.cardLight,
  'accent': AppColors.accentGold,
  'textOnPrimary': AppColors.textOnPrimaryLight,
  'overlay': AppColors.overlayLight,
  'dividerColor': AppColors.dividerColorLight,
  'borderColor': AppColors.borderColorLight,
  'clipCardBg': AppColors.clipCardBg,
  'clipCardOverlay': AppColors.clipCardOverlay,
  'clipGradientStart': AppColors.clipCardGradientStart,
  'clipGradientEnd': AppColors.clipCardGradientEnd,
  'iconInactive': AppColors.iconInactive,
  'pillBg': AppColors.pillBackground,
  'clipTextPrimary': AppColors.clipTextPrimary,
  'clipTextSecondary': AppColors.clipTextSecondary,
  'verifiedBadgeClip': AppColors.verifiedBadgeClip,
  'darkBlueOverlay': AppColors.darkBlueOverlay,
  'trialAvatarBorder': AppColors.trialAvatarBorder,
  'trialAvatarOverlay': AppColors.trialAvatarOverlay,
  'trialAvatarText': AppColors.trialAvatarText,
  'borderColors': AppColors.darkSlateGray,
};

final ThemeData lightTheme = ThemeData(extensions: [
  AppTheme(lightThemeColors),
], fontFamily: 'Poppins');
