import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/project/exports.dart';
import 'package:paralelo/features/report/exports.dart';

class ReportProjectButton extends ConsumerWidget {
  final Project project;
  final bool? enabled;

  const ReportProjectButton({super.key, required this.project, this.enabled});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton.icon(
      onPressed: (enabled ?? true)
          ? () async {
              final reason = await showModalBottomSheet<String?>(
                context: context,
                isScrollControlled: true,
                builder: (_) => ReportProjectModal(
                  projectId: project.id,
                  ownerId: project.ownerId,
                ),
              );

              if (reason == null) return;

              showSnackbar(
                context,
                'Proyecto reportado por ${(reason).toLowerCase()}',
              );
            }
          : null,

      style: Theme.of(context).textButtonTheme.style?.copyWith(
        iconColor: WidgetStateProperty.resolveWith<Color>((states) {
          return !states.contains(WidgetState.disabled)
              ? Theme.of(context).colorScheme.outline
              : Theme.of(context).colorScheme.outlineVariant;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          return !states.contains(WidgetState.disabled)
              ? Theme.of(context).colorScheme.outline
              : Theme.of(context).colorScheme.outlineVariant;
        }),
      ),

      icon: const Icon(LucideIcons.flag),
      label: Text('button.report_post'.tr()),
    );
  }
}
