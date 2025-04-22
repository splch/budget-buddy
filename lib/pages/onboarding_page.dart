import 'package:flutter/material.dart';
import 'settings_page.dart';

class OnboardingPage extends StatelessWidget {
  static const routeName = '/onboarding';
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Getting Started')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '1. Go to https://dashboard.plaid.com/signup\n'
              '2. Create a new developer application\n'
              '3. Copy your Link Token or Secret key\n'
              '4. Come back and paste it below.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Your Plaid Link Token',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (val) {
                // TODO: save via `file` or secure storage
                Navigator.of(context).pushReplacementNamed(
                  SettingsPage.routeName,
                  arguments: val,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
