import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/layouts/base_layout.dart';
import 'package:phynd_app/presentation/widgets/forms/signup_form.dart';
import 'package:phynd_app/data/models/user_signup_payload.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isLoading = false;
  String? _errorMessage;

  void _handleSignup(UserSignupPayload payload) {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // TODO: Handle signup logic
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Sign Up',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            SignupForm(
              onSubmit: _handleSignup,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
