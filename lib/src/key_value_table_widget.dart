import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'key_value_item.dart';
import 'key_value_types.dart';

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

/// A customizable Flutter widget that renders key-value pairs with intrinsic
/// column width alignment, flexible alignments, modern no-colon layouts,
/// density presets, and rich interactivity.
class KeyValueTable extends StatelessWidget {
  /// The map data to display. Either [data], [entries], or [items] must be provided.
  final Map<String, dynamic>? data;

  /// An explicit iterable of entries to display. Preserves ordering.
  final Iterable<MapEntry<String, dynamic>>? entries;

  /// A list of [KeyValueItem] objects for granular, row-level customization.
  final List<KeyValueItem>? items;

  /// String separator placed between key and value (e.g. `':'` or `'->'`).
  /// Defaults to `null` (no separator, modern clean whitespace).
  final String? separator;

  /// Optional custom widget to render as the separator.
  /// If provided, this overrides [separator].
  final Widget? separatorWidget;

  /// Width of the separator column when a separator is present. Defaults to `16.0`.
  final double separatorWidth;

  /// Horizontal spacing between the key and value columns when no separator is used.
  /// Defaults to `16.0`.
  final double horizontalGap;

  /// Alignment of the key label within its cell.
  /// Defaults to [Alignment.centerLeft]. Set to [Alignment.centerRight] for form/inspector styles.
  final AlignmentGeometry keyAlignment;

  /// Alignment of the value within its cell.
  /// Defaults to [Alignment.centerLeft]. Set to [Alignment.centerRight] for financial/receipt styles.
  final AlignmentGeometry valueAlignment;

  /// Text alignment for key labels.
  final TextAlign? keyTextAlign;

  /// Text alignment for value labels.
  final TextAlign? valueTextAlign;

  /// Column sizing specification for the key column.
  /// Defaults to [IntrinsicColumnWidth].
  final TableColumnWidth? keyColumnWidth;

  /// Column sizing specification for the value column.
  /// Defaults to [FlexColumnWidth].
  final TableColumnWidth? valueColumnWidth;

  /// Maximum width constraint for the key column before wrapping.
  final double? maxKeyWidth;

  /// Custom builder for rendering value widgets (badges, chips, links, etc.).
  final KeyValueWidgetBuilder? valueBuilder;

  /// Text style for the key labels. Defaults to [FontWeight.w600].
  final TextStyle? keyStyle;

  /// Text style for the values.
  final TextStyle? valueStyle;

  /// Text style for the separator string. Defaults to [keyStyle].
  final TextStyle? separatorStyle;

  /// Spacing density preset. Defaults to [KeyValueDensity.regular].
  final KeyValueDensity density;

  /// Padding applied around each row's cells. Overrides [density] if specified.
  final EdgeInsetsGeometry? rowPadding;

  /// Vertical alignment of cells within a row. Defaults to [TableCellVerticalAlignment.middle].
  final TableCellVerticalAlignment verticalAlignment;

  /// Table layout mode. Defaults to [KeyValueLayout.horizontal].
  final KeyValueLayout layout;

  /// Viewport width breakpoint below which [KeyValueLayout.auto] switches to stacked.
  /// Defaults to `480.0`.
  final double breakpoint;

  /// Optional decoration for table rows (e.g., borders).
  final TableBorder? border;

  /// Whether to draw subtle horizontal divider lines between rows. Defaults to `false`.
  final bool showDividers;

  /// Color of the row dividers when [showDividers] is `true`.
  final Color? dividerColor;

  /// Thickness of row dividers when [showDividers] is `true`. Defaults to `1.0`.
  final double dividerThickness;

  /// Optional alternating background color for rows (zebra striping).
  final Color? alternateRowColor;

  /// Background color for regular (even index) rows.
  final Color? rowColor;

  /// Callback when a row is tapped.
  final KeyValueRowCallback? onRowTap;

  /// Callback when a row is long pressed.
  final KeyValueRowCallback? onRowLongPress;

  /// Whether tapping a row automatically copies the value to the clipboard.
  /// Defaults to `false`.
  final bool copyable;

