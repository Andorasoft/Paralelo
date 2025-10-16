import 'package:intl/intl.dart';

/// Provides additional formatting utilities for [DateTime].
extension DateTimeExtensions on DateTime {
  /// Returns a string representation of the date in `dd-MM-yyyy` format.
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime(2025, 9, 27);
  /// print(date.toShortDateString()); // 27-09-2025
  /// ```
  String toShortDateString() {
    return '${'$day'.padLeft(2, '0')}-'
        '${'$month'.padLeft(2, '0')}-'
        '$year';
  }

  /// Returns a string representation of the time in 24-hour format (`HH:mm`).
  ///
  /// Example:
  /// ```dart
  /// final dateTime = DateTime(2025, 9, 27, 14, 45);
  /// print(dateTime.toShortTimeString()); // 14:45
  /// ```
  String toShortTimeString() {
    return DateFormat('HH:mm').format(this);
  }
}

/// Provides additional text utilities for [String].
extension StringExtensions on String {
  /// Returns an obscured version of a full name, showing only the initials.
  ///
  /// Example:
  /// ```dart
  /// final name = "Jordy Ricardo Carrión Chávez";
  /// print(name.obscure()); // J. R. C. C.
  /// ```
  ///
  /// This method:
  /// - Splits the string by spaces.
  /// - Removes any extra whitespace.
  /// - Converts the first character of each part to uppercase.
  /// - Joins the initials with spaces and adds a period after each one.
  String obscure() {
    final parts = split(' ').where((p) => p.trim().isNotEmpty).toList();
    final initials = parts.map((p) => '${p[0].toUpperCase()}.').join(' ');
    return initials;
  }

  String extractDomain() {
    if (isEmpty || !contains('@')) {
      throw ArgumentError('Correo no válido');
    }
    return split('@').last;
  }
}
