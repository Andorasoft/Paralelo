/// Formats a [DateTime] into a string with the pattern `dd-MM-yyyy`.
///
/// Example:
/// ```dart
/// final date = DateTime(2025, 9, 27);
/// print(formatDateToDMY(date)); // 27-09-2025
/// ```
String formatDateToDMY(DateTime date) {
  return "${date.day.toString().padLeft(2, '0')}-"
      "${date.month.toString().padLeft(2, '0')}-"
      "${date.year}";
}
