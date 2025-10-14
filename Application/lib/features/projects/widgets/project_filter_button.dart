import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:paralelo/core/modals.dart';

class ProjectFilterButton extends ConsumerStatefulWidget {
  const ProjectFilterButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ProjectFilterButtonState();
  }
}

class ProjectFilterButtonState extends ConsumerState<ProjectFilterButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: () async {
        final filters = await showProjectFilterModalBottomSheet(context);

        if (filters == null) return;

        debugPrint(filters.toString());
      },
      icon: const Icon(LucideIcons.settings2),
    );
  }
}
