import 'package:flutter/material.dart';
import 'package:phynd_app/core/theme/app_colors.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

final darkThemeColors = {
  'bgColor': AppColors.darkBackground,
  'text': AppColors.white,
  'textLight': AppColors.black,
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
  'clipTextSecondary': AppColors.clipTextSecondary,
  'verifiedBadgeClip': AppColors.verifiedBadgeClip,

  'borderColors': AppColors.darkSlateGray,

  // Game Trial Card theme colors
  'trialCardBorder': AppColors.trialCardBorderColor,
  'trialCardBg': AppColors.trialCardBackground,
  'trialCardHighlight': AppColors.trialCardHighlight,
  'trialBadge': AppColors.trialBadgeColor,
  'trialBadgeText': AppColors.trialBadgeTextColor,
  'trialPrice': AppColors.trialPriceColor,
  'trialCoin': AppColors.trialCoinColor,
  'trialFriends': AppColors.trialFriendsColor,
  'trialEsrbBg': AppColors.trialEsrbBackgroundColor,
  'trialEsrbText': AppColors.trialEsrbTextColor,
  'trialAvatarBorder': AppColors.trialAvatarBorder,
  'trialAvatarOverlay': AppColors.trialAvatarOverlay,
  'trialAvatarText': AppColors.trialAvatarText,
  'instPara': AppColors.softGray,
  'buttonBg2': AppColors.gray60,
  'btnText': AppColors.darkCharcoal,
  'subText2': AppColors.platinum,
  'onlineIndicator': AppColors.limeGreen,
  'shadowBlack': AppColors.shadowBlack,
  'midnightGray': AppColors.midnightGray,
  'profileHeaderOverlay': AppColors.darkSlateOverlay,
  'favorite': AppColors.clipBadge,
  'inActiveTab': AppColors.darkSlate,
};

final ThemeData darkTheme = ThemeData(extensions: [
  AppTheme(darkThemeColors),
], fontFamily: 'Poppins');
