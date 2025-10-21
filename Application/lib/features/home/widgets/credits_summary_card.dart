import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';

class CreditsSummaryCard extends ConsumerWidget {
  final double credits;
  final int collaborations;

  const CreditsSummaryCard({
    super.key,
    required this.credits,
    required this.collaborations,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.white,
      elevation: 0.5,

      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.outline,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Créditos'), Text('Colaboraciones')],
            ),
          ).margin(const EdgeInsets.only(bottom: 4.0)),
          DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${credits.toStringAsFixed(2)}'),
                Text('$collaborations'),
              ],
            ),
          ).margin(const EdgeInsets.only(bottom: 16.0)),
          FilledButton(onPressed: () {}, child: Text('Ver mis créditos')),
        ],
      ).margin(const EdgeInsets.all(16.0)),
    );
  }
}
