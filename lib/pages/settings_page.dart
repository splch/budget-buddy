import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings';
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _apiKeyCtl = TextEditingController();

  @override
  void dispose() {
    _apiKeyCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final initialKey = ModalRoute.of(context)!.settings.arguments as String?;
    if (initialKey != null) _apiKeyCtl.text = initialKey;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _apiKeyCtl,
              decoration: const InputDecoration(
                  labelText: 'Plaid Link Token',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                final updatedKey = _apiKeyCtl.text.trim();
                // TODO: save key via file or secure storage
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('API key updated: $updatedKey')),
                );
                // Navigate to HomePage after saving
                Navigator.of(context).pushReplacementNamed(HomePage.routeName);
              },
              child: const Text('Save API Key'),
            ),
            const Divider(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Text('Export all data'),
              onPressed: () {
                // TODO: use `file` package to write CSV/JSON
              },
            ),
          ],
        ),
      ),
    );
  }
}
