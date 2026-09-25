# key_value_table Example
# KeyValueTable Showcase Example

This example demonstrates various features of the `key_value_table` package:
This interactive Flutter application demonstrates the full capabilities, design patterns, and layout options of the [`key_value_table`](https://pub.dev/packages/key_value_table) package.

1. **Simple Profile Details:** Basic key-value display with default formatting and intrinsic colon alignment.
2. **Custom Value Widgets & Badges:** Rendering custom `Widget`s such as status badges/chips directly in value cells.
3. **Custom Separator, Styling & Row Callbacks:** Custom arrow separator (`→`), alternating zebra striping row colors, and tap callbacks with `SnackBar` notifications.
---

## Running the Example
## What's Included

Run from the `example/` directory:
The showcase application features an adaptive responsive grid and **live Light/Dark theme switching** (via the AppBar icon button), covering 6 real-world scenarios:

1. **Modern Clean Profile (Default):**
   - Clean 2-column layout without colons.
   - Comfortable density preset with clean typography.
2. **Financial & E-Commerce Receipt:**
   - Left-aligned keys with right-aligned numeric/currency values.
   - Subtle horizontal row dividers.
3. **Form & Inspector Alignment:**
   - Traditional right-aligned keys with centered colon gutter and left-aligned values.
4. **Server Diagnostics & System Monitoring:**
   - Compact density, alternating zebra striping (`alternateRowColor`).
   - One-tap clipboard copy (`copyable: true`) with floating `SnackBar`.
   - Custom status badges and fallback null placeholder (`nullPlaceholder: '—'`).
5. **Responsive Stacked Layout:**
   - Label on top, value below — ideal for mobile feeds and long descriptions.
6. **Granular Control with `KeyValueItem`:**
   - Leading icons, trailing verified checkmarks, tooltips, custom styles, and action buttons.

---

## Running the Showcase

### 1. Prerequisites

Ensure Flutter is installed on your system:

```bash
flutter --version
```

### 2. Run the Example

From the root of this repository or inside `example/`:

```bash
cd example
flutter pub get
flutter run
```

---
### 3. Run Across Platforms

> **Looking for a full standalone multi-platform showcase application?**  
> Check out the companion demo repository with responsive layouts and real-time Light/Dark mode switching:  
> 👉 [key_value_table_demo on GitHub](https://github.com/Amrit1345/key_value_table_demo)
```bash
# Run in Chrome (Web)
flutter run -d chrome

# Run on Desktop (macOS / Linux / Windows)
flutter run -d linux
flutter run -d macos
flutter run -d windows

# Run on Mobile (Android / iOS)
flutter run -d <device-id>
```

### 4. Run Automated Tests

```bash
flutter test
```
