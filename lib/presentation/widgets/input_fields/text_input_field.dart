import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final int? maxLines;
  final bool enabled;
  final void Function(String)? onChanged;
  final TextStyle? style;
  final InputDecoration? decoration;

  const TextInputField({
    super.key,
    required this.label,
    required this.controller,
    this.focusNode,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLines = 1,
    this.enabled = true,
    this.onChanged,
    this.style,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: decoration?.copyWith(
            labelText: label,
            suffixIcon: suffixIcon,
          ) ??
          InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            suffixIcon: suffixIcon,
          ),
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      enabled: enabled,
      onChanged: onChanged,
      style: style,
    );
  }
}
