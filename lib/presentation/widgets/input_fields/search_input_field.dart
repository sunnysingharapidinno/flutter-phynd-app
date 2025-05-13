import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

class SearchInputField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String hintText;
  final bool isLoading;
  final bool showMic;
  final double borderRadius;
  final Color? backgroundColor;

  const SearchInputField({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText = 'Search...',
    this.isLoading = false,
    this.showMic = true,
    this.borderRadius = 12.0,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;
    final bgColor = backgroundColor ?? theme.get('cardBg');
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: theme.get('borderColor')),
    );

    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(
        color: theme.get('text'),
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: theme.get('textSecondary'),
          fontSize: 16,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: theme.get('textSecondary'),
        ),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading)
              SizedBox(
                width: 24,
                height: 24,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: theme.get('primary'),
                  ),
                ),
              ),
            if (isLoading && showMic) const SizedBox(width: 12),
            if (showMic)
              Icon(
                Icons.mic,
                color: theme.get('textSecondary'),
              ),
            if (showMic) const SizedBox(width: 12),
          ],
        ),
        filled: true,
        fillColor: bgColor,
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: theme.get('primary')),
        ),
      ),
    );
  }
}
