import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:paralelo/utils/formatters.dart';

class DatePickerButton extends ConsumerStatefulWidget {
  final void Function(DateTime) onDateChanged;
  final DateTime? value;

  const DatePickerButton({
    super.key,
    required this.onDateChanged,
    required this.value,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return DatePickerButtonState();
  }
}

class DatePickerButtonState extends ConsumerState<DatePickerButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: widget.value ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2050),

          initialEntryMode: DatePickerEntryMode.calendarOnly,
        );

        if (date == null) return;

        widget.onDateChanged.call(date);
      },

      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
        side: WidgetStateProperty.all(BorderSide(color: Colors.grey.shade300)),
        alignment: AlignmentGeometry.centerLeft,
      ),

      icon: const Icon(LucideIcons.calendarDays),
      label: Text(
        widget.value != null
            ? widget.value!.toShortDateString()
            : 'Select date',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
