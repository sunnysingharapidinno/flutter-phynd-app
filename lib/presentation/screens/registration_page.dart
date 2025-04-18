import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/layouts/base_layout.dart';
import 'package:phynd_app/presentation/widgets/forms/publisher_registration_form.dart';
import 'package:phynd_app/presentation/widgets/forms/user_registration_form.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Registration',
      child: RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _isPublisher = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Toggle Switch
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'User',
                      style: TextStyle(fontSize: 16),
                    ),
                    Switch(
                      value: _isPublisher,
                      onChanged: (value) {
                        setState(() {
                          _isPublisher = value;
                        });
                      },
                    ),
                    const Text(
                      'Publisher',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Form based on toggle
            _isPublisher
                ? const PublisherRegistrationForm()
                : const UserRegistrationForm(),
          ],
        ),
      ),
    );
  }
}
