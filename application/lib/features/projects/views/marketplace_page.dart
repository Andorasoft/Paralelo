import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/features/projects/controllers/project_provider.dart';
import 'package:paralelo/features/projects/models/project.dart';
import 'package:paralelo/features/projects/widgets/project_filter_form.dart';
import 'package:paralelo/features/projects/widgets/project_card.dart';
import 'package:paralelo/features/projects/widgets/search_form_field.dart';
import 'package:paralelo/features/projects/widgets/project_sort_form.dart';
import 'package:paralelo/widgets/loading_indicator.dart';

class MarketplacePage extends ConsumerStatefulWidget {
  static const routeName = 'MarketplacePage';
  static const routePath = '/marketplace';

  const MarketplacePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MarketplacePageState();
  }
}

class _MarketplacePageState extends ConsumerState<MarketplacePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late Future<List<Project>> _projectsFuture;

  @override
  void initState() {
    super.initState();

    _projectsFuture = ref.read(projectProvider).getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8.0,

          children: [
            SearchFormField(onQuery: (query) {}).expanded(),
            IconButton.filledTonal(
              onPressed: () async {
                final res =
                    await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,

                          builder: (_) {
                            return ProjectSortForm().useSafeArea();
                          },
                        )
                        as String?;

                if (res != null) debugPrint(res.toString());
              },
              icon: Icon(LucideIcons.arrowUpDown),
            ),
            IconButton.filledTonal(
              onPressed: () async {
                final res =
                    await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,

                          builder: (_) {
                            return ProjectFilterForm().useSafeArea();
                          },
                        )
                        as Map<String, dynamic>?;

                if (res != null) debugPrint(res.toString());
              },
              icon: Icon(LucideIcons.settings2),
            ),
          ],
        ),
      ),

      body: FutureBuilder(
        future: _projectsFuture,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return LoadingIndicator().center();
          }

          final projects = snapshot.data!;

          return ListView(
            children: [
              ...projects.map(
                (p) => ProjectCard(
                  project: p,
                  isPremium: (projects.indexOf(p) % 2) == 0,
                ),
              ),

              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 128.0,

                children: [
                  IconButton.filledTonal(
                    onPressed: null,
                    icon: Icon(LucideIcons.chevronLeft),
                  ),
                  IconButton.filledTonal(
                    onPressed: () {},
                    icon: Icon(LucideIcons.chevronRight),
                  ),
                ],
              ).margin(const EdgeInsets.symmetric(vertical: 28.0)),
            ],
          ).margin(const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0));
        },
      ),
    ).hideKeyboardOnTap(context);
  }
}
