import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_validator/form_validator.dart';
import 'package:phynd_app/presentation/styles/app_typography.dart';
import 'package:phynd_app/presentation/widgets/input_fields/password_input_field.dart';
import 'package:phynd_app/presentation/widgets/input_fields/text_input_field.dart';
import 'package:phynd_app/presentation/widgets/buttons/primary_button.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

class LoginForm extends StatefulWidget {
  final Function(String email, String password) onSubmit;
  final bool isLoading;

  const LoginForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  final _emailValidator = ValidationBuilder()
      .required('Email is required')
      .email('Please enter a valid email')
      .maxLength(255, 'Email must be less than 255 characters')
      .build();

  final _passwordValidator = ValidationBuilder()
      .required('Password is required')
      .maxLength(255, 'Password must be less than 255 characters')
      .build();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  void _onEmailChanged() {
    if (_emailFocusNode.hasFocus) {
      _formKey.currentState?.validate();
    }
  }

  void _onPasswordChanged() {
    if (_passwordController.text.isNotEmpty) {
      _formKey.currentState?.validate();
    }
  }

  @override
  void dispose() {
    _emailController.removeListener(_onEmailChanged);
    _passwordController.removeListener(_onPasswordChanged);
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 430),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: BoxDecoration(
          color: theme.get('cardBg'),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.get('borderColor')),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTypography.heading5(
                'LOG IN TO PHYND',
                context: context,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextInputField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: _emailValidator,
                enabled: !widget.isLoading,
                style: TextStyle(color: theme.get('text')),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: theme.get('bgColor'),
                  labelStyle: TextStyle(color: theme.get('textSecondary')),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.get('borderColor')),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.get('primary')),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.get('primary')),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.get('primary')),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              PasswordInputField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                label: 'Password',
                validator: _passwordValidator,
                enabled: !widget.isLoading,
                style: TextStyle(color: theme.get('text')),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: theme.get('bgColor'),
                  labelStyle: TextStyle(color: theme.get('textSecondary')),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.get('borderColor')),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.get('primary')),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.get('primary')),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.get('primary')),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // TODO: Implement forgot password
                  },
                  child: AppTypography.normalTextBold(
                    'Forgot password?',
                    context: context,
                    decoration: 'underline',
                  ),
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Log In',
                onPressed: _handleSubmit,
                isLoading: widget.isLoading,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTypography.normalTextBold(
                    "Don't have an account? ",
                    context: context,
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to sign up
                    },
                    child: AppTypography.normalTextBold(
                      'Sign up for free',
                      context: context,
                      color: theme.get('primary'),
                      decoration: 'underline',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: theme.get('dividerColor'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppTypography.normalTextBold(
                      'OR',
                      context: context,
                      color: theme.get('textSecondary'),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: theme.get('dividerColor'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton(CupertinoIcons.globe, () {}),
                  const SizedBox(width: 16),
                  _buildSocialButton(CupertinoIcons.app_fill, () {}),
                  const SizedBox(width: 16),
                  _buildSocialButton(CupertinoIcons.person_crop_circle, () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, VoidCallback onPressed) {
    final theme = Theme.of(context).extension<AppTheme>()!;
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.get('bgColor'),
        border: Border.all(color: theme.get('borderColor')),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: theme.get('text'),
          size: 24,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
