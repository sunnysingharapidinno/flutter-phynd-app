import 'package:flutter/material.dart';

class PasswordInputField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final bool enabled;
  final void Function(String)? onChanged;
  final TextStyle? style;
  final InputDecoration? decoration;

  const PasswordInputField({
    super.key,
    required this.label,
    required this.controller,
    this.focusNode,
    this.validator,
    this.enabled = true,
    this.onChanged,
    this.style,
    this.decoration,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      decoration: widget.decoration?.copyWith(
            labelText: widget.label,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: _togglePasswordVisibility,
            ),
          ) ??
          InputDecoration(
            labelText: widget.label,
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: _togglePasswordVisibility,
            ),
          ),
      validator: widget.validator,
      obscureText: _obscureText,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      style: widget.style,
    );
  }
}