  /// Custom callback triggered when a row's value is copied to clipboard.
  final KeyValueRowCallback? onCopy;

  /// Whether the table's text can be selected with a mouse/cursor. Defaults to `false`.
  final bool isSelectable;

  /// String rendered when a value is `null`. Defaults to `'—'`.
  final String nullPlaceholder;

  /// Whether to omit rows whose value is `null` or empty. Defaults to `false`.
  final bool hideEmptyRows;

  /// Creates a [KeyValueTable].
  ///
  /// Either [data], [entries], or [items] must be non-null.
  const KeyValueTable({
    super.key,
    this.data,
    this.entries,
    this.items,
    this.separator,
    this.separatorWidget,
    this.separatorWidth = 16.0,
    this.horizontalGap = 16.0,
    this.keyAlignment = Alignment.centerLeft,
    this.valueAlignment = Alignment.centerLeft,
    this.keyTextAlign,
    this.valueTextAlign,
    this.keyColumnWidth,
    this.valueColumnWidth,
    this.maxKeyWidth,
    this.valueBuilder,
    this.keyStyle,
    this.valueStyle,
    this.separatorStyle,
    this.density = KeyValueDensity.regular,
    this.rowPadding,
    this.verticalAlignment = TableCellVerticalAlignment.middle,
    this.layout = KeyValueLayout.horizontal,
    this.breakpoint = 480.0,
    this.border,
    this.showDividers = false,
    this.dividerColor,
    this.dividerThickness = 1.0,
    this.rowColor,
    this.alternateRowColor,
    this.onRowTap,
    this.onRowLongPress,
    this.copyable = false,
    this.onCopy,
    this.isSelectable = false,
    this.nullPlaceholder = '—',
    this.hideEmptyRows = false,
  }) : assert(
          data != null || entries != null || items != null,
          'Either data, entries, or items must be provided.',
        );

  /// Creates a [KeyValueTable] from a list of [KeyValueItem] objects.
  const KeyValueTable.items({
    super.key,
    required this.items,
    this.separator,
    this.separatorWidget,
    this.separatorWidth = 16.0,
    this.horizontalGap = 16.0,
    this.keyAlignment = Alignment.centerLeft,
    this.valueAlignment = Alignment.centerLeft,
    this.keyTextAlign,
    this.valueTextAlign,
    this.keyColumnWidth,
    this.valueColumnWidth,
    this.maxKeyWidth,
    this.valueBuilder,
    this.keyStyle,
    this.valueStyle,
    this.separatorStyle,
    this.density = KeyValueDensity.regular,
    this.rowPadding,
    this.verticalAlignment = TableCellVerticalAlignment.middle,
    this.layout = KeyValueLayout.horizontal,
    this.breakpoint = 480.0,
    this.border,
    this.showDividers = false,
    this.dividerColor,
    this.dividerThickness = 1.0,
    this.rowColor,
    this.alternateRowColor,
    this.onRowTap,
    this.onRowLongPress,
    this.copyable = false,
    this.onCopy,
    this.isSelectable = false,
    this.nullPlaceholder = '—',
    this.hideEmptyRows = false,
  })  : data = null,
        entries = null;

  /// Whether a visible separator string or widget is present.
  bool get _hasSeparator =>
      separatorWidget != null || (separator != null && separator!.isNotEmpty);

  /// Computes effective row padding from [density] or explicit [rowPadding].
  EdgeInsetsGeometry get _effectiveRowPadding {
    if (rowPadding != null) return rowPadding!;
    switch (density) {
      case KeyValueDensity.compact:
        return const EdgeInsets.symmetric(vertical: 2.0);
      case KeyValueDensity.comfortable:
        return const EdgeInsets.symmetric(vertical: 12.0);
      case KeyValueDensity.regular:
        return const EdgeInsets.symmetric(vertical: 6.0);
    }
  }

