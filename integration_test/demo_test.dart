// Taps the app on the iOS Simulator while the workflow records the screen.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:macless_test/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('demo taps', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 3));
    for (var i = 0; i < 6; i++) {
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 900));
    }
    await Future.delayed(const Duration(seconds: 3));
  });
}
