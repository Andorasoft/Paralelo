import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/proposal/exports.dart';

class ProposalInfoPresenter extends ConsumerWidget {
  final Proposal proposal;

  const ProposalInfoPresenter({super.key, required this.proposal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 0.0,
      margin: EdgeInsets.zero,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1.0,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 4.0,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Presupuesto',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text('USD 20 / hora'),
            ],
          ),

          Text(
            'Modalidad',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ).margin(const EdgeInsets.only(top: 12.0)),
          Text('Presencial'),

          Text(
            'Tiempo estimado',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ).margin(const EdgeInsets.only(top: 12.0)),
          Text('5 días'),

          Text(
            'Estado',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ).margin(const EdgeInsets.only(top: 12.0)),
          Text('Pendiente'),

          Text(
            'Mensaje inicial',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ).margin(const EdgeInsets.only(top: 12.0)),
          Text(proposal.message),
        ],
      ).margin(const EdgeInsets.all(16.0)),
    );
  }
}
