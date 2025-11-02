typedef ValidationRule<T> = String? Function(T? value);

class Validator<T> {
  final List<ValidationRule<T>> _rules = [];

  Validator<T> addRule(ValidationRule<T> rule) {
    _rules.add(rule);
    return this;
  }

  String? validate(T? value) {
    for (final rule in _rules) {
      final result = rule(value);
      if (result != null && result.isNotEmpty) return result;
    }
    return null;
  }
}

extension StringRules on Validator<String> {
  Validator<String> required([String message = 'Campo obligatorio']) =>
      addRule((v) => (v == null || v.trim().isEmpty) ? message : null);

  Validator<String> minLength(int min, [String? message]) {
    return addRule(
      (v) => (v != null && v.length < min)
          ? (message ?? 'Mínimo $min caracteres')
          : null,
    );
  }

  Validator<String> isDouble([String message = 'Debe ser un número']) {
    return addRule((v) => double.tryParse(v ?? '') == null ? message : null);
  }
}

extension IntRules on Validator<int> {
  Validator<int> required([String message = 'Selecciona una opción']) {
    return addRule((v) => v == null ? message : null);
  }
}
