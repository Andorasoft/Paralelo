import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:paralelo/core/modals.dart';

class ProjectSortButton extends ConsumerStatefulWidget {
  const ProjectSortButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ProjectSortButtonState();
  }
}

class ProjectSortButtonState extends ConsumerState<ProjectSortButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: () async {
        final sort = await showProjectSortModalBottomSheet(
          context,
          value: 'last_updated',
        );

        debugPrint('Sort projects by $sort...');
      },
      icon: const Icon(LucideIcons.arrowUpDown),
    );
  }
}
