import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/project/exports.dart';
import 'package:paralelo/features/proposal/exports.dart';
import 'package:paralelo/features/university/exports.dart';
import 'package:paralelo/features/user/exports.dart';
import 'package:paralelo/utils/extensions.dart';
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
  late Future<(int, List<(Project, bool)>)> loadDataFuture;

  String querySearch = '';
  int currentPage = 1;

  @override
  void initState() {
    super.initState();

    loadDataFuture = loadData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadDataFuture,
      builder: (_, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return skeleton();
        }

        return page(snapshot.data!);
      },
    ).hideKeyboardOnTap(context);
  }

  Widget skeleton() {
    return Scaffold(key: scaffoldKey, body: const LoadingIndicator().center());
  }

  Widget page((int, List<(Project, bool)>) data) {
    final (total, list) = data;
    return Scaffold(
      key: scaffoldKey,

      appBar: AppBar(
        title: SearchBar(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 12.0),
          ),

          onSubmitted: (query) {
            safeSetState(() {
              querySearch = query;
              loadDataFuture = loadData(page: currentPage, query: querySearch);
            });
          },

          leading: const Icon(LucideIcons.search),
          hintText: 'input.search_projects'.tr(),
        ).size(height: 44.0),
        actions: [const ProjectSortButton()],
      ),

      body: ListView(
        padding: Insets.h16v8,
        children: [
          ...list
              .map((i) {
                final (project, applied) = i;

                return ProjectInfoPresenter(
                  onTap: () async {
                    await ref
                        .read(goRouterProvider)
                        .push(ProjectDetailsPage.routePath, extra: project.id);
                  },

                  project: project,
                  applied: applied,
                  featured: project.featured,
                  maxLines: 5,
                );
              })
              .divide(const SizedBox(height: 16.0)),

          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 128.0,

            children: [
              IconButton.filledTonal(
                onPressed: currentPage != 1
                    ? () {
                        safeSetState(() {
                          currentPage -= 1;
                          loadDataFuture = loadData(
                            page: currentPage,
                            query: querySearch,
                          );
                        });
                      }
                    : null,

                icon: const Icon(LucideIcons.chevronLeft),
              ),
              IconButton.filledTonal(
                onPressed: currentPage != total
                    ? () {
                        safeSetState(() {
                          currentPage += 1;
                          loadDataFuture = loadData(
                            page: currentPage,
                            query: querySearch,
                          );
                        });
                      }
                    : null,

                icon: const Icon(LucideIcons.chevronRight),
              ),
            ],
          ).margin(const EdgeInsets.only(top: 32.0)),
        ],
      ),
    );
  }

  Future<(int, List<(Project, bool)>)> loadData({
    String? query,
    int page = 1,
  }) async {
    final userId = ref.read(authProvider)!.id;

    final user = await ref.read(userProvider).getById(userId);
    final uni = await ref.read(universityProvider).getById(user!.universityId!);

    final (pages, projects) = await ref
        .read(projectProvider)
        .getPaginated(
          excludedUserId: userId,
          universityId: uni!.id,
          query: query,
          page: page,
        );

    final appliedList = await Future.wait(
      projects.map(
        (p) => ref
            .read(proposalProvider)
            .applied(projectId: p.id, providerId: userId),
      ),
    );

    return (
      pages,
      [for (var i = 0; i < projects.length; i++) (projects[i], appliedList[i])],
    );
  }
}
