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
