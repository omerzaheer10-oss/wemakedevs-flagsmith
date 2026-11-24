import 'package:flutter/material.dart';
import 'package:flagsmith/flagsmith.dart';
import 'screens/checkout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Flagsmith
  final flagsmithClient = FlagsmithClient(
    apiKey: 'kXN362aznhHqAAyhdGtfGt',
  );

  try {
    // Initialize the SDK
    await flagsmithClient.initialize();

    // Force fetch the latest flags from Flagsmith
    await flagsmithClient.getFeatureFlags(reload: true);

    // Check the latest feature flag
    final flags = await flagsmithClient.getFeatureFlags(
      reload: true,
    );

    debugPrint('========== FLAGSMITH DEBUG ==========');

    for (final flag in flags) {
      debugPrint(
        'Flag: ${flag.key} | Enabled: ${flag.enabled} | Value: ${flag.value}',
      );
    }

    final matchingFlags = flags
        .where((flag) => flag.key == 'show_annual_plan_first')
        .toList();

    final bool isAnnualFirst = matchingFlags.isNotEmpty &&
        matchingFlags.first.enabled == true;

    debugPrint('FINAL RESULT: $isAnnualFirst');
    debugPrint('====================================');

    // Print the result in the console
    debugPrint('================================');
    debugPrint('FLAGSMITH A/B TEST');
    debugPrint('Annual Plan First: $isAnnualFirst');
    debugPrint('================================');

    // Start the application
    runApp(
      MyApp(
        showAnnualPlanFirst: isAnnualFirst,
        flagsmithClient: flagsmithClient,
      ),
    );
  } catch (e) {
    debugPrint('Flagsmith Error: $e');

    // Start the app with a fallback value
    runApp(
      MyApp(
        showAnnualPlanFirst: false,
        flagsmithClient: flagsmithClient,
      ),
    );
  }
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
      title: 'Flagsmith A/B Testing',
      debugShowCheckedModeBanner: false,
      home: CheckoutScreen(
        showAnnualPlanFirst: showAnnualPlanFirst,
        flagsmithClient: flagsmithClient,
      ),
    );
  }
}