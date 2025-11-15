import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/constants.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/project/exports.dart';
import 'package:paralelo/widgets/empty_indicator.dart';
import 'package:paralelo/widgets/loading_indicator.dart';
import 'package:paralelo/widgets/navigation_button.dart';

class MyProjectsPage extends ConsumerStatefulWidget {
  static const routePath = '/my-projects';

  const MyProjectsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MyProjectsPageState();
  }
}

class _MyProjectsPageState extends ConsumerState<MyProjectsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final Future<List<Project>> loadDataFuture;

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
        if (!snapshot.hasData) {
          return skeleton();
        }

        return page(snapshot.data!);
      },
    ).hideKeyboardOnTap(context);
  }

  Widget skeleton() {
    return Scaffold(key: scaffoldKey, body: const LoadingIndicator().center());
  }

  Widget page(List<Project> data) {
    return Scaffold(
      key: scaffoldKey,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const NavigationButton(),
        title: Text('setting.options.published_projects'.tr()),
      ),

      body: data.isEmpty
          ? const EmptyIndicator().center()
          : ListView(
              padding: Insets.h16v8,
              children: data
                  .map(
                    (i) => ProjectInfoPresenter(
                      project: i,
                      maxLines: 5,
                      showStatus: true,
                      featured: i.featured,

                      onTap: () async {
                        await ref
                            .read(goRouterProvider)
                            .push(ProjectDetailsPage.routePath, extra: i.id);
                      },
                    ),
                  )
                  .divide(const SizedBox(height: 8.0)),
            ),
    );
  }

  Future<List<Project>> loadData() {
    final userId = ref.read(authProvider)!.id;
    return ref.read(projectProvider).getForUser(userId);
  }
}
