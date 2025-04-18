import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:phynd_app/presentation/widgets/input_fields/password_input_field.dart';
import 'package:phynd_app/presentation/widgets/input_fields/text_input_field.dart';
import 'package:phynd_app/presentation/widgets/buttons/primary_button.dart';

class PublisherRegistrationForm extends StatefulWidget {
  const PublisherRegistrationForm({super.key});

  @override
  State<PublisherRegistrationForm> createState() =>
      _PublisherRegistrationFormState();
}

class _PublisherRegistrationFormState extends State<PublisherRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _publisherTypeController = TextEditingController();
  final _publisherCategoryController = TextEditingController();
  final _publisherSubCategoryController = TextEditingController();
  final _publisherDescriptionController = TextEditingController();
  final _publisherWebsiteController = TextEditingController();
  final _publisherAddressController = TextEditingController();
  final _publisherPhoneController = TextEditingController();
  final _publisherEmailController = TextEditingController();
  final _publisherSocialMediaController = TextEditingController();
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

  final _publisherTypeValidator = ValidationBuilder()
      .required('Publisher type is required')
      .maxLength(255, 'Publisher type must be less than 255 characters')
      .build();

  final _publisherCategoryValidator = ValidationBuilder()
      .required('Publisher category is required')
      .maxLength(255, 'Publisher category must be less than 255 characters')
      .build();

  final _publisherDescriptionValidator = ValidationBuilder()
      .required('Publisher description is required')
      .maxLength(
          1000, 'Publisher description must be less than 1000 characters')
      .build();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _displayNameController.dispose();
    _publisherTypeController.dispose();
    _publisherCategoryController.dispose();
    _publisherSubCategoryController.dispose();
    _publisherDescriptionController.dispose();
    _publisherWebsiteController.dispose();
    _publisherAddressController.dispose();
    _publisherPhoneController.dispose();
    _publisherEmailController.dispose();
    _publisherSocialMediaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Basic Information Section
            const Text(
              'Basic Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
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

            // Publisher Information Section
            const SizedBox(height: 24),
            const Text(
              'Publisher Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextInputField(
              controller: _publisherTypeController,
              label: 'Publisher Type',
              validator: _publisherTypeValidator,
            ),
            const SizedBox(height: 16),
            TextInputField(
              controller: _publisherCategoryController,
              label: 'Publisher Category',
              validator: _publisherCategoryValidator,
            ),
            const SizedBox(height: 16),
            TextInputField(
              controller: _publisherSubCategoryController,
              label: 'Publisher Sub-Category',
            ),
            const SizedBox(height: 16),
            TextInputField(
              controller: _publisherDescriptionController,
              label: 'Publisher Description',
              maxLines: 3,
              validator: _publisherDescriptionValidator,
            ),
            const SizedBox(height: 16),
            TextInputField(
              controller: _publisherWebsiteController,
              label: 'Website URL',
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 16),
            TextInputField(
              controller: _publisherAddressController,
              label: 'Address',
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            TextInputField(
              controller: _publisherPhoneController,
              label: 'Phone Number',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            TextInputField(
              controller: _publisherEmailController,
              label: 'Contact Email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextInputField(
              controller: _publisherSocialMediaController,
              label: 'Social Media Links',
              maxLines: 2,
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
      ),
    );
  }
}
