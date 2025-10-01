import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NumberFormField extends ConsumerStatefulWidget {
  final String? Function(num?)? validator;
  final NumberEditingController? controller;
  final FocusNode? focusNode;
  final Widget? icon;
  final String? hintText;
  final num? min;
  final num? max;

  const NumberFormField({
    super.key,
    this.validator,
    this.controller,
    this.focusNode,
    this.icon,
    this.hintText,
    this.min,
    this.max,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _NumerFormFieldState();
  }
}

class _NumerFormFieldState extends ConsumerState<NumberFormField> {
  late final NumberEditingController _internalController;
  NumberEditingController get effectiveController =>
      widget.controller ?? _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = NumberEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: effectiveController.textController,
      focusNode: widget.focusNode,
      validator: (value) {
        final value = effectiveController.number;
        return widget.validator?.call(value);
      },

      decoration: InputDecoration(
        prefixIcon: widget.icon,
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
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              ElevatedButton(
                onPressed: () {
                  final current = effectiveController.number ?? 0;
                  final min = widget.min;
                  effectiveController.number = (min != null && current <= min)
                      ? min
                      : current - 1;
                },
                child: Icon(LucideIcons.minus),
              ),
              ElevatedButton(
                onPressed: () {
                  final current = effectiveController.number ?? 0;
                  final max = widget.max;
                  effectiveController.number = (max != null && current >= max)
                      ? max
                      : current + 1;
                },
                child: Icon(LucideIcons.plus),
              ),
            ],
          ),
        ),

        hintText: widget.hintText,
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
