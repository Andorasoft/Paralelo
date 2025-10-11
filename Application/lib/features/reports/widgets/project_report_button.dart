import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';

class ReportProjectButton extends ConsumerStatefulWidget {
  const ReportProjectButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ReportProjectButtonState();
  }
}

class ReportProjectButtonState extends ConsumerState<ReportProjectButton> {
  final _options = [
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
      'title': 'Incumplimiento de términos',
      'description':
          'Incumple los términos de uso, categorías no permitidas o reglas de publicación.',
    },
    {
      'title': 'Presupuesto abusivo',
      'description':
          'El proyecto ofrece pagos irrisorios o condiciones abusivas.',
    },
  ];

  Map<String, String>? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () async {
        final reason = await showModalBottomSheet<Map<String, String>?>(
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
                    Text(
                      'Report project',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ).center().size(height: 44.0),

                    RadioGroup(
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        if (!mounted) return;
                        setState(() => _selectedOption = value);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,

                        children: _options
                            .map(
                              (o) => RadioListTile<Map<String, String>>(
                                value: o,
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  o['title']!,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  o['description']!,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.outline,
                                      ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),

                    FilledButton(
                      onPressed: () {
                        Navigator.of(context).pop(_selectedOption);
                      },
                      child: const Text('Enviar reporte'),
                    ),
                  ],
                ).margin(const EdgeInsets.all(16.0)).useSafeArea();
              },
            );
          },
        );

        debugPrint('Report reason selected $reason...');

        if (reason != null) {
          showSnackbar(
            context,
            'Proyecto reportado por ${(reason['title'] as String).toLowerCase()}',
          );
        }
      },

      icon: Icon(
        LucideIcons.flag,
        color: Theme.of(context).colorScheme.outline,
      ),
      label: Text(
        'Reportar esta publicación',
        style: TextStyle(
          fontWeight: FontWeight.normal,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
    );
  }
}
