import 'package:flutter/material.dart';

class BudgetsPage extends StatelessWidget {
  static const routeName = '/budgets';
  const BudgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final budgets = <Map<String, Object>>[
      {'category': 'Food', 'limit': 500.0, 'spent': 350.0},
      {'category': 'Rent', 'limit': 1200.0, 'spent': 1200.0},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Budgets')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...budgets.map((b) {
            final spent = b['spent'] as double;
            final limit = b['limit'] as double;
            final pct = spent / limit;
            return Card(
              child: ListTile(
                title: Text(b['category'] as String),
                subtitle: LinearProgressIndicator(value: pct),
                trailing: Text('\$${spent.toStringAsFixed(0)}/\$${limit.toStringAsFixed(0)}'),
              ),
            );
          }),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('New Budget'),
            onPressed: () {
              // TODO: open budget creation form
            },
          ),
        ],
      ),
    );
  }
}