  /// Normalizes data sources into a unified list of [KeyValueItem].
  List<KeyValueItem> _resolveItems() {
    List<KeyValueItem> rawList;
    if (items != null) {
      rawList = items!;
    } else if (entries != null) {
      rawList = entries!
          .map((e) => KeyValueItem(key: e.key, value: e.value))
          .toList();
    } else {
      rawList = data!.entries
          .map((e) => KeyValueItem(key: e.key, value: e.value))
          .toList();
    }

    if (!hideEmptyRows) return rawList;

    return rawList.where((item) {
      final val = item.value;
      if (val == null) return false;
      if (val is String && val.trim().isEmpty) return false;
      if (val is Iterable && val.isEmpty) return false;
      if (val is Map && val.isEmpty) return false;
      return true;
    }).toList();
  }

  void _handleCopy(BuildContext context, String key, dynamic value) {
    final textToCopy = value?.toString() ?? '';
    Clipboard.setData(ClipboardData(text: textToCopy));
    if (onCopy != null) {
      onCopy!(context, key, value);
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Copied "$key" to clipboard'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final resolvedItems = _resolveItems();
    final theme = Theme.of(context);

    Widget content;
    switch (layout) {
      case KeyValueLayout.stacked:
        content = _buildStackedLayout(context, theme, resolvedItems);
        break;
      case KeyValueLayout.auto:
        content = LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < breakpoint) {
              return _buildStackedLayout(context, theme, resolvedItems);
            }
            return _buildHorizontalLayout(context, theme, resolvedItems);
          },
        );
        break;
      case KeyValueLayout.horizontal:
        content = _buildHorizontalLayout(context, theme, resolvedItems);
        break;
    }

    if (isSelectable) {
      return SelectionArea(child: content);
    }
    return content;
  }

  Widget _buildKeyWidget(
    BuildContext context,
    ThemeData theme,
    KeyValueItem item,
    TextStyle defaultKeyStyle,
  ) {
    final effectiveStyle = item.keyStyle ?? keyStyle ?? defaultKeyStyle;

    Widget keyText = Text(
      item.key,
      style: effectiveStyle,
      textAlign: keyTextAlign,
    );

    if (maxKeyWidth != null) {
      keyText = ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxKeyWidth!),
        child: keyText,
      );
    }

    if (item.leading == null && item.tooltip == null) {
      return keyText;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (item.leading != null) ...[
          item.leading!,
          const SizedBox(width: 8),
        ],
        Flexible(child: keyText),
        if (item.tooltip != null) ...[
          const SizedBox(width: 4),
          Tooltip(
            message: item.tooltip!,
            child: Icon(
              Icons.info_outline,
              size: 14,
              color: effectiveStyle.color ?? theme.colorScheme.outline,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildValueWidget(
    BuildContext context,
    ThemeData theme,
    KeyValueItem item,
    TextStyle defaultValueStyle,
  ) {
    final val = item.value;
    Widget rendered;

    if (valueBuilder != null) {
      rendered = valueBuilder!(context, item.key, val);
    } else if (val is Widget) {
      rendered = val;
    } else if (val == null) {
      rendered = Text(
        nullPlaceholder,
        style: (item.valueStyle ?? valueStyle ?? defaultValueStyle).copyWith(
          color: theme.colorScheme.outline,
        ),
        textAlign: valueTextAlign,
      );
    } else {
      rendered = Text(
        val.toString(),
        style: item.valueStyle ?? valueStyle ?? defaultValueStyle,
        textAlign: valueTextAlign,
      );
    }

    if (item.trailing != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(child: rendered),
          const SizedBox(width: 8),
          item.trailing!,
        ],
      );
    }

    return rendered;
  }

  Widget _buildSeparatorWidget(
    BuildContext context,
    ThemeData theme,
    TextStyle defaultKeyStyle,
  ) {
    if (separatorWidget != null) {
      return separatorWidget!;
    }
    if (separator != null && separator!.isNotEmpty) {
      return Text(
        separator!,
        style: separatorStyle ?? keyStyle ?? defaultKeyStyle,
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildHorizontalLayout(
    BuildContext context,
    ThemeData theme,
    List<KeyValueItem> resolvedItems,
  ) {
    final defaultKeyStyle = theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ) ??
        const TextStyle(fontWeight: FontWeight.w600);
    final defaultValueStyle = theme.textTheme.bodyMedium ?? const TextStyle();

    final effectiveDividerColor =
        dividerColor ?? theme.dividerColor.withValues(alpha: 0.3);

    final effectiveBorder = border ??
        (showDividers
            ? TableBorder(
                horizontalInside: BorderSide(
                  color: effectiveDividerColor,
                  width: dividerThickness,
                ),
              )
            : null);

    final padding = _effectiveRowPadding;

    if (_hasSeparator) {
      // 3-Column Layout: [Key, Separator, Value]
      return Table(
        defaultVerticalAlignment: verticalAlignment,
        border: effectiveBorder,
        columnWidths: {
          0: keyColumnWidth ?? const IntrinsicColumnWidth(),
          1: FixedColumnWidth(separatorWidth),
          2: valueColumnWidth ?? const FlexColumnWidth(),
        },
        children: List.generate(resolvedItems.length, (index) {
          final item = resolvedItems[index];
          final currentRowColor = (alternateRowColor != null && index.isOdd)
              ? alternateRowColor
              : rowColor;

          final effectiveKeyAlign = item.keyAlignment ?? keyAlignment;
          final effectiveValueAlign = item.valueAlignment ?? valueAlignment;

          final isRowCopyable = item.copyable ?? copyable;
          final effectiveTap = isRowCopyable
              ? () => _handleCopy(context, item.key, item.value)
              : (item.onTap != null
                  ? () => item.onTap!(context, item.key, item.value)
                  : (onRowTap != null
                      ? () => onRowTap!(context, item.key, item.value)
                      : null));

          final effectiveLongPress = item.onLongPress != null
              ? () => item.onLongPress!(context, item.key, item.value)
              : (onRowLongPress != null
                  ? () => onRowLongPress!(context, item.key, item.value)
                  : null);

          Widget wrapCell(Widget child, {AlignmentGeometry? alignment}) {
            Widget cell = Padding(
              padding: padding,
              child: alignment != null
                  ? Align(alignment: alignment, child: child)
                  : child,
            );

            if (effectiveTap != null || effectiveLongPress != null) {
              cell = InkWell(
                onTap: effectiveTap,
                onLongPress: effectiveLongPress,
                child: cell,
              );
            }

            if (currentRowColor != null) {
              cell = ColoredBox(color: currentRowColor, child: cell);
            }

            return cell;
          }

          return TableRow(
            decoration: currentRowColor != null
                ? BoxDecoration(color: currentRowColor)
                : null,
            children: [
              wrapCell(
                _buildKeyWidget(context, theme, item, defaultKeyStyle),
                alignment: effectiveKeyAlign,
              ),
              wrapCell(
                _buildSeparatorWidget(context, theme, defaultKeyStyle),
                alignment: Alignment.center,
              ),
              wrapCell(
                _buildValueWidget(context, theme, item, defaultValueStyle),
                alignment: effectiveValueAlign,
              ),
            ],
          );
        }),
      );
    } else {
      // 2-Column Layout: [Key, Value] with horizontal gap
      final keyPadding = padding.add(EdgeInsets.only(right: horizontalGap / 2));
      final valuePadding =
          padding.add(EdgeInsets.only(left: horizontalGap / 2));

      return Table(
        defaultVerticalAlignment: verticalAlignment,
        border: effectiveBorder,
        columnWidths: {
          0: keyColumnWidth ?? const IntrinsicColumnWidth(),
          1: valueColumnWidth ?? const FlexColumnWidth(),
        },
        children: List.generate(resolvedItems.length, (index) {
          final item = resolvedItems[index];
          final currentRowColor = (alternateRowColor != null && index.isOdd)
              ? alternateRowColor
              : rowColor;

          final effectiveKeyAlign = item.keyAlignment ?? keyAlignment;
          final effectiveValueAlign = item.valueAlignment ?? valueAlignment;

          final isRowCopyable = item.copyable ?? copyable;
          final effectiveTap = isRowCopyable
              ? () => _handleCopy(context, item.key, item.value)
              : (item.onTap != null
                  ? () => item.onTap!(context, item.key, item.value)
                  : (onRowTap != null
                      ? () => onRowTap!(context, item.key, item.value)
                      : null));

          final effectiveLongPress = item.onLongPress != null
              ? () => item.onLongPress!(context, item.key, item.value)
              : (onRowLongPress != null
                  ? () => onRowLongPress!(context, item.key, item.value)
                  : null);

          Widget wrapCell(Widget child, EdgeInsetsGeometry cellPadding,
              {AlignmentGeometry? alignment}) {
            Widget cell = Padding(
              padding: cellPadding,
              child: alignment != null
                  ? Align(alignment: alignment, child: child)
                  : child,
            );

            if (effectiveTap != null || effectiveLongPress != null) {
              cell = InkWell(
                onTap: effectiveTap,
                onLongPress: effectiveLongPress,
                child: cell,
              );
            }

            if (currentRowColor != null) {
              cell = ColoredBox(color: currentRowColor, child: cell);
            }

            return cell;
          }

          return TableRow(
            decoration: currentRowColor != null
                ? BoxDecoration(color: currentRowColor)
                : null,
            children: [
              wrapCell(
                _buildKeyWidget(context, theme, item, defaultKeyStyle),
                keyPadding,
                alignment: effectiveKeyAlign,
              ),
              wrapCell(
                _buildValueWidget(context, theme, item, defaultValueStyle),
                valuePadding,
                alignment: effectiveValueAlign,
              ),
            ],
          );
        }),
      );
    }
  }

  Widget _buildStackedLayout(
    BuildContext context,
    ThemeData theme,
    List<KeyValueItem> resolvedItems,
  ) {
    final defaultKeyStyle = theme.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.onSurfaceVariant,
        ) ??
        const TextStyle(fontWeight: FontWeight.w600);
    final defaultValueStyle = theme.textTheme.bodyMedium ?? const TextStyle();

    final padding = _effectiveRowPadding;
    final effectiveDividerColor =
        dividerColor ?? theme.dividerColor.withValues(alpha: 0.3);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(resolvedItems.length, (index) {
        final item = resolvedItems[index];
        final currentRowColor = (alternateRowColor != null && index.isOdd)
            ? alternateRowColor
            : rowColor;

        final effectiveKeyAlign = item.keyAlignment ?? keyAlignment;
        final effectiveValueAlign = item.valueAlignment ?? valueAlignment;

        final isRowCopyable = item.copyable ?? copyable;
        final effectiveTap = isRowCopyable
            ? () => _handleCopy(context, item.key, item.value)
            : (item.onTap != null
                ? () => item.onTap!(context, item.key, item.value)
                : (onRowTap != null
                    ? () => onRowTap!(context, item.key, item.value)
                    : null));

        final effectiveLongPress = item.onLongPress != null
            ? () => item.onLongPress!(context, item.key, item.value)
            : (onRowLongPress != null
                ? () => onRowLongPress!(context, item.key, item.value)
                : null);

        Widget rowWidget = Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: effectiveKeyAlign,
                child: _buildKeyWidget(context, theme, item, defaultKeyStyle),
              ),
              const SizedBox(height: 3),
              Align(
                alignment: effectiveValueAlign,
                child:
                    _buildValueWidget(context, theme, item, defaultValueStyle),
              ),
            ],
          ),
        );

        if (effectiveTap != null || effectiveLongPress != null) {
          rowWidget = InkWell(
            onTap: effectiveTap,
            onLongPress: effectiveLongPress,
            child: rowWidget,
          );
        }

        if (currentRowColor != null) {
          rowWidget = ColoredBox(color: currentRowColor, child: rowWidget);
        }

        if (showDividers && index < resolvedItems.length - 1) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              rowWidget,
              Divider(
                color: effectiveDividerColor,
                thickness: dividerThickness,
                height: dividerThickness,
              ),
            ],
          );
        }

        return rowWidget;
      }),
    );
  }
}
