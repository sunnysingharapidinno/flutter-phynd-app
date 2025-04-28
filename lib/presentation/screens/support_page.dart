import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/layouts/base_layout.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final backgroundColor = theme?.get('bgColor');
    final cardColor = theme?.get('cardBg');
    final textColor = theme?.get('text');
    final textSecondaryColor = theme?.get('textSecondary');

    return BaseLayout(
      title: 'Support',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contact Information
            _buildSection(
              context,
              'Contact Us',
              Column(
                children: [
                  _buildContactCard(
                    context,
                    'Email Support',
                    'support@phyndapp.com',
                    Icons.email,
                    theme?.get('primary') ?? Colors.blue,
                  ),
                  _buildContactCard(
                    context,
                    'Live Chat',
                    'Available 24/7',
                    Icons.chat,
                    theme?.get('secondary') ?? Colors.green,
                  ),
                  _buildContactCard(
                    context,
                    'Phone Support',
                    '+1 (555) 123-4567',
                    Icons.phone,
                    theme?.get('accent') ?? Colors.purple,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // FAQ Section
            _buildSection(
              context,
              'Frequently Asked Questions',
              Column(
                children: [
                  _buildFAQItem(
                    context,
                    'How do I reset my password?',
                    'You can reset your password by clicking on the "Forgot Password" link on the login page. Follow the instructions sent to your email.',
                  ),
                  _buildFAQItem(
                    context,
                    'How do I report a bug?',
                    'You can report bugs by contacting our support team through email or live chat. Please provide as much detail as possible about the issue.',
                  ),
                  _buildFAQItem(
                    context,
                    'How do I update my profile?',
                    'You can update your profile by going to your profile page and clicking the edit button. Make your changes and save them.',
                  ),
                ],
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
    Widget content,
  ) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 16),
        content,
      ],
    );
  }

  Widget _buildContactCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color iconColor,
  ) {
    final theme = Theme.of(context).extension<AppTheme>();
    final cardColor = theme?.get('cardBg');
    final textColor = theme?.get('text');
    final textSecondaryColor = theme?.get('textSecondary');

    return Card(
      color: cardColor,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: textSecondaryColor,
          ),
        ),
        onTap: () {
          // Handle contact method selection
        },
      ),
    );
  }

  Widget _buildFAQItem(
    BuildContext context,
    String question,
    String answer,
  ) {
    final theme = Theme.of(context).extension<AppTheme>();
    final cardColor = theme?.get('cardBg');
    final textColor = theme?.get('text');
    final textSecondaryColor = theme?.get('textSecondary');

    return Card(
      color: cardColor,
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              answer,
              style: TextStyle(
                color: textSecondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
