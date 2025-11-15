import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/constants.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/project/exports.dart';
import 'package:paralelo/features/proposal/exports.dart';
import 'package:paralelo/features/report/exports.dart';
import 'package:paralelo/features/skill/exports.dart';

class ProjectInfoPresenter extends ConsumerWidget {
  final void Function()? onTap;
  final bool? isCompact;
  final bool? applied;
  final bool? reported;
  final bool? showStatus;
  final bool? featured;
  final int? maxLines;

  final Project project;
  final ProjectPayment? payment;
  final List<Skill>? skills;

  const ProjectInfoPresenter({
    super.key,
    required this.project,
    this.onTap,
    this.payment,
    this.skills,
    this.isCompact,
    this.applied,
    this.reported,
    this.showStatus,
    this.featured,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.read(authProvider)!.id;

    return Card(
      elevation: 0.0,
      margin: EdgeInsets.zero,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: (featured ?? false) ? 2.0 : 1.0,
          color: (featured ?? false)
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primaryContainer,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (featured ?? false)
            Chip(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,

              backgroundColor: Theme.of(context).colorScheme.primary,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
              ),

              label: Text(
                'DESTACADO',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 4.0,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textDirection: payment.isNull
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                spacing: 16.0,
                children: [
                  if (payment == null)
                    TextButton(
                      onPressed: () => onTap?.call(),

                      style: Theme.of(context).textButtonTheme.style?.copyWith(
                        overlayColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                        minimumSize: WidgetStateProperty.all(Size.zero),
                        padding: WidgetStateProperty.all(EdgeInsets.zero),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: AlignmentGeometry.centerLeft,
                        splashFactory: NoSplash.splashFactory,
                      ),

                      child: Text(
                        project.title,
                        softWrap: true,
                        maxLines: null,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ).expanded()
                  else
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: payment!.currency),
                          TextSpan(text: ' ${payment!.min} - ${payment!.max}'),
                          if (payment!.type == ProjectPaymentType.hourly) ...[
                            TextSpan(text: ' / '),
                            TextSpan(
                              text: ProjectPaymentType.labels[payment!.type]!
                                  .tr(),
                            ),
                          ],
                        ],

                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      textAlign: TextAlign.end,
                    ),

                  if (showStatus ?? false)
                    Chip(
                      color: WidgetStateProperty.all(Colors.transparent),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      side: BorderSide(
                        width: 1.0,
                        color: fromProjectStatus(project.status),
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,

                      label: Text(
                        ProjectStatus.labels[project.status]!.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: fromProjectStatus(project.status),
                        ),
                      ),
                    ),
                ],
              ).margin(const EdgeInsets.only(bottom: 8.0)),

              Text(
                project.description,

                maxLines: maxLines,
                overflow: maxLines != null
                    ? TextOverflow.ellipsis
                    : TextOverflow.visible,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),

              if (payment != null && project.requirement != null) ...[
                Text(
                  'requirement'.tr(),
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
                ).margin(const EdgeInsets.only(top: 12.0)),
                Text(project.requirement!),
              ],

              if (skills != null) ...[
                Text(
                  'required_skills'.tr(),
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
                ).margin(const EdgeInsets.only(top: 12.0)),
                Wrap(
                  spacing: 8.0,

                  children: skills!
                      .map((s) => Chip(label: Text(s.name)))
                      .toList(),
                ),
              ],

              if (project.ownerId != userId) ...[
                if (payment == null)
                  CreateProposalButton(
                    project: project,
                    disabled: applied,
                  ).center().margin(const EdgeInsets.only(top: 28.0)),

                const Divider().margin(
                  const EdgeInsets.symmetric(vertical: 4.0),
                ),

                ReportProjectButton(project: project).center(),
              ],
            ],
          ).margin(const EdgeInsets.all(16.0)),
        ],
      ),
    );
  }

  Color fromProjectStatus(String status) {
    switch (status) {
      case ProjectStatus.open:
        return Colors.blue;
      case ProjectStatus.inProgress:
        return Colors.orange;
      case ProjectStatus.completed:
        return Colors.lightGreen;
      case ProjectStatus.canceled:
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }
}
