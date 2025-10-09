import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/utils/formatters.dart';
import 'package:paralelo/utils/validators.dart';

class ProjectFilterButton extends ConsumerStatefulWidget {
  const ProjectFilterButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ProjectFilterButtonState();
  }
}

class ProjectFilterButtonState extends ConsumerState<ProjectFilterButton> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _filters = {
    'start_date': null,
    'end_date': null,
    'min_price': '1',
    'max_price': '5',
    'payment_type': 'hourly',
  };

  final _minPriceFieldController = TextEditingController(text: '1');
  final _minPriceFieldFocusNode = FocusNode();

  final _maxPriceFieldController = TextEditingController(text: '5');
  final _maxPriceFieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: () async {
        final res = await showModalBottomSheet<Map<String, dynamic>?>(
          context: context,
          isScrollControlled: true,

          builder: (_) {
            return StatefulBuilder(
              builder: (_, setState) {
                return Form(
                  key: _formKey,

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 4.0,

                    children: [
                      Stack(
                        children: [
                          TextButton(
                            onPressed: () {
                              _filters['start_date'] = null;
                              _filters['end_date'] = null;
                              _filters['min_price'] = '1';
                              _filters['max_price'] = '5';
                              _filters['payment_type'] = 'hourly';

                              setState(() {
                                _minPriceFieldController.text =
                                    _filters['min_price'];
                                _maxPriceFieldController.text =
                                    _filters['max_price'];
                              });
                            },
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ).align(AlignmentGeometry.centerLeft),
                          Text(
                            'Filters',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ).center(),
                        ],
                      ).size(height: 44.0),

                      Text(
                        'Date range',
                      ).margin(const EdgeInsets.only(top: 16.0)),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8.0,

                        children: [
                          _buildDatePickerButton(
                            setState,
                            'start_date',
                          ).expanded(),
                          _buildDatePickerButton(
                            setState,
                            'end_date',
                          ).expanded(),
                        ],
                      ),

                      Text(
                        'Price range',
                      ).margin(const EdgeInsets.only(top: 16.0)),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8.0,

                        children: [
                          TextFormField(
                            controller: _minPriceFieldController,
                            focusNode: _minPriceFieldFocusNode,

                            validator: (value) => priceFormValidator(value),
                            onChanged: (value) {},

                            decoration: InputDecoration(
                              prefixIcon: Icon(LucideIcons.dollarSign),
                            ),

                            keyboardType: TextInputType.number,
                          ).expanded(),
                          TextFormField(
                            controller: _maxPriceFieldController,
                            focusNode: _maxPriceFieldFocusNode,

                            validator: (value) => priceFormValidator(value),
                            onChanged: (value) {},

                            decoration: InputDecoration(
                              prefixIcon: Icon(LucideIcons.dollarSign),
                            ),

                            keyboardType: TextInputType.number,
                          ).expanded(),
                        ],
                      ),

                      Text(
                        'Payment type',
                      ).margin(const EdgeInsets.only(top: 16.0)),
                      DropdownButtonFormField(
                        onChanged: (value) {},
                        initialValue: _filters['payment_type'],
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(),
                        items: [
                          DropdownMenuItem(
                            value: 'hourly',
                            child: Text('Hourly'),
                          ),
                          DropdownMenuItem(
                            value: 'project',
                            child: Text('Project'),
                          ),
                        ],
                      ),

                      FilledButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }

                          Navigator.of(context).pop(_filters);
                        },
                        child: Text('Apply now'),
                      ).margin(const EdgeInsets.only(top: 16.0)),
                    ],
                  ).margin(const EdgeInsets.all(16.0)),
                ).hideKeyboardOnTap(context);
              },
            );
          },
        );

        if (res != null) debugPrint(res.toString());
      },
      icon: const Icon(LucideIcons.settings2),
    );
  }

  Widget _buildDatePickerButton(StateSetter setState, String key) {
    return OutlinedButton.icon(
      onPressed: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now(),

          initialEntryMode: DatePickerEntryMode.calendarOnly,
        );

        debugPrint('Selected date $date...');

        if (date != null) {
          setState(() => _filters[key] = date);
        }
      },

      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
        side: WidgetStateProperty.all(BorderSide(color: Colors.grey.shade300)),
        alignment: AlignmentGeometry.centerLeft,
      ),

      icon: const Icon(LucideIcons.calendarDays),
      label: Text(
        _filters[key] != null
            ? (_filters[key] as DateTime).toShortDateString()
            : 'Select a date',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
