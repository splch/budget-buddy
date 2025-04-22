import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'transactions_page.dart';
import 'budgets_page.dart';
import 'settings_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double netWorth = 12345.67;
    final double monthlySpend = 2345.89;
    final double cashFlow = 1234.56;
    final List<Map<String, dynamic>> accountSummaries = [
      {'name': 'Checking', 'balance': 5000.00},
      {'name': 'Savings', 'balance': 7345.67},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Budget Buddy')),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Home'),
              onTap: () => Navigator.pushReplacementNamed(context, routeName),
            ),
            ListTile(
              title: const Text('Transactions'),
              onTap: () => Navigator.pushNamed(context, TransactionsPage.routeName),
            ),
            ListTile(
              title: const Text('Budgets'),
              onTap: () => Navigator.pushNamed(context, BudgetsPage.routeName),
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () => Navigator.pushNamed(context, SettingsPage.routeName),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildCard('Net Worth', '\$${netWorth.toStringAsFixed(2)}'),
            _buildCard('Monthly Spending', '\$${monthlySpend.toStringAsFixed(2)}'),
            _buildCard('Cash Flow', '\$${cashFlow.toStringAsFixed(2)}'),
            const SizedBox(height: 24),
            const Text('Account Balances', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...accountSummaries.map((acct) => ListTile(
                  title: Text(acct['name'] as String),
                  trailing: Text('\$${(acct['balance'] as double).toStringAsFixed(2)}'),
                )),
            const SizedBox(height: 24),
            const Text('Spending Last 7 Days', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 200,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                series: <LineSeries<_ChartData, String>>[
                  LineSeries<_ChartData, String>(
                    dataSource: [
                      _ChartData('Mon', 200),
                      _ChartData('Tue', 150),
                      _ChartData('Wed', 300),
                      _ChartData('Thu', 100),
                      _ChartData('Fri', 250),
                      _ChartData('Sat', 175),
                      _ChartData('Sun', 90),
                    ],
                    xValueMapper: (d, _) => d.day,
                    yValueMapper: (d, _) => d.amount,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card _buildCard(String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(title: Text(title), subtitle: Text(subtitle)),
    );
  }
}

class _ChartData {
  final String day;
  final double amount;
  _ChartData(this.day, this.amount);
}
