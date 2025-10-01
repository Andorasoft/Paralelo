import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/features/projects/widgets/project_report_form.dart';

class ProjectReportButton extends ConsumerWidget {
  const ProjectReportButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton.icon(
      onPressed: () async {
        final _ = await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) {
            return ProjectReportForm().useSafeArea();
          },
        );
      },

      icon: Icon(
        LucideIcons.flag,
        color: Theme.of(context).colorScheme.outline,
      ),
      label: Text(
        'Reportar esta publicación',
        style: TextStyle(
          fontWeight: FontWeight.normal,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
    );
  }
}
