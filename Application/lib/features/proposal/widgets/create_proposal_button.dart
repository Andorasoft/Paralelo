import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/features/project/exports.dart';
import 'package:paralelo/features/proposal/exports.dart';

class CreateProposalButton extends ConsumerWidget {
  final Project project;
  final bool? disabled;

  const CreateProposalButton({super.key, required this.project, this.disabled});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
      onPressed: (disabled ?? false)
          ? null
          : () async {
              await ref
                  .read(goRouterProvider)
                  .push(CreateProposalPage.routePath, extra: project.id);
            },

      style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
        ),
      ),

      child: Text(
        'button.offer_help'.tr(),
        style: const TextStyle(fontWeight: FontWeight.normal),
      ),
    );
  }
}
