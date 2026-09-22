import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:key_value_table/key_value_table.dart';

void main() {
  testWidgets('renders key, separator, and value correctly from Map',
      (WidgetTester tester) async {
    final testData = {
      'Full Name': 'John Doe',
      'Role': 'Administrator',
      'Age': 32,
    };

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: KeyValueTable(data: testData),
        ),
      ),
    );

    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Role'), findsOneWidget);
    expect(find.text('Age'), findsOneWidget);
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Administrator'), findsOneWidget);
    expect(find.text('32'), findsOneWidget);
    expect(find.text(':'), findsNWidgets(3));
  });

  testWidgets('custom separator and width works as expected',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: KeyValueTable(
            data: {'Status': 'Active'},
            separator: '->',
            separatorWidth: 24.0,
          ),
        ),
      ),
    );

    expect(find.text('Status'), findsOneWidget);
    expect(find.text('->'), findsOneWidget);
    expect(find.text('Active'), findsOneWidget);
  });

  testWidgets('supports Widget as value', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: KeyValueTable(
            data: {
              'Status': Chip(label: Text('Approved')),
            },
          ),
        ),
      ),
    );

    expect(find.byType(Chip), findsOneWidget);
    expect(find.text('Approved'), findsOneWidget);
  });

  testWidgets('valueBuilder custom rendering works',
      (WidgetTester tester) async {
    final testData = {'Priority': 'High'};

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: KeyValueTable(
            data: testData,
            valueBuilder: (context, key, value) {
              return Text('CUSTOM_$value',
                  style: const TextStyle(color: Colors.red));
            },
          ),
        ),
      ),
    );

    expect(find.text('CUSTOM_High'), findsOneWidget);
  });

  testWidgets('row tap callback fires with key and value',
      (WidgetTester tester) async {
    String? tappedKey;
    dynamic tappedValue;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: KeyValueTable(
            data: const {'Email': 'test@example.com'},
            onRowTap: (context, key, value) {
              tappedKey = key;
              tappedValue = value;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Email'));
    expect(tappedKey, equals('Email'));
    expect(tappedValue, equals('test@example.com'));
  });

  testWidgets('row long press callback fires with key and value',
      (WidgetTester tester) async {
    String? longPressedKey;
    dynamic longPressedValue;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: KeyValueTable(
            data: const {'Website': 'https://flutter.dev'},
            onRowLongPress: (context, key, value) {
              longPressedKey = key;
              longPressedValue = value;
            },
          ),
        ),
      ),
    );

    await tester.longPress(find.text('Website'));
    expect(longPressedKey, equals('Website'));
    expect(longPressedValue, equals('https://flutter.dev'));
  });

  testWidgets('renders ordered entries when entries parameter is provided',
      (WidgetTester tester) async {
    final entries = [
      const MapEntry('Second', '2'),
      const MapEntry('First', '1'),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: KeyValueTable(entries: entries),
        ),
      ),
    );

    expect(find.text('Second'), findsOneWidget);
    expect(find.text('First'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('supports custom separator widget', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: KeyValueTable(
            data: {'Icon': 'Arrow'},
            separatorWidget: Icon(Icons.arrow_forward),
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
  });

  testWidgets('supports empty separator without errors',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: KeyValueTable(
            data: {'KeyOnly': 'ValueOnly'},
            separator: '',
          ),
        ),
      ),
    );

    expect(find.text('KeyOnly'), findsOneWidget);
    expect(find.text('ValueOnly'), findsOneWidget);
    expect(find.text(':'), findsNothing);
  });
}

