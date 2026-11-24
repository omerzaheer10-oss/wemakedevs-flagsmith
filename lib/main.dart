import 'package:flutter/material.dart';
import 'package:flagsmith/flagsmith.dart';
import 'screens/checkout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set up the Flagsmith client with your API key
  final flagsmithClient = FlagsmithClient(
    apiKey: 'kXN362aznhHqAAyhdGtfGt',
  );

  // Initialize and fetch the latest flags from the cloud
  await flagsmithClient.initialize();
  bool isAnnualFirst = await flagsmithClient.hasFeatureFlag('show_annual_plan_first');

  runApp(MyApp(
    showAnnualPlanFirst: isAnnualFirst,
    flagsmithClient: flagsmithClient,
  ));
}

class MyApp extends StatelessWidget {
  final bool showAnnualPlanFirst;
  final FlagsmithClient flagsmithClient;

  const MyApp({
    super.key,
    required this.showAnnualPlanFirst,
    required this.flagsmithClient,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flagsmith A/B Test',
      debugShowCheckedModeBanner: false,
      home: CheckoutScreen(
        showAnnualPlanFirst: showAnnualPlanFirst,
        flagsmithClient: flagsmithClient,
      ),
    );
  }
}