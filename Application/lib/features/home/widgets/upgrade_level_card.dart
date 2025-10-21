import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';

class UpgradeLevelCard extends ConsumerWidget {
  const UpgradeLevelCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Theme.of(context).colorScheme.tertiary,
      elevation: 0.0,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8.0,

        children: [
          Text(
            '¡Los Mentores y Leyendas son los más buscados por las empresas!',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'Obtén visibilidad y accede a proyectos exclusivos en tu campo.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          FilledButton.tonal(
            onPressed: () {},
            child: Text('¡Quiero ser Leyenda!'),
          ),
        ],
      ).margin(const EdgeInsets.all(16.0)),
    );
  }
}
