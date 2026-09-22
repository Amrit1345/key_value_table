import 'package:flutter/material.dart';

/// Signature for a callback that builds a custom value widget.
typedef KeyValueWidgetBuilder = Widget Function(
  BuildContext context,
  String key,
  dynamic value,
);

/// Signature for a callback when a row is tapped or long pressed.
typedef KeyValueRowCallback = void Function(
  BuildContext context,
  String key,
  dynamic value,
);

/// A customizable Flutter widget that renders key-value pairs in a table
/// where separators (e.g. colons) automatically align based on the widest key.
class KeyValueTable extends StatelessWidget {
  /// The map data to display. Either [data] or [entries] must be provided.
  final Map<String, dynamic>? data;

  /// An explicit iterable of entries to display. Preserves ordering.
  final Iterable<MapEntry<String, dynamic>>? entries;

  /// String separator placed between key and value (default is `':'`).
  /// Pass an empty string `""` if no separator is desired.
  final String separator;

  /// Optional custom widget to render as the separator.
  /// If provided, this overrides [separator].
  final Widget? separatorWidget;

  /// Width of the separator column. Defaults to `16.0`.
  final double separatorWidth;

  /// Custom builder for rendering value widgets (badges, chips, links, etc.).
  final KeyValueWidgetBuilder? valueBuilder;

  /// Text style for the key labels. Defaults to [FontWeight.w600].
  final TextStyle? keyStyle;

  /// Text style for the values.
  final TextStyle? valueStyle;

  /// Text style for the separator string. Defaults to [keyStyle].
  final TextStyle? separatorStyle;

  /// Padding applied around each row's cells. Defaults to 4px vertical.
  final EdgeInsetsGeometry rowPadding;

  /// Vertical alignment of cells within a row. Defaults to [TableCellVerticalAlignment.top].
  final TableCellVerticalAlignment verticalAlignment;

  /// Optional decoration for table rows (e.g., borders).
  final TableBorder? border;

  /// Optional alternating background color for rows (zebra striping).
  final Color? alternateRowColor;

  /// Background color for regular (even index) rows.
  final Color? rowColor;

  /// Callback when a row is tapped.
  final KeyValueRowCallback? onRowTap;

  /// Callback when a row is long pressed.
  final KeyValueRowCallback? onRowLongPress;

  /// Creates a [KeyValueTable].
  ///
  /// Either [data] or [entries] must be non-null.
  const KeyValueTable({
    super.key,
    this.data,
    this.entries,
    this.separator = ':',
    this.separatorWidget,
    this.separatorWidth = 16.0,
    this.valueBuilder,
    this.keyStyle,
    this.valueStyle,
    this.separatorStyle,
    this.rowPadding = const EdgeInsets.symmetric(vertical: 4.0),
    this.verticalAlignment = TableCellVerticalAlignment.top,
    this.border,
    this.rowColor,
    this.alternateRowColor,
    this.onRowTap,
    this.onRowLongPress,
  }) : assert(
          data != null || entries != null,
          'Either data or entries must be provided.',
        );

  @override
  Widget build(BuildContext context) {
    final effectiveEntries = (entries ?? data!.entries).toList();
    final theme = Theme.of(context);
    final defaultKeyStyle = theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ) ??
        const TextStyle(fontWeight: FontWeight.w600);
    final defaultValueStyle = theme.textTheme.bodyMedium ?? const TextStyle();

    return Table(
      defaultVerticalAlignment: verticalAlignment,
      border: border,
      columnWidths: {
        0: const IntrinsicColumnWidth(),
        1: FixedColumnWidth(separatorWidth),
        2: const FlexColumnWidth(),
      },
      children: List.generate(effectiveEntries.length, (index) {
        final entry = effectiveEntries[index];
        final keyStr = entry.key;
        final val = entry.value;

        // Determine value widget
        Widget renderedValue;
        if (valueBuilder != null) {
          renderedValue = valueBuilder!(context, keyStr, val);
        } else if (val is Widget) {
          renderedValue = val;
        } else {
          renderedValue = Text(
            val?.toString() ?? '',
            style: valueStyle ?? defaultValueStyle,
          );
        }

        // Determine separator widget
        Widget renderedSeparator;
        if (separatorWidget != null) {
          renderedSeparator = separatorWidget!;
        } else if (separator.isNotEmpty) {
          renderedSeparator = Text(
            separator,
            style: separatorStyle ?? keyStyle ?? defaultKeyStyle,
          );
        } else {
          renderedSeparator = const SizedBox.shrink();
        }

        final currentRowColor = (alternateRowColor != null && index.isOdd)
            ? alternateRowColor
            : rowColor;

        Widget wrapRowCell(Widget child, {AlignmentGeometry? alignment}) {
          Widget cellContent = Padding(
            padding: rowPadding,
            child: alignment != null
                ? Align(alignment: alignment, child: child)
                : child,
          );

          if (onRowTap != null || onRowLongPress != null) {
            cellContent = InkWell(
              onTap: onRowTap != null
                  ? () => onRowTap!(context, keyStr, val)
                  : null,
              onLongPress: onRowLongPress != null
                  ? () => onRowLongPress!(context, keyStr, val)
                  : null,
              child: cellContent,
            );
          }

          if (currentRowColor != null) {
            cellContent = ColoredBox(
              color: currentRowColor,
              child: cellContent,
            );
          }

          return cellContent;
        }

        return TableRow(
          decoration: currentRowColor != null
              ? BoxDecoration(color: currentRowColor)
              : null,
          children: [
            wrapRowCell(
              Text(
                keyStr,
                style: keyStyle ?? defaultKeyStyle,
              ),
              alignment: Alignment.topLeft,
            ),
            wrapRowCell(
              renderedSeparator,
              alignment: Alignment.topCenter,
            ),
            wrapRowCell(
              renderedValue,
              alignment: Alignment.topLeft,
            ),
          ],
        );
      }),
    );
  }
}

