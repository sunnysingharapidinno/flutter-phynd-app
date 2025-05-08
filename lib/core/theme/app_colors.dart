import 'package:flutter/material.dart';

class AppColors {
  // Basic Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color red = Color(0xFFE52A2A);
  static const Color green = Color(0xFF008000);
  static const Color blue = Color(0xFF0000FF);
  static const Color yellow = Color(0xFFFFFF00);
  static const Color orange = Color(0xFFFFA500);
  static const Color purple = Color(0xFF800080);

  // Grays & Neutrals
  static const Color offWhite = Color(0xFFF7F7F7);
  static const Color graniteGray = Color(0xFF292D32);
  static const Color platinum = Color(0xFFE0E0E0);
  static const Color darkSlateGray = Color(0xFF313544);

  // Purples
  static const Color amethyst = Color(0xFF9163CC);
  static const Color blueMagentaViolet = Color(0xFF5B2E95);
  static const Color primaryPurple = Color(0xFF6200EE);
  static const Color accentPurple = Color(0xFF9C27B0);

  // Teals
  static const Color secondaryTeal = Color(0xFF03DAC6);

  // Theme backgrounds
  static const Color darkBackground = Color(0xFF1B1D26);
  static const Color darkCardBg = Color(0xFF1E1E1E);
  static const Color cardLight = Color(0xFFF5F5F5);
  static const Color cardDark = Color(0xFF2A2A2A);

  // Dividers & borders
  static Color dividerColorDark = Colors.grey.withOpacity(0.3);
  static Color borderColorDark = Colors.grey.withOpacity(0.2);
  static Color dividerColorLight = Colors.grey.withOpacity(0.2);
  static Color borderColorLight = Colors.grey.withOpacity(0.1);

  // Overlays
  static const Color overlayDark = Color(0xCC000000); // 80%
  static const Color overlayLight = Color(0x99000000); // 60%
  static const Color darkBlueOverlay = Color(0xFF0D132C);
  static const Color translucentLavender = Color(0xCDF4F3FC);

  // Accent
  static const Color accentGold = Color(0xFFFFD700);
  static const Color verifiedBadge = Color(0xFF1DA1F2); // Twitter blue
  static const Color verifiedBadgeClip = Color(0xFF00B0FF); // Brighter blue

  // Text Colors
  static const Color text = white;
  static const Color textOnPrimaryLight = white;
  static const Color textOnPrimaryDark = white;
  static const Color textSecondaryLight = Color(0xFF333333);
  static const Color textSecondaryDark = platinum;
  static const Color textSecondary = Color(0xFFABABAB);
  static const Color clipTextSecondary = platinum;
  static const Color trialAvatarText = white;

  // Clip Card
  static const Color clipCardBg = Color(0xFF0A0A0A);
  static const Color clipCardOverlay = Color(0xB3000000); // 70%
  static const Color clipCardGradientStart = Colors.transparent;
  static const Color clipCardGradientEnd = black;
  static const Color iconInactive = platinum;
  static const Color pillBackground = overlayDark;
  static const Color clipBadge = Color(0xFFE91E63);

  // Game Card
  static const Color gameCardTagColor = Color(0xFF4CAF50);
  static const Color gameCardRatingColor = Color(0xFFFFC107);
  static const Color gameCardEsrbBg = white;
  static const Color gameCardEsrbText = black;
  static const Color gameCardEsrbBorder = black;

  // Free Play Card
  static const Color freePlayBadgeBg = overlayDark;
  static const Color freePlayFreeTagBg = gameCardTagColor;
  static const Color freePlayGradientStart = overlayDark;
  static const Color freePlayGradientEnd = Colors.transparent;
  static const Color freePlayStarColor = gameCardRatingColor;

  // Game Trial Card
  static const Color trialCardBorderColor = Color(0xFF2D2F3E);
  static const Color trialCardBackground = Color(0xFF1A1C25);
  static const Color trialCardHighlight = Color(0xFF3A3E52);
  static const Color trialBadgeColor = Color(0xFF3E4C8A);
  static const Color trialBadgeTextColor = white;
  static const Color trialPriceColor = Color(0xFF43B581);
  static const Color trialCoinColor = Color(0xFFFFC857);
  static const Color trialFriendsColor = Color(0xFF8A8D96);
  static const Color trialEsrbBackgroundColor = white;
  static const Color trialEsrbTextColor = black;
  static const Color trialAvatarBorder = white;
  static const Color trialAvatarOverlay = overlayLight;

  // Game Interstitial
  static const Color gameInterstitialBg = Color(0xFF1A1B26);
  static const Color gameTagBg = Color(0xFF2A2D36);
  static const Color onlineCountBg = Color(0xFF2E3341);
  static const Color onlineIndicator = gameCardTagColor;
  static const Color followButtonBg = trialCardHighlight;

  // Buttons
  static const Color buttonPrimary = primaryPurple;
  static const Color buttonSecondary = trialCardHighlight;
  static const Color buttonIcon = white;
  static const Color softGray = Color(0xFFE2DFDF);
  static const Color gray60 = Color.fromRGBO(159, 159, 159, 0.6);
  static const Color darkCharcoal = Color(0xFF2B2B2B);
  static const Color limeGreen = Color(0xFF63F786);
  static const Color shadowBlack = Color(0x001B1D26);
  static const Color midnightGray = Color(0xBF1B1D26);
}
