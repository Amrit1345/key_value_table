/// Layout modes for [KeyValueTable].
enum KeyValueLayout {
  /// Traditional horizontal layout where key and value sit side-by-side.
  horizontal,

  /// Stacked layout where the key label sits on top and the value sits below.
  /// Ideal for narrow screens or multiline descriptions.
  stacked,

  /// Automatically switches from [horizontal] to [stacked] when the container
  /// width is less than the specified responsive breakpoint.
  auto,
}

/// Spacing density presets for [KeyValueTable].
enum KeyValueDensity {
  /// Compact spacing (2px vertical padding) for data-dense telemetry and dashboards.
  compact,

  /// Standard spacing (6px vertical padding) for everyday forms and cards.
  regular,

  /// Comfortable, spacious padding (12px vertical padding) for mobile settings and profile screens.
  comfortable,
}
