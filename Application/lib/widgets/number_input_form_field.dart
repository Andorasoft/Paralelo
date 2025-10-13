import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NumberInputFormField extends ConsumerWidget {
  final String? Function(num?)? validator;
  final NumberEditingController controller;
  final FocusNode? focusNode;
  final Widget? icon;
  final String? hintText;
  final num? min;
  final num? max;

  const NumberInputFormField({
    super.key,
    this.validator,
    required this.controller,
    this.focusNode,
    this.icon,
    this.hintText,
    this.min,
    this.max,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: controller.textController,
      focusNode: focusNode,
      validator: (value) {
        final value = controller.number;
        return validator?.call(value);
      },

      decoration: InputDecoration(
        prefixIcon: icon,
        suffixIcon: Theme(
          data: Theme.of(context).copyWith(
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: Theme.of(context).filledButtonTheme.style?.copyWith(
                backgroundColor: WidgetStateProperty.all(Colors.white),
                minimumSize: WidgetStateProperty.all(Size(32.0, 32.0)),
                padding: WidgetStateProperty.all(EdgeInsets.zero),
                elevation: WidgetStateProperty.all(0.0),
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              ElevatedButton(
                onPressed: () {
                  final current = controller.number ?? 0;

                  controller.number =
                      (min != null && current <= (min ?? double.minPositive))
                      ? min
                      : current - 1;
                },
                child: const Icon(LucideIcons.minus),
              ),
              ElevatedButton(
                onPressed: () {
                  final current = controller.number ?? 0;

                  controller.number =
                      (max != null && current >= (max ?? double.maxFinite))
                      ? max
                      : current + 1;
                },
                child: const Icon(LucideIcons.plus),
              ),
            ],
          ),
        ),

        hintText: hintText,
      ),

      keyboardType: TextInputType.number,
    );
  }
}

/// A specialized controller for numeric form fields.
///
/// Internally uses a [TextEditingController], but exposes a [num?] value
/// instead of a [String].
class NumberEditingController extends ValueNotifier<num?> {
  /// Internal text controller.
  final TextEditingController textController;

  NumberEditingController({num? value})
    : textController = TextEditingController(text: value?.toString() ?? ''),
      super(value) {
    // Listen for text changes and keep the numeric value in sync.
    textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final text = textController.text.trim();
    if (text.isEmpty) {
      value = null;
    } else {
      final parsed = num.tryParse(text);
      if (parsed != null) {
        value = parsed;
      }
    }
  }

  /// Update the numeric value manually.
  set number(num? newValue) {
    value = newValue;
    textController.text = newValue?.toString() ?? '';
  }

  /// Get the current numeric value.
  num? get number => value;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
