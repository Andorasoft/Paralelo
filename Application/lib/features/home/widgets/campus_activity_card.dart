import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';

class CampusActivityCard extends ConsumerWidget {
  final int conections;

  const CampusActivityCard({super.key, required this.conections});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.white,
      elevation: 0.5,

      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium!,

        child: Column(
          spacing: 4.0,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  'Actividad del campus',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'últimos 7 días',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
            Text(
              '$conections',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 30.0,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ).margin(const EdgeInsets.only(top: 12.0)),
            Text(
              'nuevas conexiones',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ],
        ),
      ).margin(const EdgeInsets.all(16.0)),
    );
  }
}
