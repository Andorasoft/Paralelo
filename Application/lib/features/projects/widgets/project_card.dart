import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paralelo/features/auth/controllers/auth_notifier.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/features/projects/views/project_details_page.dart';
import 'package:paralelo/features/proposal/views/create_proposal_page.dart';
import 'package:paralelo/features/reports/widgets/project_report_button.dart';
import 'package:paralelo/features/projects/models/project.dart';
import 'package:paralelo/core/providers.dart';
import 'package:paralelo/core/router.dart';

class ProjectCard extends ConsumerWidget {
  final Project project;
  final bool isPremium;
  final bool applied;

  const ProjectCard({
    super.key,
    required this.project,
    this.isPremium = false,
    this.applied = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.read(authProvider)!.id;

    return Card(
      elevation: 0.0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1.0,
          color: isPremium
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primaryContainer,
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
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Text(
                timeago
                    .format(
                      project.createdAt,
                      locale: ref.read(localeNotifierProvider).languageCode,
                    )
                    .capitalize()!,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),

              if (isPremium)
                Chip(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  color: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primary,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  label: Text(
                    'chip.secure_payment'.tr(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
            ],
          ).margin(const EdgeInsets.only(bottom: 8.0)),
          TextButton(
            onPressed: () async {
              await ref
                  .read(goRouterProvider)
                  .push(ProjectDetailsPage.routePath, extra: project);
            },
            style: Theme.of(context).textButtonTheme.style?.copyWith(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              minimumSize: WidgetStateProperty.all(Size.zero),
              padding: WidgetStateProperty.all(EdgeInsets.zero),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: AlignmentGeometry.centerLeft,
              splashFactory: NoSplash.splashFactory,
            ),
            child: Text(
              project.title,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            project.description,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),

          if (userId != project.ownerId)
            OutlinedButton(
              onPressed: !applied
                  ? () async {
                      await ref
                          .read(goRouterProvider)
                          .push(CreateProposalPage.routePath, extra: project);
                    }
                  : null,
              style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
              child: Text(
                'button.offer_help'.tr(),
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
            ).center().margin(const EdgeInsets.only(top: 32.0)),

          if (userId != project.ownerId) ...[
            const Divider().margin(const EdgeInsets.symmetric(vertical: 4.0)),

            const ReportProjectButton().center(),
          ],
        ],
      ).margin(const EdgeInsets.all(16.0)),
    );
  }
}
