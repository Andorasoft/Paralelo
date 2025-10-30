import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/features/project/exports.dart';
import 'package:paralelo/utils/extensions.dart';

class ProjectCard extends ConsumerWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 0.0,
      margin: EdgeInsets.zero,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1.0,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),

      child: Column(
        spacing: 4.0,
        children: [
          TextButton(
            onPressed: () async {
              await ref
                  .read(goRouterProvider)
                  .push(ProjectDetailsPage.routePath, extra: project.id);
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
              softWrap: true,
              maxLines: null,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            project.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,

            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ).margin(Insets.a16),
    );
  }
}
