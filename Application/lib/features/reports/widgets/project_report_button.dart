import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/modals.dart';
import 'package:paralelo/features/projects/exports.dart';

class ReportProjectButton extends ConsumerWidget {
  final Project project;

  const ReportProjectButton({super.key, required this.project});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton.icon(
      onPressed: () async {
        final reason = await showProjectReportModalBottomSheet(context);

        if (reason == null) return;

        showSnackbar(
          context,
          'Proyecto reportado por ${(reason).toLowerCase()}',
        );
      },

      icon: Icon(
        LucideIcons.flag,
        color: Theme.of(context).colorScheme.outline,
      ),
      label: Text(
        'button.report_post'.tr(),
        style: TextStyle(
          fontWeight: FontWeight.normal,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
    );
  }
}
