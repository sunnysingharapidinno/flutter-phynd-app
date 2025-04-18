import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:phynd_app/presentation/widgets/input_fields/password_input_field.dart';
import 'package:phynd_app/presentation/widgets/input_fields/text_input_field.dart';
import 'package:phynd_app/presentation/widgets/buttons/primary_button.dart';

class UserRegistrationForm extends StatefulWidget {
  const UserRegistrationForm({super.key});

  @override
  State<UserRegistrationForm> createState() => _UserRegistrationFormState();
}

class _UserRegistrationFormState extends State<UserRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _displayNameController = TextEditingController();
  bool _isOrganization = false;

  final _firstNameValidator = ValidationBuilder()
      .required('First name is required')
      .maxLength(255, 'First name must be less than 255 characters')
      .build();

  final _lastNameValidator = ValidationBuilder()
      .required('Last name is required')
      .maxLength(255, 'Last name must be less than 255 characters')
      .build();

  final _emailValidator = ValidationBuilder()
      .required('Email is required')
      .email('Please enter a valid email')
      .maxLength(255, 'Email must be less than 255 characters')
      .build();

  final _passwordValidator = ValidationBuilder()
      .required('Password is required')
      .minLength(6, 'Password must be at least 6 characters')
      .maxLength(255, 'Password must be less than 255 characters')
      .build();

  final _confirmPasswordValidator = ValidationBuilder()
      .required('Please confirm your password')
      .maxLength(255, 'Password must be less than 255 characters')
      .build();

  final _displayNameValidator = ValidationBuilder()
      .required('Display name is required')
      .maxLength(255, 'Display name must be less than 255 characters')
      .build();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextInputField(
            controller: _firstNameController,
            label: 'First Name',
            validator: _firstNameValidator,
          ),
          const SizedBox(height: 16),
          TextInputField(
            controller: _lastNameController,
            label: 'Last Name',
            validator: _lastNameValidator,
          ),
          const SizedBox(height: 16),
          TextInputField(
            controller: _emailController,
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: _emailValidator,
          ),
          const SizedBox(height: 16),
          PasswordInputField(
            controller: _passwordController,
            label: 'Password',
            validator: _passwordValidator,
          ),
          const SizedBox(height: 16),
          PasswordInputField(
            controller: _confirmPasswordController,
            label: 'Confirm Password',
            validator: (value) {
              final error = _confirmPasswordValidator(value);
              if (error != null) return error;
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextInputField(
            controller: _displayNameController,
            label: 'Display Name',
            validator: _displayNameValidator,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: _isOrganization,
                onChanged: (value) {
                  setState(() {
                    _isOrganization = value ?? false;
                  });
                },
              ),
              const Text('Register as Organization'),
            ],
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            text: 'Register',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // TODO: Handle form submission
              }
            },
          ),
        ],
      ),
    );
  }
}
