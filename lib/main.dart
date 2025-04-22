import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final _notificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initNotifications();
  runApp(const BudgetBuddyApp());
}

/// Initialize flutter_local_notifications
Future<void> _initNotifications() async {
  const androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosSettings = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  const settings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
    macOS: iosSettings,
    linux: LinuxInitializationSettings(defaultActionName: 'Open'),
  );

  await _notificationsPlugin.initialize(
    settings,
    onDidReceiveNotificationResponse:
        (NotificationResponse response) {
      debugPrint('Tapped notification: ${response.payload}');
    },
  );
}

class BudgetBuddyApp extends StatelessWidget {
  const BudgetBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Buddy',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLinking = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Budget Buddy')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _isLinking
                  ? null
                  : () {
                      _openPlaid();
                    },
              child: Text(
                  _isLinking ? 'Connecting…' : 'Connect bank account'),
            ),
            const SizedBox(height: 20),
            Expanded(child: _buildSampleChart()),
          ],
        ),
      ),
    );
  }

  /// Uses the **static** PlaidLink API instead of assigning a void to `handler`
  Future<void> _openPlaid() async {
    setState(() => _isLinking = true);

    try {
      final config = LinkTokenConfiguration(
          token: '<SERVER_GENERATED_LINK_TOKEN>');
      // Create Link
      await PlaidLink.create(configuration: config);               

      // Subscribe to Link events
      PlaidLink.onEvent.listen(
          (e) => debugPrint('Plaid event: ${e.name}'));          
      PlaidLink.onExit.listen(
          (exit) => debugPrint('Plaid exit: ${exit.error}'));      
      PlaidLink.onSuccess.listen((success) =>
          debugPrint('Plaid success: ${success.publicToken}'));

      // Open Link UI
      await PlaidLink.open();                                     
    } catch (err) {
      debugPrint('Error launching Plaid: $err');
    } finally {
      setState(() => _isLinking = false);
    }
  }

  Widget _buildSampleChart() {
    final data = [
      _Data('Mon', 50),
      _Data('Tue', 30),
      _Data('Wed', 80),
    ];

    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: <LineSeries<_Data, String>>[
        LineSeries<_Data, String>(
          dataSource: data,
          xValueMapper: (d, _) => d.label,
          yValueMapper: (d, _) => d.value,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}

class _Data {
  final String label;
  final double value;
  _Data(this.label, this.value);
}
