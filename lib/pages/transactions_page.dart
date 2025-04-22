import 'package:flutter/material.dart';

class TransactionsPage extends StatefulWidget {
  static const routeName = '/transactions';
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  DateTime _selected = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final sample = List.generate(15, (i) => {
          'date': DateTime.now().subtract(Duration(days: i)),
          'desc': 'Purchase #\$i',
          'amount': (i + 1) * 5.25,
        });

    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: Column(
        children: [
          TextButton(
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _selected,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
              );
              if (picked != null) setState(() => _selected = picked);
            },
            child: Text(
              'Filter: \$${_selected.year}-\$${_selected.month.toString().padLeft(2,'0')}',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: sample.length,
              itemBuilder: (_, i) {
                final tx = sample[i];
                return ListTile(
                  title: Text(tx['desc'] as String),
                  subtitle: Text((tx['date'] as DateTime).toLocal().toString().split(' ')[0]),
                  trailing: Text('-\$${(tx['amount'] as double).toStringAsFixed(2)}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
