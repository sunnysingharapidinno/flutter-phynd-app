import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color amethyst = Color(0xFF9163CC);
  static const Color offWhite = Color(0xFFF7F7F7);
  static const Color blueMagentaViolet = Color(0xFF5B2E95);
  static const Color graniteGray = Color(0xFF292D32);
  static const Color red = Color(0xFFE52A2A);
  static const Color green = Color(0xFF008000);
  static const Color blue = Color(0xFF0000FF);
  static const Color yellow = Color(0xFFFFFF00);
  static const Color orange = Color(0xFFFFA500);
  static const Color purple = Color(0xFF800080);
  static const Color charcoalBlue = Color(0xFF1B1D26);
  static const Color platinum = Color(0xFFE0E0E0);
  static const Color translucentLavender = Color(0xCDF4F3FC);

  // Dark theme colors
  static const Color darkBackground = Color(0xFF1B1D26);
  static const Color darkCardBg = Color(0xFF1E1E1E);

  // Primary and secondary colors
  static const Color primaryPurple = Color(0xFF6200EE);
  static const Color secondaryTeal = Color(0xFF03DAC6);

  // Divider colors
  static Color dividerColorDark = Colors.grey.withOpacity(0.3);
  static Color borderColorDark = Colors.grey.withOpacity(0.2);
  static Color dividerColorLight = Colors.grey.withOpacity(0.2);
  static Color borderColorLight = Colors.grey.withOpacity(0.1);

  // Card colors
  static const Color cardLight = Color(0xFFF5F5F5);
  static const Color cardDark = Color(0xFF2A2A2A);

  // Accent colors
  static const Color accentGold = Color(0xFFFFD700);
  static const Color accentPurple = Color(0xFF9C27B0);

  // Text colors
  static const Color textOnPrimaryLight = Color(0xFFFFFFFF);
  static const Color textOnPrimaryDark = Color(0xFFFFFFFF);

  // Secondary text colors
  static const Color textSecondaryLight = Color(0xFF333333);
  static const Color textSecondaryDark = Color(0xFFE0E0E0);

  // Overlay colors
  static const Color overlayDark = Color(0xCC000000); // 80% opacity black
  static const Color overlayLight = Color(0x99000000); // 60% opacity black
  static const Color darkBlueOverlay =
      Color(0xFF0D132C); // Dark blue for game card gradients

  // Verified badge color
  static const Color verifiedBadge = Color(0xFF1DA1F2); // Twitter blue

  // Game clip card colors
  static const Color clipCardBg = Color(0xFF0A0A0A); // Almost black background
  static const Color clipCardOverlay = Color(0xB3000000); // 70% black overlay
  static const Color clipCardGradientStart = Colors.transparent;
  static const Color clipCardGradientEnd =
      Color(0xFF000000); // Full black for gradient
  static const Color iconInactive =
      Color(0xFFE0E0E0); // Very light gray for icons
  static const Color pillBackground = Color(0xCC000000); // 80% black for pills
  static const Color clipBadge =
      Color(0xFFE91E63); // Pink badge background for clip time
  static const Color clipTextPrimary = Color(0xFFFFFFFF); // Pure white
  static const Color clipTextSecondary =
      Color(0xFFE0E0E0); // Light gray for secondary text
  static const Color verifiedBadgeClip =
      Color(0xFF00B0FF); // Brighter blue for verified badge

  // Game play card colors
  static const Color gameCardTagColor =
      Color(0xFF4CAF50); // Green for "FREE" tag
  static const Color gameCardRatingColor =
      Color(0xFFFFC107); // Amber for star ratings
  static const Color gameCardEsrbBg =
      Color(0xFFFFFFFF); // White for ESRB background
  static const Color gameCardEsrbText =
      Color(0xFF000000); // Black for ESRB text
  static const Color gameCardEsrbBorder =
      Color(0xFF000000); // Black for ESRB border

  // Free play card colors
  static const Color freePlayBadgeBg =
      Color(0xCC000000); // Semi-transparent black for badge
  static const Color freePlayFreeTagBg =
      Color(0xFF4CAF50); // Green for FREE tag
  static const Color freePlayGradientStart =
      Color(0xCC000000); // 80% black for bottom gradient
  static const Color freePlayGradientEnd =
      Color(0x00000000); // Transparent for top gradient
  static const Color freePlayStarColor =
      Color(0xFFFFC107); // Amber for star ratings

  // Game Trial Card colors
  static const Color trialCardBorderColor =
      Color(0xFF2D2F3E); // Border for trial card
  static const Color trialCardBackground =
      Color(0xFF1A1C25); // Dark background for trial card
  static const Color trialCardHighlight =
      Color(0xFF3A3E52); // Highlighted elements in trial card
  static const Color trialBadgeColor =
      Color(0xFF3E4C8A); // Blue for "Free Trial" badge
  static const Color trialBadgeTextColor =
      Color(0xFFFFFFFF); // White text for badges
  static const Color trialPriceColor = Color(0xFF43B581); // Green for price
  static const Color trialCoinColor = Color(0xFFFFC857); // Gold color for coins
  static const Color trialFriendsColor =
      Color(0xFF8A8D96); // Gray for friends text
  static const Color trialEsrbBackgroundColor =
      Color(0xFFFFFFFF); // White for ESRB background
  static const Color trialEsrbTextColor =
      Color(0xFF000000); // Black for ESRB text

  // Friend Avatar Colors
  static const Color trialAvatarBorder = Colors.white;
  static const Color trialAvatarOverlay =
      Color(0x99000000); // black with 60% opacity
  static const Color trialAvatarText = Colors.white;
}
