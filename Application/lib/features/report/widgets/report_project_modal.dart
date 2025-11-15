import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/report/exports.dart';
import 'package:paralelo/widgets/modal_bottom_sheet.dart';

class ReportProjectModal extends ConsumerWidget {
  final String projectId;
  final String ownerId;

  const ReportProjectModal({
    super.key,
    required this.projectId,
    required this.ownerId,
  });

  final _options = const [
    'inappropriate',
    'scam',
    'offensive',
    'terms_violation',
    'abusive_budget',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? selected;

    return ModalBottomSheet(
      title: PreferredSize(
        preferredSize: Size.fromHeight(44.0),
        child: Text('modal.report.title'.tr()).center(),
      ),

      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(44.0),
        child: FilledButton(
          onPressed: () async {
            try {
              if (selected == null) return;

              final userId = ref.read(authProvider)!.id;

              await ref
                  .read(reportProvider)
                  .create(
                    reason: selected!,
                    reporterId: userId,
                    reportedId: ownerId,
                    projectId: projectId,
                  );

              Navigator.of(context).pop(selected);
            } catch (e) {
              showSnackbar(context, '');
            }
          },
          child: Text('button.send_report'.tr()),
        ),
      ),

      child: StatefulBuilder(
        builder: (_, setState) {
          return RadioGroup(
            groupValue: selected,
            onChanged: (value) {
              if (!context.mounted) return;

              setState(() => selected = value);
            },

            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: _options
                  .map(
                    (key) => RadioListTile<String>(
                      value: key,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'modal.report.options.$key.title'.tr(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        'modal.report.options.$key.description'.tr(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
