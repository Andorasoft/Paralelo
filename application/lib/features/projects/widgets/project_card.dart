import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/features/projects/views/project_details_page.dart';
import 'package:paralelo/features/proposal/views/create_proposal_page.dart';
import 'package:paralelo/features/projects/widgets/project_report_button.dart';
import 'package:paralelo/features/projects/models/project.dart';
import 'package:paralelo/core/router.dart';

class ProjectCard extends ConsumerWidget {
  final Project project;
  final bool isPremium;

  const ProjectCard({super.key, required this.project, this.isPremium = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        borderRadius: BorderRadiusGeometry.circular(8.0),
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
                timeago.format(project.createdAt, locale: 'es').capitalize()!,
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
                    borderRadius: BorderRadiusGeometry.circular(100.0),
                  ),
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  label: Text(
                    'Secure payment',
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
              minimumSize: WidgetStateProperty.all(Size(0.0, 0.0)),
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

          OutlinedButton(
            onPressed: () async {
              await ref
                  .read(goRouterProvider)
                  .push(CreateProposalPage.routePath, extra: project);
            },
            style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(100.0),
                ),
              ),
            ),
            child: Text(
              'Ofrecer ayuda',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ).center().margin(const EdgeInsets.only(top: 32.0)),

          Divider().margin(EdgeInsets.symmetric(vertical: 4.0)),

          ProjectReportButton().center(),
        ],
      ).margin(const EdgeInsets.all(16.0)),
    );
  }
}
