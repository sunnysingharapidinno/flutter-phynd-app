import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

class SearchInputField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String hintText;
  final bool isLoading;

  const SearchInputField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = 'Search...',
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;

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
        suffixIcon: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: theme.get('primary'),
                  ),
                ),
              )
            : null,
        filled: true,
        fillColor: theme.get('cardBg'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.get('borderColor')),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.get('borderColor')),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.get('primary')),
        ),
      ),
    );
  }
}
