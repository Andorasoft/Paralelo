int compareVersions(String a, String b) {
  final aParts = a.split('.').map(int.parse).toList();
  final bParts = b.split('.').map(int.parse).toList();

  final maxLength = [
    aParts.length,
    bParts.length,
  ].reduce((v, e) => v > e ? v : e);
  while (aParts.length < maxLength) {
    aParts.add(0);
  }
  while (bParts.length < maxLength) {
    bParts.add(0);
  }

  for (int i = 0; i < maxLength; i++) {
    if (aParts[i] < bParts[i]) return -1;
    if (aParts[i] > bParts[i]) return 1;
  }

  return 0; // Equals
}

String extractDomain(String email) {
  if (email.isEmpty || !email.contains('@')) {
    throw ArgumentError('Correo no válido');
  }
  return email.split('@').last;
}

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
String obscureText(String data) {
  final parts = data.split(' ').where((p) => p.trim().isNotEmpty).toList();
  final initials = parts.map((p) => '${p[0].toUpperCase()}.').join(' ');
  return initials;
}
