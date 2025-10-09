import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';

class ProjectSortForm extends ConsumerStatefulWidget {
  const ProjectSortForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ProjectSortFormState();
  }
}

class _ProjectSortFormState extends ConsumerState<ProjectSortForm> {
  final List<String> options = [
    'Last Updated',
    'First Updated',
    'A to Z',
    'Z to A',
    'Created Date',
    'Status',
    'Policy Effect',
  ];

  String? selectedOption = 'Last Updated';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 4.0,

      children: [
        Stack(
          children: [
            TextButton(
              onPressed: () {
                safeSetState(() => selectedOption = 'Last Updated');
              },
              child: Text(
                'Reset',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ).align(AlignmentGeometry.centerLeft),
            Text(
              'Sort by',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ).center(),
          ],
        ).size(height: 44.0),

        RadioGroup<String>(
          groupValue: selectedOption,
          onChanged: (value) {
            safeSetState(() => selectedOption = value);
            Navigator.of(context).pop(selectedOption);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: options
                .map(
                  (o) => RadioListTile<String>(
                    value: o,
                    contentPadding: EdgeInsets.zero,
                    title: Text(o),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    ).margin(const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0));
  }
}
