import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flagsmith/flagsmith.dart';
import 'package:flagsmith_ab_test/main.dart';

void main() {
  group('Flagsmith A/B Testing App', () {

    testWidgets('Annual plan appears first when flag is ON',
            (WidgetTester tester) async {

          final client = FlagsmithClient(
            apiKey: 'test-api-key',
          );

          try {
            await tester.pumpWidget(
              MyApp(
                showAnnualPlanFirst: true,
                flagsmithClient: client,
              ),
            );

            await tester.pump();

            expect(find.text('Upgrade Your Plan'), findsOneWidget);
            expect(find.text('Annual Power Plan'), findsOneWidget);
            expect(find.text('Monthly Pass'), findsOneWidget);
            expect(find.text('BEST VALUE'), findsOneWidget);

            final annual =
            tester.getTopLeft(find.text('Annual Power Plan'));

            final monthly =
            tester.getTopLeft(find.text('Monthly Pass'));

            expect(annual.dy, lessThan(monthly.dy));

          } finally {
            await tester.pumpWidget(const SizedBox.shrink());
            await client.close();
          }
        });

    testWidgets('Monthly plan appears first when flag is OFF',
            (WidgetTester tester) async {

          final client = FlagsmithClient(
            apiKey: 'test-api-key',
          );

          try {
            await tester.pumpWidget(
              MyApp(
                showAnnualPlanFirst: false,
                flagsmithClient: client,
              ),
            );

            await tester.pump();

            expect(find.text('Upgrade Your Plan'), findsOneWidget);
            expect(find.text('Annual Power Plan'), findsOneWidget);
            expect(find.text('Monthly Pass'), findsOneWidget);
            expect(find.text('POPULAR'), findsOneWidget);

            final annual =
            tester.getTopLeft(find.text('Annual Power Plan'));

            final monthly =
            tester.getTopLeft(find.text('Monthly Pass'));

            expect(monthly.dy, lessThan(annual.dy));

          } finally {
            await tester.pumpWidget(const SizedBox.shrink());
            await client.close();
          }
        });
  });
}