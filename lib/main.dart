import 'package:flutter/material.dart';

import 'pages/splash_page.dart';
import 'pages/onboarding_page.dart';
import 'pages/home_page.dart';
import 'pages/transactions_page.dart';
import 'pages/budgets_page.dart';
import 'pages/settings_page.dart';
import 'pages/error_page.dart';

void main() {
  runApp(const BudgetBuddyApp());
}

class BudgetBuddyApp extends StatelessWidget {
  const BudgetBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Buddy',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (_) => const SplashPage(),
        OnboardingPage.routeName: (_) => const OnboardingPage(),
        HomePage.routeName: (_) => const HomePage(),
        TransactionsPage.routeName: (_) => const TransactionsPage(),
        BudgetsPage.routeName: (_) => const BudgetsPage(),
        SettingsPage.routeName: (_) => const SettingsPage(),
        ErrorPage.routeName: (ctx) {
          final args = ModalRoute.of(ctx)!.settings.arguments as String;
          return ErrorPage(errorMessage: args);
        },
      },
    );
  }
}
