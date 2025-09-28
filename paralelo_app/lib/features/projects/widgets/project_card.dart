import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/features/projects/views/project_details_page.dart';
import 'package:paralelo/features/projects/widgets/project_report_form.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/features/projects/models/project.dart';

class ProjectCard extends ConsumerStatefulWidget {
  final Project project;
  final bool isPremium;

  const ProjectCard({super.key, required this.project, this.isPremium = false});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ProjectCardState();
  }
}

class _ProjectCardState extends ConsumerState<ProjectCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1.0,
          color: widget.isPremium
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
                timeago
                    .format(widget.project.createdAt, locale: 'es')
                    .capitalize()!,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),

              if (widget.isPremium)
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
                  .push(ProjectDetailsPage.routePath, extra: widget.project.id);
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
              widget.project.title,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            widget.project.description,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),

          OutlinedButton(
            onPressed: () {},
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

          TextButton.icon(
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
          ).center(),
        ],
      ).margin(const EdgeInsets.all(16.0)),
    );
  }
}
