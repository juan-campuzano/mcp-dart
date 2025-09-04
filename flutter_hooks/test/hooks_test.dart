import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';

void main() {
  group('Flutter Hooks Example Tests', () {
    testWidgets('Counter increment test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpApp(const MainApp());

      // Verify that our counter starts at 0.
      expect(find.text('Contador: 0'), findsOneWidget);
      expect(find.text('Contador: 1'), findsNothing);

      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Verify that our counter has incremented.
      expect(find.text('Contador: 0'), findsNothing);
      expect(find.text('Contador: 1'), findsOneWidget);
    });

    testWidgets('Counter decrement test', (WidgetTester tester) async {
      await tester.pumpApp(const MainApp());

      // First increment to have something to decrement
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(find.text('Contador: 1'), findsOneWidget);

      // Now decrement
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      expect(find.text('Contador: 0'), findsOneWidget);
    });

    testWidgets('Text input test', (WidgetTester tester) async {
      await tester.pumpApp(const MainApp());

      // Find the text field
      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      // Enter text
      await tester.enterText(textField, 'Juan');
      await tester.pump();

      // Verify the greeting appears
      expect(find.text('Hola, Juan! 👋'), findsOneWidget);
    });

    testWidgets('Navigation to second screen test', (
      WidgetTester tester,
    ) async {
      await tester.pumpApp(const MainApp());

      // Scroll to find the button
      await tester.scrollUntilVisible(find.text('Ver más ejemplos'), 100.0);

      // Find and tap the "Ver más ejemplos" button
      final button = find.text('Ver más ejemplos');
      expect(button, findsOneWidget);

      await tester.tap(button);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Verify we're on the second screen
      expect(find.text('Más Hooks Examples'), findsOneWidget);
    });

    testWidgets('Memoized calculation test', (WidgetTester tester) async {
      await tester.pumpApp(const MainApp());

      // Check initial calculation (0² × 1000 = 0)
      expect(find.text('Cálculo costoso: 0'), findsOneWidget);

      // Increment counter
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Check updated calculation (1² × 1000 = 1000)
      expect(find.text('Cálculo costoso: 1000'), findsOneWidget);

      // Increment again
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Check updated calculation (2² × 1000 = 4000)
      expect(find.text('Cálculo costoso: 4000'), findsOneWidget);
    });
  });
}

extension WidgetTesterExtensions on WidgetTester {
  Future<void> pumpApp(Widget widget) async {
    await pumpWidget(MaterialApp(home: widget));
  }
}
