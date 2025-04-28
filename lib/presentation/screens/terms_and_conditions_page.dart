import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/layouts/base_layout.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Terms & Conditions',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              '1. Acceptance of Terms',
              'By accessing and using the Phynd App, you accept and agree to be bound by the terms and provision of this agreement.',
            ),
            _buildSection(
              context,
              '2. User Account',
              'You are responsible for maintaining the confidentiality of your account and password. You agree to accept responsibility for all activities that occur under your account.',
            ),
            _buildSection(
              context,
              '3. User Conduct',
              'You agree not to use the app for any illegal or unauthorized purpose. You must not violate any laws in your jurisdiction.',
            ),
            _buildSection(
              context,
              '4. Intellectual Property',
              'The app and its original content, features, and functionality are owned by Phynd and are protected by international copyright, trademark, and other intellectual property laws.',
            ),
            _buildSection(
              context,
              '5. Privacy Policy',
              'Your use of the app is also governed by our Privacy Policy. Please review our Privacy Policy, which also governs the app and informs users of our data collection practices.',
            ),
            _buildSection(
              context,
              '6. Termination',
              'We may terminate or suspend your account and bar access to the app immediately, without prior notice or liability, under our sole discretion, for any reason whatsoever and without limitation.',
            ),
            _buildSection(
              context,
              '7. Limitation of Liability',
              'In no event shall Phynd, nor its directors, employees, partners, agents, suppliers, or affiliates, be liable for any indirect, incidental, special, consequential or punitive damages.',
            ),
            _buildSection(
              context,
              '8. Changes to Terms',
              'We reserve the right to modify or replace these Terms at any time. If a revision is material, we will provide at least 30 days notice prior to any new terms taking effect.',
            ),
            const SizedBox(height: 24),
            Text(
              'Last updated: January 1, 2025',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Theme.of(context).extension<AppTheme>()!.get('text'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    String content,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).extension<AppTheme>()!.get('text'),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            color: Theme.of(context).extension<AppTheme>()!.get('text'),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
