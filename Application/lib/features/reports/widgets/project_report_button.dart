import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/modals.dart';

class ReportProjectButton extends ConsumerStatefulWidget {
  const ReportProjectButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ReportProjectButtonState();
  }
}

class ReportProjectButtonState extends ConsumerState<ReportProjectButton> {
  @override
  Widget build(BuildContext context) {
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
