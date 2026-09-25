import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:key_value_table_example/main.dart';

void main() {
  testWidgets('renders KeyValueTable showcase screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const KeyValueTableExampleApp());

    expect(find.text('KeyValueTable Showcase'), findsWidgets);
    expect(find.text('Live Feature Gallery'), findsOneWidget);
    expect(find.text('1. Modern Clean Profile'), findsOneWidget);
    expect(find.text('Dr. Alexander Fleming'), findsOneWidget);
    expect(find.text('2. Financial & Receipt'), findsOneWidget);
  });

  testWidgets('toggle theme mode switches light/dark icons',
      (WidgetTester tester) async {
    await tester.pumpWidget(const KeyValueTableExampleApp());

    // Initially dark mode -> light_mode_rounded icon is shown
    expect(find.byIcon(Icons.light_mode_rounded), findsOneWidget);
    expect(find.byIcon(Icons.dark_mode_rounded), findsNothing);

    // Tap theme toggle button
    await tester.tap(find.byTooltip('Toggle Light/Dark Theme'));
    await tester.pumpAndSettle();

    // Now light mode -> dark_mode_rounded icon is shown
    expect(find.byIcon(Icons.dark_mode_rounded), findsOneWidget);
    expect(find.byIcon(Icons.light_mode_rounded), findsNothing);
  });
}
