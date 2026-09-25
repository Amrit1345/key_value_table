import 'package:flutter/material.dart';

import 'key_value_table_widget.dart';

/// Represents a single row item in a [KeyValueTable], enabling granular,
/// row-level customization of alignment, styling, tooltips, and callbacks.
class KeyValueItem {
  /// The key label text.
  final String key;

  /// The value to display. Can be a [String], number, boolean, or any [Widget].
  final dynamic value;

  /// Optional widget displayed before the key label (e.g. an icon).
  final Widget? leading;

  /// Optional widget displayed after the value (e.g. a status badge or copy button).
  final Widget? trailing;

  /// Custom text style for this row's key label.
  final TextStyle? keyStyle;

  /// Custom text style for this row's value.
  final TextStyle? valueStyle;

  /// Alignment for this row's key cell (e.g. [Alignment.centerLeft] or [Alignment.centerRight]).
  final AlignmentGeometry? keyAlignment;

  /// Alignment for this row's value cell (e.g. [Alignment.centerLeft] or [Alignment.centerRight]).
  final AlignmentGeometry? valueAlignment;

  /// Explanatory tooltip message shown with an info icon next to the key label.
  final String? tooltip;

  /// Callback when this specific row is tapped. Overrides table-level [KeyValueTable.onRowTap].
  final KeyValueRowCallback? onTap;

  /// Callback when this specific row is long-pressed. Overrides table-level [KeyValueTable.onRowLongPress].
  final KeyValueRowCallback? onLongPress;

  /// Whether this specific row allows tap-to-copy. Overrides table-level [KeyValueTable.copyable].
  final bool? copyable;

  /// Creates a [KeyValueItem].
  const KeyValueItem({
    required this.key,
    required this.value,
    this.leading,
    this.trailing,
    this.keyStyle,
    this.valueStyle,
    this.keyAlignment,
    this.valueAlignment,
    this.tooltip,
    this.onTap,
    this.onLongPress,
    this.copyable,
  });
}
