# KeyValueTable

[![Pub Version](https://img.shields.io/pub/v/key_value_table.svg)](https://pub.dev/packages/key_value_table)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A lightweight, zero-dependency Flutter table widget that **perfectly aligns key-value pairs**. It calculates the intrinsic width of the longest key so all separators (colons, arrows, dashes) line up in vertical harmony.

### Desktop & Web Showcase

<p align="center">
  <img src="https://raw.githubusercontent.com/Amrit1345/key_value_table/main/doc/screenshots/demo_dark.png" alt="KeyValueTable in Dark Mode" width="720"/>
  <img src="https://raw.githubusercontent.com/Amrit1345/key_value_table/main/doc/screenshots/demo_dark.png" alt="KeyValueTable in Dark Mode (Desktop)" width="720"/>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/Amrit1345/key_value_table/main/doc/screenshots/demo_light.png" alt="KeyValueTable in Light Mode" width="720"/>
  <img src="https://raw.githubusercontent.com/Amrit1345/key_value_table/main/doc/screenshots/demo_light.png" alt="KeyValueTable in Light Mode (Desktop)" width="720"/>
</p>

### Mobile Responsive Showcase

<p align="center">
  <img src="https://raw.githubusercontent.com/Amrit1345/key_value_table/main/doc/screenshots/demo_dark_mobile.png" alt="KeyValueTable in Dark Mode (Mobile)" width="350"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://raw.githubusercontent.com/Amrit1345/key_value_table/main/doc/screenshots/demo_light_mobile.png" alt="KeyValueTable in Light Mode (Mobile)" width="350"/>
</p>

---

## Features

- ✨ **Automatic Column Alignment:** Uses Flutter's `IntrinsicColumnWidth` so labels never cause staggered colons.
- 🧩 **Rich Value Support:** Accepts strings, numbers, or full `Widget`s (e.g. `Chip`, `Badge`, `ElevatedButton`).
- 🎨 **Custom Separators:** Change from `:` to `→`, `-`, or provide your own widget.
- 🦓 **Zebra Striping & Borders:** Support for alternating row background colors and borders.
- 👆 **Row Callbacks:** Built-in `onRowTap` and `onRowLongPress` for copy-to-clipboard or navigation flows.
- 📱 **All Platforms:** Works across Android, iOS, Web, macOS, Windows, Linux.

---

## Getting started

Add `key_value_table` to your `pubspec.yaml`:

```yaml
dependencies:
  key_value_table: ^0.0.1
```

Or run:

```bash
flutter pub add key_value_table
```

---

## Usage

### 1. Basic Key-Value Display

```dart
import 'package:key_value_table/key_value_table.dart';

KeyValueTable(
  data: const {
    'Full Name': 'Dr. Alexander Fleming',
    'Specialty': 'Microbiology',
    'Nobel Prize': 1945,
  },
)
```

### 2. Rendering Custom Widgets (Badges, Chips)

```dart
KeyValueTable(
  data: {
    'Order ID': '#ORD-9921',
    'Status': Chip(
      label: Text('Delivered'),
      backgroundColor: Colors.green.shade100,
    ),
    'Total': '\$129.50',
  },
)
```

### 3. Custom Separator & Tap Action

```dart
KeyValueTable(
  separator: '→',
  separatorWidth: 24.0,
  alternateRowColor: Colors.grey.shade50,
  data: const {
    'Host': '127.0.0.1',
    'Port': '8080',
  },
  onRowTap: (context, key, value) {
    Clipboard.setData(ClipboardData(text: value.toString()));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied $key!')),
    );
  },
)
```

---

## Live Demo Application

Want to try out the complete interactive showcase across all platforms (Web, Mobile, Desktop) with real-time Light/Dark mode toggling?

Check out the companion open-source demo repository:  
👉 **[key_value_table_demo on GitHub](https://github.com/Amrit1345/key_value_table_demo)**

To run it locally:

```bash
git clone https://github.com/Amrit1345/key_value_table_demo.git
cd key_value_table_demo
flutter run
```

---

## Additional information

- **Package Repository:** [github.com/Amrit1345/key_value_table](https://github.com/Amrit1345/key_value_table)
- **Demo Project:** [github.com/Amrit1345/key_value_table_demo](https://github.com/Amrit1345/key_value_table_demo)
- **Issue Tracker:** [github.com/Amrit1345/key_value_table/issues](https://github.com/Amrit1345/key_value_table/issues)

