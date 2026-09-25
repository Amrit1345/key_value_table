# KeyValueTable

[![Pub Version](https://img.shields.io/pub/v/key_value_table.svg)](https://pub.dev/packages/key_value_table)
[![Pub Points](https://img.shields.io/pub/points/key_value_table)](https://pub.dev/packages/key_value_table/score)
[![CI](https://github.com/Amrit1345/key_value_table/actions/workflows/ci.yml/badge.svg)](https://github.com/Amrit1345/key_value_table/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub stars](https://img.shields.io/github/stars/Amrit1345/key_value_table.svg?style=flat&logo=github)](https://github.com/Amrit1345/key_value_table/stargazers)

A modern, highly customizable Flutter table widget for **clean, perfectly aligned key-value pairs**. Designed to follow modern UI design standards (Material 3, Apple HIG, Stripe, Shopify Polaris) with automatic 2-column clean whitespace, optional separators, configurable key/value alignments, responsive stacked layouts, and granular item-level controls.

### Desktop & Web Showcase

<p align="center">
  <img src="https://raw.githubusercontent.com/Amrit1345/key_value_table/main/doc/screenshots/demo_dark.png" alt="KeyValueTable in Dark Mode (Desktop)" width="720"/>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/Amrit1345/key_value_table/main/doc/screenshots/demo_light.png" alt="KeyValueTable in Light Mode (Desktop)" width="720"/>
</p>

### Mobile Responsive Showcase

<p align="center">
  <img src="https://raw.githubusercontent.com/Amrit1345/key_value_table/main/doc/screenshots/demo_dark_mobile.gif" alt="KeyValueTable in Dark Mode (Mobile Scroll)" width="350"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://raw.githubusercontent.com/Amrit1345/key_value_table/main/doc/screenshots/demo_light_mobile.gif" alt="KeyValueTable in Light Mode (Mobile Scroll)" width="350"/>
</p>

---

## Features

- ✨ **Modern Clean Whitespace by Default:** No colons by default; renders a clean 2-column layout with consistent `horizontalGap`.
- 📐 **Key & Value Alignment Customization:** Align keys and values independently (e.g. left-aligned keys with right-aligned values for financial receipts, or right-aligned keys with colon gutters for inspector forms).
- 🏷️ **Granular Per-Row Control (`KeyValueItem`):** Define leading icons, trailing badges/actions, tooltips, and per-item styles or tap handlers.
- 📱 **Responsive & Stacked Modes:** Switch between `horizontal`, `stacked` (label on top, value below), or `auto` (switches automatically on mobile breakpoints).
- 📏 **Density Presets:** `compact` (2px), `regular` (6px), and `comfortable` (12px) padding presets.
- 📋 **Tap-to-Copy (`copyable`):** Built-in one-tap clipboard copying with a floating SnackBar or custom callback.
- ➖ **Built-in Dividers & Row Styling:** Easily enable subtle horizontal row dividers (`showDividers`) or alternating zebra striping.
- ❓ **Null Handling:** Automatic fallback placeholder (`nullPlaceholder: '—'`) and optional empty row filtering (`hideEmptyRows: true`).
- 🔤 **Text Selectable:** Wrap entire table in `SelectionArea` with a single flag (`isSelectable: true`).
- 🧩 **Rich Value Widgets:** Pass any widget (`Chip`, `Badge`, `ElevatedButton`, custom status indicators) directly as a value.

---

## Getting started

Add `key_value_table` to your `pubspec.yaml`:

```yaml
dependencies:
  key_value_table: ^0.1.0
```

Or run:

```bash
flutter pub add key_value_table
```

---

## Usage Scenarios

### 1. Modern Clean Key-Value (Default)
By default, colons are omitted and keys and values are cleanly separated by whitespace:

```dart
import 'package:key_value_table/key_value_table.dart';

KeyValueTable(
  density: KeyValueDensity.comfortable,
  data: const {
    'Full Name': 'Dr. Alexander Fleming',
    'Specialty': 'Microbiology & Immunology',
    'Hospital': "St. Mary's Hospital, London",
    'Registered': 1928,
  },
)
```

### 2. Financial & E-Commerce Receipt (Right-Aligned Values)
Align keys to the left and currency values to the right with horizontal row dividers:

```dart
KeyValueTable(
  keyAlignment: Alignment.centerLeft,
  valueAlignment: Alignment.centerRight,
  showDividers: true,
  data: {
    'Noise-Canceling Headphones': '$299.00',
    'Eco Protection Plan (2 Yr)': '$39.00',
    'Standard Shipping': 'FREE',
    'Estimated Tax': '$24.50',
    'Order Total': const Text(
      '$362.50 USD',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
    ),
  },
)
```

### 3. Inspector / Form Layout (Right-Aligned Keys with Colons)
Create a classic inspector where all keys end at the same column and colons line up vertically:

```dart
KeyValueTable(
  separator: ':',
  separatorWidth: 20.0,
  keyAlignment: Alignment.centerRight,
  valueAlignment: Alignment.centerLeft,
  data: const {
    'Host': '10.244.3.188',
    'Environment': 'Production',
    'Port': 8080,
  },
)
```

### 4. Server Diagnostics (Zebra Striping & Tap-to-Copy)
Enable `copyable: true` to let users tap any row to copy its value to the clipboard:

```dart
KeyValueTable(
  density: KeyValueDensity.compact,
  alternateRowColor: Colors.grey.shade100,
  copyable: true,
  data: {
    'Host': 'api.production.internal',
    'Cluster': 'k8s-us-east-1',
    'API Token': 'sk_live_99a8b7c6d5e4f3a2b1c0',
    'Backup Node': null, // Renders '—'
  },
)
```

### 5. Responsive & Stacked Layout (Mobile-Friendly)
Stack keys and values vertically for small screens or multiline descriptions:

```dart
KeyValueTable(
  layout: KeyValueLayout.stacked, // or KeyValueLayout.auto with breakpoint: 480
  density: KeyValueDensity.comfortable,
  showDividers: true,
  data: const {
    'Architecture Goal':
        'Deliver deterministic, highly extensible key-value presentation across all Flutter form factors.',
    'Telemetry Endpoint':
        'https://telemetry.analytics.internal/v2/ingest?batch=true&compress=gzip',
  },
)
```

### 6. Granular Row Control with `KeyValueItem`
Use `KeyValueTable.items` to configure icons, tooltips, and per-item styles:

```dart
KeyValueTable.items(
  density: KeyValueDensity.comfortable,
  showDividers: true,
  items: [
    const KeyValueItem(
      leading: Icon(Icons.person_outline, size: 18),
      key: 'Account Owner',
      value: 'Amrit (Senior Engineer)',
      tooltip: 'Verified organization primary contact',
    ),
    const KeyValueItem(
      leading: Icon(Icons.verified_user_outlined, size: 18, color: Colors.teal),
      key: 'Two-Factor Auth',
      value: 'Enforced via FIDO2',
      trailing: Icon(Icons.check_circle, size: 16, color: Colors.teal),
    ),
  ],
)
```

---

## Properties Reference

| Property | Type | Default | Description |
|---|---|---|---|
| `data` | `Map<String, dynamic>?` | `null` | Key-value pairs as a Map. |
| `entries` | `Iterable<MapEntry<String, dynamic>>?` | `null` | Explicitly ordered key-value pairs. |
| `items` | `List<KeyValueItem>?` | `null` | Granular list of items with per-row customizations. |
| `separator` | `String?` | `null` | Separator text (e.g. `':'`, `'->'`). Defaults to `null` (no colon). |
| `separatorWidget` | `Widget?` | `null` | Custom widget to use as separator. |
| `separatorWidth` | `double` | `16.0` | Width of the separator column in 3-column mode. |
| `horizontalGap` | `double` | `16.0` | Gap between key and value in 2-column mode (when separator is null). |
| `keyAlignment` | `AlignmentGeometry` | `Alignment.centerLeft` | Alignment for key cells. |
| `valueAlignment` | `AlignmentGeometry` | `Alignment.centerLeft` | Alignment for value cells. |
| `keyTextAlign` | `TextAlign?` | `null` | Text alignment for key labels. |
| `valueTextAlign` | `TextAlign?` | `null` | Text alignment for value text. |
| `layout` | `KeyValueLayout` | `KeyValueLayout.horizontal` | Layout mode: `horizontal`, `stacked`, or `auto`. |
| `breakpoint` | `double` | `480.0` | Breakpoint width for `KeyValueLayout.auto`. |
| `density` | `KeyValueDensity` | `KeyValueDensity.regular` | Spacing preset: `compact` (2px), `regular` (6px), `comfortable` (12px). |
| `showDividers` | `bool` | `false` | Whether to draw horizontal dividers between rows. |
| `dividerColor` | `Color?` | `null` | Custom color for row dividers. |
| `dividerThickness` | `double` | `1.0` | Thickness of row dividers. |
| `copyable` | `bool` | `false` | Whether tapping rows copies value to clipboard. |
| `onCopy` | `KeyValueRowCallback?` | `null` | Custom callback invoked when value is copied. |
| `isSelectable` | `bool` | `false` | Wraps table in Flutter `SelectionArea`. |
| `nullPlaceholder` | `String` | `'—'` | Text rendered when value is null. |
| `hideEmptyRows` | `bool` | `false` | When true, hides rows whose values are null or empty. |
| `rowColor` | `Color?` | `null` | Background color for all rows. |
| `alternateRowColor` | `Color?` | `null` | Background color for odd rows (zebra striping). |
| `onRowTap` | `KeyValueRowCallback?` | `null` | Callback when a row is tapped. |
| `onRowLongPress` | `KeyValueRowCallback?` | `null` | Callback when a row is long-pressed. |

---

## Running the Example Showcase App

The repository includes a comprehensive, interactive showcase app under [`example/`](example/) demonstrating all 6 scenarios with real-time **Light/Dark theme toggling** and responsive grid layouts.

To run it locally:

```bash
# 1. Clone the repository
git clone https://github.com/Amrit1345/key_value_table.git

# 2. Navigate to the example project
cd key_value_table/example

# 3. Get dependencies and run
flutter pub get
flutter run
```

You can run it across Web, Desktop (macOS, Linux, Windows), and Mobile (Android, iOS):

```bash
flutter run -d chrome    # Run in Chrome
flutter run -d linux     # Run on Linux desktop
flutter run -d macos     # Run on macOS desktop
flutter run -d windows   # Run on Windows desktop
```

---

## Contributing

Contributions are always welcome! Whether you are fixing bugs, improving documentation, or proposing new layout modes:

1. Read our [Contributing Guide](CONTRIBUTING.md) to get started.
2. Review our [Code of Conduct](CODE_OF_CONDUCT.md).
3. Check out the [Issue Tracker](https://github.com/Amrit1345/key_value_table/issues) to report bugs or request features.
4. Submit a Pull Request following our [PR Template](.github/PULL_REQUEST_TEMPLATE.md).

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Additional Information

- **Package Repository:** [github.com/Amrit1345/key_value_table](https://github.com/Amrit1345/key_value_table)
- **Example Showcase:** [github.com/Amrit1345/key_value_table/tree/main/example](https://github.com/Amrit1345/key_value_table/tree/main/example)
- **Issue Tracker:** [github.com/Amrit1345/key_value_table/issues](https://github.com/Amrit1345/key_value_table/issues)

