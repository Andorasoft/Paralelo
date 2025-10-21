import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';

class CommunityGrowthCard extends ConsumerWidget {
  const CommunityGrowthCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: const Color(0xFFEFF6FF),
      elevation: 0.0,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12.0,

        children: [
          Icon(
            Icons.school,
            size: 52.0,
            color: Theme.of(context).colorScheme.primary,
          ),
          Text(
            '¡Crece en la comunidad y desbloquea beneficios!',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'A medida que participas y recibes buenas valoraciones, subes de nivel y accedes a nuevas oportunidades.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ).margin(const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0)),
    );
  }
}
