import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';

class ProjectReportForm extends ConsumerStatefulWidget {
  const ProjectReportForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ProjectReportFormState();
  }
}

class _ProjectReportFormState extends ConsumerState<ProjectReportForm> {
  final options = [
    {
      'title': 'Contenido inapropiado',
      'description':
          'El proyecto solicita redacción de tesis, trabajos académicos fraudulentos u otro uso indebido.',
    },
    {
      'title': 'Estafa o engaño',
      'description':
          'El proyecto ofrece condiciones falsas o busca aprovecharse de los estudiantes.',
    },
    {
      'title': 'Lenguaje ofensivo',
      'description': 'Lenguaje ofensivo, discriminación o acoso.',
    },
    {
      'title': 'Lenguaje ofensivo',
      'description':
          'Incumple los términos de uso, categorías no permitidas o reglas de publicación.',
    },
    {
      'title': 'Presupuesto abusivo',
      'description':
          'El proyecto ofrece pagos irrisorios o condiciones abusivas.',
    },
  ];

  Map<String, String>? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 4.0,

      children: [
        Text(
          'Report project',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
        ).center().size(height: 44.0),

        RadioGroup(
          groupValue: selectedOption,
          onChanged: (value) {
            safeSetState(() => selectedOption = value);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: options
                .map(
                  (o) => RadioListTile<Map<String, String>>(
                    value: o,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      o['title']!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      o['description']!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),

        FilledButton(
          onPressed: () {
            Navigator.of(context).pop(selectedOption);
          },
          child: Text('Send report'),
        ),
      ],
    ).margin(const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0));
  }
}
