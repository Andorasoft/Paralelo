String? priceFormValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a value';
  }

  if (double.tryParse(value) == null) {
    return 'Please enter a valid number';
  }
  return null;
}
