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
  Validator<String> required([String message = 'Campo obligatorio']) {
    return addRule((v) => (v == null || v.trim().isEmpty) ? message : null);
  }

  Validator<String> minLength(int min, [String? message]) {
    return addRule(
      (v) => (v != null && v.length < min)
          ? (message ?? 'Mínimo $min caracteres')
          : null,
    );
  }

  Validator<String> email([String message = 'Correo inválido']) {
    return addRule((v) {
      if (v == null || v.trim().isEmpty) return message;
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      return emailRegex.hasMatch(v) ? null : message;
    });
  }

  Validator<String> matches(
    String Function() otherValueGetter, [
    String message = 'No coincide',
  ]) {
    return addRule((v) => v != otherValueGetter() ? message : null);
  }

  Validator<String> isDouble([String message = 'Debe ser un número']) {
    return addRule((v) => double.tryParse(v ?? '') == null ? message : null);
  }
}

extension BoolRules on Validator<bool> {
  Validator<bool> mustBeTrue([String message = 'Debes aceptar los términos']) {
    return addRule((v) => (v ?? false) ? null : message);
  }
}

extension IntRules on Validator<int> {
  Validator<int> required([String message = 'Selecciona una opción']) {
    return addRule((v) => v == null ? message : null);
  }
}
