import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ErrorPage extends StatelessWidget {
  static const routeName = '/error';
  final String errorMessage;
  const ErrorPage({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    final issueUri = Uri.https(
      'github.com',
      '/<your-org>/budget_buddy/issues/new',
      {
        'title': '[App Error] ',
        'body': errorMessage,
      },
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Oops!')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'An unexpected error occurred:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(child: SingleChildScrollView(child: Text(errorMessage))),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () => launchUrl(issueUri),
                child: const Text('Report on GitHub'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
