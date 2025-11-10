import 'package:intl/intl.dart';

/// Returns a string representation of the date in `dd-MM-yyyy` format.
///
/// Example:
/// ```dart
/// final date = DateTime(2025, 9, 27);
/// print(date.toShortDateString()); // 27-09-2025
/// ```
String formatToShortDateString(DateTime date) {
  return '${'${date.day}'.padLeft(2, '0')}-'
      '${'${date.month}'.padLeft(2, '0')}-'
      '${date.year}';
}

/// Returns a string representation of the time in 24-hour format (`HH:mm`).
///
/// Example:
/// ```dart
/// final dateTime = DateTime(2025, 9, 27, 14, 45);
/// print(dateTime.toShortTimeString()); // 14:45
/// ```
String formatToShortTimeString(DateTime date) {
  return DateFormat('HH:mm').format(date);
}
