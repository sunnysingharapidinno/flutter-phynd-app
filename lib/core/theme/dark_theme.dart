import 'package:flutter/material.dart';
import 'package:phynd_app/core/theme/app_colors.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

final darkThemeColors = {'bgColor': AppColors.black, 'text': AppColors.white};

final ThemeData darkTheme = ThemeData(extensions: [AppTheme(darkThemeColors)]);
