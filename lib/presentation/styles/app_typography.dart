import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

class AppTypography {
  static Text heading1(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    TextOverflow? overflow,
    String? decoration,
    TextStyle? style,
    int? maxLines,
    BuildContext? context,
  }) {
    Color textColor;
    if (context != null) {
      final appTheme = Theme.of(context).extension<AppTheme>()!;
      textColor = color ?? appTheme.get('text');
    } else {
      textColor = color ?? Colors.black;
    }

    return Text(
      text,
      style: const TextStyle(
        fontSize: 56,
        height: 62 / 56,
        fontWeight: FontWeight.w600,
      ).merge(style).copyWith(
            color: textColor,
            fontWeight: fontWeight,
            decoration: _getTextDecoration(decoration),
          ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  static Text heading2(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    TextOverflow? overflow,
    String? decoration,
    TextStyle? style,
    int? maxLines,
    BuildContext? context,
  }) {
    Color textColor;
    if (context != null) {
      final appTheme = Theme.of(context).extension<AppTheme>()!;
      textColor = color ?? appTheme.get('text');
    } else {
      textColor = color ?? Colors.black;
    }

    return Text(
      text,
      style: const TextStyle(
        fontSize: 48,
        height: 53 / 48,
        fontWeight: FontWeight.w600,
      ).merge(style).copyWith(
            color: textColor,
            fontWeight: fontWeight,
            decoration: _getTextDecoration(decoration),
          ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  static Text heading3(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    TextOverflow? overflow,
    String? decoration,
    TextStyle? style,
    int? maxLines,
    BuildContext? context,
  }) {
    Color textColor;
    if (context != null) {
      final appTheme = Theme.of(context).extension<AppTheme>()!;
      textColor = color ?? appTheme.get('text');
    } else {
      textColor = color ?? Colors.black;
    }

    return Text(
      text,
      style: const TextStyle(
        fontSize: 40,
        height: 44 / 40,
        fontWeight: FontWeight.w600,
      ).merge(style).copyWith(
            color: textColor,
            fontWeight: fontWeight,
            decoration: _getTextDecoration(decoration),
          ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  static Text heading4(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    TextOverflow? overflow,
    String? decoration,
    TextStyle? style,
    int? maxLines,
    BuildContext? context,
  }) {
    Color textColor;
    if (context != null) {
      final appTheme = Theme.of(context).extension<AppTheme>()!;
      textColor = color ?? appTheme.get('text');
    } else {
      textColor = color ?? Colors.black;
    }

    return Text(
      text,
      style: const TextStyle(
        fontSize: 32,
        height: 36 / 32,
        fontWeight: FontWeight.w600,
      ).merge(style).copyWith(
            color: textColor,
            fontWeight: fontWeight,
            decoration: _getTextDecoration(decoration),
          ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  static Text heading5(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    TextOverflow? overflow,
    String? decoration,
    TextStyle? style,
    int? maxLines,
    BuildContext? context,
  }) {
    Color textColor;
    if (context != null) {
      final appTheme = Theme.of(context).extension<AppTheme>()!;
      textColor = color ?? appTheme.get('text');
    } else {
      textColor = color ?? Colors.black;
    }

    return Text(
      text,
      style: const TextStyle(
        fontSize: 24,
        height: 27 / 24,
        fontWeight: FontWeight.w600,
      ).merge(style).copyWith(
            color: textColor,
            fontWeight: fontWeight,
            decoration: _getTextDecoration(decoration),
          ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  static Text xxLargeText(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    TextOverflow? overflow,
    String? decoration,
    TextStyle? style,
    int? maxLines,
    BuildContext? context,
  }) {
    Color textColor;
    if (context != null) {
      final appTheme = Theme.of(context).extension<AppTheme>()!;
      textColor = color ?? appTheme.get('text');
    } else {
      textColor = color ?? Colors.black;
    }

    return Text(
      text,
      style: const TextStyle(
        fontSize: 32,
        height: 28 / 32,
        fontWeight: FontWeight.normal,
      ).merge(style).copyWith(
            color: textColor,
            fontWeight: fontWeight,
            decoration: _getTextDecoration(decoration),
          ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  static Text xxmLargeText(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    TextOverflow? overflow,
    String? decoration,
    TextStyle? style,
    int? maxLines,
    BuildContext? context,
  }) {
    Color textColor;
    if (context != null) {
      final appTheme = Theme.of(context).extension<AppTheme>()!;
      textColor = color ?? appTheme.get('text');
    } else {
      textColor = color ?? Colors.black;
    }

    return Text(
      text,
      style: const TextStyle(
        fontSize: 28,
        height: 1,
        fontWeight: FontWeight.normal,
      ).merge(style).copyWith(
            color: textColor,
            fontWeight: fontWeight,
            decoration: _getTextDecoration(decoration),
          ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  static Text largeTextBold(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    TextOverflow? overflow,
    String? decoration,
    TextStyle? style,
    int? maxLines,
    BuildContext? context,
  }) {
    Color textColor;
    if (context != null) {
      final appTheme = Theme.of(context).extension<AppTheme>()!;
      textColor = color ?? appTheme.get('text');
    } else {
      textColor = color ?? Colors.black;
    }

    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        height: 28 / 20,
        fontWeight: FontWeight.bold,
      ).merge(style).copyWith(
            color: textColor,
            fontWeight: fontWeight,
            decoration: _getTextDecoration(decoration),
          ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  static Text mediumTextBold(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    TextOverflow? overflow,
    String? decoration,
    TextStyle? style,
    int? maxLines,
    BuildContext? context,
  }) {
    Color textColor;
    if (context != null) {
      final appTheme = Theme.of(context).extension<AppTheme>()!;
      textColor = color ?? appTheme.get('text');
    } else {
      textColor = color ?? Colors.black;
    }

    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ).merge(style).copyWith(
            color: textColor,
            fontWeight: fontWeight,
            decoration: _getTextDecoration(decoration),
          ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  static Text normalTextBold(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    TextOverflow? overflow,
    String? decoration,
    TextStyle? style,
    int? maxLines,
    BuildContext? context,
  }) {
    Color textColor;
    if (context != null) {
      final appTheme = Theme.of(context).extension<AppTheme>()!;
      textColor = color ?? appTheme.get('text');
    } else {
      textColor = color ?? Colors.black;
    }

    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        height: 23 / 16,
        fontWeight: FontWeight.bold,
      ).merge(style).copyWith(
            color: textColor,
            fontWeight: fontWeight,
            decoration: _getTextDecoration(decoration),
          ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  static Text smallTextBold(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    TextOverflow? overflow,
    String? decoration,
    TextStyle? style,
    int? maxLines,
    BuildContext? context,
  }) {
    Color textColor;
    if (context != null) {
      final appTheme = Theme.of(context).extension<AppTheme>()!;
      textColor = color ?? appTheme.get('text');
    } else {
      textColor = color ?? Colors.black;
    }

    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.bold,
      ).merge(style).copyWith(
            color: textColor,
            fontWeight: fontWeight,
            decoration: _getTextDecoration(decoration),
          ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  static Text extraSmallTextBold(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    TextOverflow? overflow,
    String? decoration,
    TextStyle? style,
    int? maxLines,
    BuildContext? context,
  }) {
    Color textColor;
    if (context != null) {
      final appTheme = Theme.of(context).extension<AppTheme>()!;
      textColor = color ?? appTheme.get('text');
    } else {
      textColor = color ?? Colors.black;
    }

    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        height: 17 / 12,
        fontWeight: FontWeight.bold,
      ).merge(style).copyWith(
            color: textColor,
            fontWeight: fontWeight,
            decoration: _getTextDecoration(decoration),
          ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  static Text tinyTextBold(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    TextOverflow? overflow,
    String? decoration,
    TextStyle? style,
    int? maxLines,
    BuildContext? context,
  }) {
    Color textColor;
    if (context != null) {
      final appTheme = Theme.of(context).extension<AppTheme>()!;
      textColor = color ?? appTheme.get('text');
    } else {
      textColor = color ?? Colors.black;
    }

    return Text(
      text,
      style: const TextStyle(
        fontSize: 10,
        height: 14 / 10,
        fontWeight: FontWeight.bold,
      ).merge(style).copyWith(
            color: textColor,
            fontWeight: fontWeight,
            decoration: _getTextDecoration(decoration),
          ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  static TextDecoration? _getTextDecoration(String? decoration) {
    switch (decoration) {
      case 'underline':
        return TextDecoration.underline;
      case 'lineThrough':
        return TextDecoration.lineThrough;
      case 'overline':
        return TextDecoration.overline;
      default:
        return null;
    }
  }
}
