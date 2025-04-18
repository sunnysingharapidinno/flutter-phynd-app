import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:phynd_app/presentation/widgets/input_fields/password_input_field.dart';
import 'package:phynd_app/presentation/widgets/input_fields/text_input_field.dart';
import 'package:phynd_app/presentation/widgets/buttons/primary_button.dart';

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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextInputField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: _emailValidator,
            enabled: !widget.isLoading,
          ),
          const SizedBox(height: 16),
          PasswordInputField(
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            label: 'Password',
            validator: _passwordValidator,
            enabled: !widget.isLoading,
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            text: 'Login',
            onPressed: _handleSubmit,
            isLoading: widget.isLoading,
          ),
        ],
      ),
    );
  }
}
