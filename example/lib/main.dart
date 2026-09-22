import 'package:flutter/material.dart';
import 'package:key_value_table/key_value_table.dart';

void main() {
  runApp(const KeyValueTableExampleApp());
}

class KeyValueTableExampleApp extends StatelessWidget {
  const KeyValueTableExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KeyValueTable Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DemoHomeScreen(),
    );
  }
}

class DemoHomeScreen extends StatelessWidget {
  const DemoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KeyValueTable Demo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionHeader('1. Simple Profile Details'),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: KeyValueTable(
                data: {
                  'Full Name': 'Dr. Alexander Fleming',
                  'Specialty': 'Microbiology & Immunology',
                  'Hospital': 'St. Mary\'s Hospital, London',
                  'Registered Year': 1928,
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('2. Custom Value Widgets & Badges'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: KeyValueTable(
                data: {
                  'Order ID': '#ORD-2026-9921',
                  'Status': Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Shipped',
                      style: TextStyle(
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  'Amount': '\$249.99 USD',
                  'Payment': 'Mastercard (ending 4242)',
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('3. Custom Separator & Tap Callback'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: KeyValueTable(
                separator: '→',
                separatorWidth: 28.0,
                alternateRowColor: Colors.grey.shade100,
                rowPadding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                data: const {
                  'Server Host': 'api.production.internal',
                  'IP Address': '192.168.1.150',
                  'Port': 8080,
                  'SSL Encrypted': 'True (TLS 1.3)',
                },
                onRowTap: (context, key, value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Tapped "$key": $value'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}

