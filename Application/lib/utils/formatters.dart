///
extension DateTimeExtensions on DateTime {
  /// Formats a [DateTime] into a string with the pattern `dd-MM-yyyy`.
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime(2025, 9, 27);
  /// print(formatDateToDMY(date)); // 27-09-2025
  /// ```
  String toShortDateString() {
    return '${'$day'.padLeft(2, '0')}-'
        '${'$month'.padLeft(2, '0')}-'
        '$year';
  }
}
