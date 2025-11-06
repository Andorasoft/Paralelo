import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/features/proposal/exports.dart';

class ShowProposalButton extends ConsumerWidget {
  final String proposalId;
  final bool disabled;

  const ShowProposalButton({
    super.key,
    required this.proposalId,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: disabled
          ? null
          : () async {
              await ref
                  .read(goRouterProvider)
                  .push(ProposalDetailsPage.routePath, extra: proposalId);
            },

      style: Theme.of(context).textButtonTheme.style?.copyWith(
        backgroundColor: WidgetStateProperty.all(
          Theme.of(context).colorScheme.surfaceContainer,
        ),
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        minimumSize: WidgetStateProperty.all(const Size.fromHeight(0.0)),
      ),

      child: Text('button.show_proposal'.tr()),
    );
  }
}
