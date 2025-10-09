import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:paralelo/utils/formatters.dart';

class DatePickerFormField extends ConsumerWidget {
  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final void Function(DateTime?)? onDateSelected;
  final String? Function(DateTime?)? validator;

  const DatePickerFormField({
    super.key,
    required this.firstDate,
    required this.lastDate,
    this.initialDate,
    this.onDateSelected,
    this.validator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormField<DateTime?>(
      initialValue: initialDate,
      validator: validator,
      builder: (field) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            ElevatedButton.icon(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: field.value ?? DateTime.now(),
                  firstDate: firstDate,
                  lastDate: lastDate,
                );

                if (picked != null) {
                  field.didChange(picked); // 🔑 notifica al FormField
                  onDateSelected?.call(picked);
                }
              },
              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                elevation: WidgetStateProperty.all(0.0),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              icon: const Icon(LucideIcons.calendarDays),
              label: Text(
                field.value != null
                    ? formatDateToDMY(field.value!)
                    : 'Select a date',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),

            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  field.errorText!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
