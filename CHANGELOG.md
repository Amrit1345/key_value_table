## 0.1.0

### 🚀 Modern UI Standards & Design Upgrades
* **No-Colon by Default:** By default, `separator` is now `null`, adopting modern UI design standards (Material 3, Apple HIG, Stripe).
* **Automatic 2-Column Collapse:** When no separator is provided, the table automatically collapses into a clean 2-column layout (`[Key, Value]`) with configurable `horizontalGap` (default `16.0`), eliminating phantom column gaps.
* **Traditional Separators:** Colons remain fully supported anytime by passing `separator: ':'` (or custom strings/widgets).

### 📐 Alignments & Density
* **Key & Value Alignment:** Added `keyAlignment` and `valueAlignment` (`AlignmentGeometry`, default `Alignment.centerLeft`). Allows left-aligned keys with right-aligned values (financial/receipt standard) or right-aligned keys (inspector/form standard).
* **Text Alignments:** Added `keyTextAlign` and `valueTextAlign` for fine-grained typography alignment.
* **Density Presets:** Added `KeyValueDensity` enum (`compact`, `regular`, `comfortable`) to quickly standardize table row padding.

### 🧩 Granular Row Controls (`KeyValueItem`)
* Introduced `KeyValueItem` model and `KeyValueTable.items` constructor:
  * `leading` and `trailing` widgets (icons, buttons, badges).
  * `tooltip` for inline label explanations.
  * Per-row `keyAlignment`, `valueAlignment`, `keyStyle`, `valueStyle`.
  * Per-row `onTap`, `onLongPress`, and `copyable` overrides.

### 📱 Responsive & Mobile Modes
* Added `KeyValueLayout` (`horizontal`, `stacked`, `auto`).
* `stacked` places labels above values, ideal for cards or multiline text.
* `auto` dynamically switches to stacked layout when container width is narrower than `breakpoint` (default `480.0`).

### 🛠️ Developer UX & Utilities
* **Tap-to-Copy:** Added `copyable: true` and `onCopy` callback to easily enable one-tap clipboard copying with a floating SnackBar.
* **Dividers:** Added `showDividers`, `dividerColor`, and `dividerThickness` for built-in subtle horizontal borders.
* **Null Handling:** Added `nullPlaceholder` (default `'—'`) and `hideEmptyRows: true` for clean data rendering.
* **Text Selection:** Added `isSelectable: true` to wrap the table in Flutter's `SelectionArea`.

### 🌟 Built-in Showcase Gallery (`example/`)
* Upgraded `example/` app with all 6 real-world scenarios, responsive grid layout, and real-time **Light/Dark theme toggling**.
* Added smooth scrolling animated showcase GIFs (`.gif`) in documentation.

## 0.0.3

* Fixed screenshot rendering in pub.dev README by using absolute GitHub raw image URLs.

## 0.0.2

* Added live showcase screenshots for desktop and mobile (dark and light modes).
* Added reference and quickstart links for the companion `key_value_table_demo` project.
* Added `screenshots` metadata in `pubspec.yaml` for pub.dev package gallery.

## 0.0.1

* Initial release of `key_value_table`.
* Automatic intrinsic column alignment for label-separator-value rows.
* Support for `Map<String, dynamic>` and `Iterable<MapEntry>`.
* Widget values support (Chips, Badges, RichText).
* Custom separator strings and widgets.
* Row tap and long-press event callbacks.
* Alternating row colors (zebra striping) and borders.
