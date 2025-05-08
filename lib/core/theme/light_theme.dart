import 'package:flutter/material.dart';
import 'package:phynd_app/core/theme/app_colors.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

final lightThemeColors = {
  'bgColor': AppColors.platinum,
  'text': AppColors.black,
  'textLight': AppColors.black,
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
  'clipTextSecondary': AppColors.clipTextSecondary,
  'verifiedBadgeClip': AppColors.verifiedBadgeClip,
  'darkBlueOverlay': AppColors.darkBlueOverlay,
  'trialAvatarBorder': AppColors.trialAvatarBorder,
  'trialAvatarOverlay': AppColors.trialAvatarOverlay,
  'trialAvatarText': AppColors.trialAvatarText,
  'borderColors': AppColors.darkSlateGray,
  'instPara': AppColors.softGray,
  'buttonBg2': AppColors.gray60,
  'btnText': AppColors.darkCharcoal,
  'subText2': AppColors.platinum,
  'onlineIndicator': AppColors.limeGreen,
  'shadowBlack': AppColors.shadowBlack,
  'midnightGray': AppColors.midnightGray,
};

final ThemeData lightTheme = ThemeData(extensions: [
  AppTheme(lightThemeColors),
], fontFamily: 'Poppins');
