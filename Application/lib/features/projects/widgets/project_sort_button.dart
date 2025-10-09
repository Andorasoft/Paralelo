import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';

class ProjectSortButton extends ConsumerStatefulWidget {
  const ProjectSortButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ProjectSortButtonState();
  }
}

class ProjectSortButtonState extends ConsumerState<ProjectSortButton> {
  final List<String> _options = [
    'Last Updated',
    'First Updated',
    'A to Z',
    'Z to A',
    'Created Date',
    'Status',
    'Policy Effect',
  ];

  String? _selectedOption = 'Last Updated';

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: () async {
        final sort = await showModalBottomSheet<String?>(
          context: context,
          isScrollControlled: true,

          builder: (_) {
            return StatefulBuilder(
              builder: (_, setState) {
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
                            setState(() => _selectedOption = 'Last Updated');
                          },
                          child: Text(
                            'Reset',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ).align(AlignmentGeometry.centerLeft),
                        Text(
                          'Sort by',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ).center(),
                      ],
                    ).size(height: 44.0),

                    RadioGroup<String>(
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() => _selectedOption = value);
                        Navigator.of(context).pop(_selectedOption);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: _options
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
                ).margin(const EdgeInsets.all(16.0));
              },
            ).useSafeArea();
          },
        );

        debugPrint('Sort projects by $sort...');
      },
      icon: const Icon(LucideIcons.arrowUpDown),
    );
  }
}
