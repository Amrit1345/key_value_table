import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:key_value_table/key_value_table.dart';

void main() {
  testWidgets('renders key and value correctly without separator by default',
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
    // Colons should not be rendered by default
    expect(find.text(':'), findsNothing);
  });

  testWidgets('renders separator when explicitly provided',
      (WidgetTester tester) async {
    final testData = {
      'Full Name': 'John Doe',
      'Role': 'Administrator',
      'Age': 32,
    };

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: KeyValueTable(
            data: testData,
            separator: ':',
          ),
        ),
      ),
    );

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

  testWidgets(
      'KeyValueTable.items renders KeyValueItem list with custom properties',
      (WidgetTester tester) async {
    final items = [
      const KeyValueItem(
        key: 'Username',
        value: 'amrit_flutter',
        leading: Icon(Icons.person, key: ValueKey('leading_icon')),
        trailing: Icon(Icons.verified, key: ValueKey('trailing_icon')),
        tooltip: 'Your public handle',
      ),
      const KeyValueItem(
        key: 'Badges',
        value: Text('Pro Developer'),
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: KeyValueTable.items(items: items),
        ),
      ),
    );

    expect(find.text('Username'), findsOneWidget);
    expect(find.text('amrit_flutter'), findsOneWidget);
    expect(find.byKey(const ValueKey('leading_icon')), findsOneWidget);
    expect(find.byKey(const ValueKey('trailing_icon')), findsOneWidget);
    expect(find.byTooltip('Your public handle'), findsOneWidget);
    expect(find.text('Badges'), findsOneWidget);
    expect(find.text('Pro Developer'), findsOneWidget);
  });

  testWidgets('per-row onTap in KeyValueItem is called when row is tapped',
      (WidgetTester tester) async {
    bool itemTapped = false;
    bool tableTapped = false;

    final items = [
      KeyValueItem(
        key: 'Row1',
        value: 'Value1',
        onTap: (ctx, k, v) => itemTapped = true,
      ),
      const KeyValueItem(
        key: 'Row2',
        value: 'Value2',
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: KeyValueTable.items(
            items: items,
            onRowTap: (ctx, k, v) => tableTapped = true,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Row1'));
    expect(itemTapped, isTrue);
    expect(tableTapped, isFalse);

    await tester.tap(find.text('Row2'));
    expect(tableTapped, isTrue);
  });

  testWidgets('keyAlignment and valueAlignment positions cells properly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: KeyValueTable(
            data: {'Price': '\$99.00'},
            keyAlignment: Alignment.centerLeft,
            valueAlignment: Alignment.centerRight,
          ),
        ),
      ),
    );

    final keyAlign = tester.widget<Align>(
      find
          .ancestor(
            of: find.text('Price'),
            matching: find.byType(Align),
          )
          .first,
    );
    expect(keyAlign.alignment, Alignment.centerLeft);

    final valueAlign = tester.widget<Align>(
      find
          .ancestor(
            of: find.text('\$99.00'),
            matching: find.byType(Align),
          )
          .first,
    );
    expect(valueAlign.alignment, Alignment.centerRight);
  });

  testWidgets('nullPlaceholder displays fallback for null values',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: KeyValueTable(
            data: {'Middle Name': null},
            nullPlaceholder: 'N/A',
          ),
        ),
      ),
    );

    expect(find.text('Middle Name'), findsOneWidget);
    expect(find.text('N/A'), findsOneWidget);
  });

  testWidgets('hideEmptyRows removes null or empty string rows',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: KeyValueTable(
            data: {
              'Visible': 'Yes',
              'NullKey': null,
              'EmptyKey': '',
            },
            hideEmptyRows: true,
          ),
        ),
      ),
    );

    expect(find.text('Visible'), findsOneWidget);
    expect(find.text('NullKey'), findsNothing);
    expect(find.text('EmptyKey'), findsNothing);
  });

  testWidgets('copyable row invokes copy callback and copies value on tap',
      (WidgetTester tester) async {
    String? copiedValue;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: KeyValueTable(
            data: const {'API Key': 'secret_token_123'},
            copyable: true,
            onCopy: (ctx, k, v) => copiedValue = v?.toString(),
          ),
        ),
      ),
    );

    expect(find.text('secret_token_123'), findsOneWidget);

    await tester.tap(find.text('secret_token_123'));
    await tester.pump();

    expect(copiedValue, equals('secret_token_123'));
  });

  testWidgets('isSelectable wraps table content in SelectionArea',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: KeyValueTable(
            data: {'Key': 'Value'},
            isSelectable: true,
          ),
        ),
      ),
    );

    expect(find.byType(SelectionArea), findsOneWidget);
  });

  testWidgets('KeyValueLayout.stacked renders rows in a stacked column layout',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: KeyValueTable(
            data: {'Description': 'Long descriptive text here'},
            layout: KeyValueLayout.stacked,
          ),
        ),
      ),
    );

    // In stacked mode, key and value are rendered inside Columns instead of Table
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Long descriptive text here'), findsOneWidget);
    expect(find.byType(Table), findsNothing);
  });
}
