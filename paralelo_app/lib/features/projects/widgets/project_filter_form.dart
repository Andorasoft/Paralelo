import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/utils/validators.dart';
import './date_picker_form_field.dart';

class ProjectFilterForm extends ConsumerStatefulWidget {
  const ProjectFilterForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ProjectFilterFormState();
  }
}

class _ProjectFilterFormState extends ConsumerState<ProjectFilterForm> {
  final formKey = GlobalKey<FormState>();
  final Map<String, dynamic> filters = {
    'start_date': null,
    'end_date': null,
    'min_price': '1',
    'max_price': '5',
    'payment_type': 'hourly',
  };
  final minPriceFieldFocusNode = FocusNode();
  final maxPriceFieldFocusNode = FocusNode();

  late TextEditingController minPriceFieldController;
  late TextEditingController maxPriceFieldController;

  @override
  void initState() {
    super.initState();

    minPriceFieldController = TextEditingController(text: filters['min_price']);
    maxPriceFieldController = TextEditingController(text: filters['max_price']);
  }

  @override
  void dispose() {
    minPriceFieldController.dispose();
    maxPriceFieldController.dispose();
    minPriceFieldFocusNode.dispose();
    maxPriceFieldFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,

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
                  filters['start_date'] = null;
                  filters['end_date'] = null;
                  filters['min_price'] = '1';
                  filters['max_price'] = '5';
                  filters['payment_type'] = 'hourly';

                  safeSetState(() {
                    minPriceFieldController.text = filters['min_price'];
                    maxPriceFieldController.text = filters['max_price'];
                  });
                },
                child: Text(
                  'Reset',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ).align(AlignmentGeometry.centerLeft),
              Text(
                'Filters',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
              ).center(),
            ],
          ).size(height: 44.0),

          Text('Date range').margin(const EdgeInsets.only(top: 16.0)),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.0,

            children: [
              DatePickerFormField(
                onDateSelected: (date) {
                  filters['start_date'] = date;
                },
                firstDate: DateTime.now(),
                lastDate: DateTime.now(),
              ).expanded(),
              DatePickerFormField(
                onDateSelected: (date) {
                  filters['end_date'] = date;
                },
                validator: (date) => null,
                firstDate: DateTime.now(),
                lastDate: DateTime.now(),
              ).expanded(),
            ],
          ),

          Text('Price range').margin(const EdgeInsets.only(top: 16.0)),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.0,

            children: [
              TextFormField(
                controller: minPriceFieldController,
                focusNode: minPriceFieldFocusNode,

                validator: (value) => priceFormValidator(value),
                onChanged: (value) {},

                decoration: InputDecoration(
                  prefixIcon: Icon(LucideIcons.dollarSign),
                ),

                keyboardType: TextInputType.number,
              ).expanded(),
              TextFormField(
                controller: maxPriceFieldController,
                focusNode: maxPriceFieldFocusNode,

                validator: (value) => priceFormValidator(value),
                onChanged: (value) {},

                decoration: InputDecoration(
                  prefixIcon: Icon(LucideIcons.dollarSign),
                ),

                keyboardType: TextInputType.number,
              ).expanded(),
            ],
          ),

          Text('Payment type').margin(const EdgeInsets.only(top: 16.0)),
          DropdownButtonFormField(
            onChanged: (value) {},
            initialValue: filters['payment_type'],
            items: [
              DropdownMenuItem(value: 'hourly', child: Text('Hourly')),
              DropdownMenuItem(value: 'project', child: Text('Project')),
            ],
          ),

          FilledButton(
            onPressed: () {
              if (!formKey.currentState!.validate()) return;

              Navigator.of(context).pop(filters);
            },
            child: Text('Apply now'),
          ).margin(const EdgeInsets.only(top: 16.0)),
        ],
      ).margin(const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0)),
    ).hideKeyboardOnTap(context);
  }
}
