import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/user/exports.dart';
import 'package:paralelo/widgets/loading_indicator.dart';
import 'package:paralelo/widgets/person_picture.dart';

class HomePage extends ConsumerStatefulWidget {
  static const routePath = '/home';

  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends ConsumerState<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final Future<User> loadDataFuture;

  @override
  void initState() {
    super.initState();

    loadDataFuture = loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64.0),

        child: FutureBuilder(
          future: loadDataFuture,

          builder: (_, snapshot) {
            final user = snapshot.data;

            if (user == null) {
              return const LoadingIndicator(showMessage: false).center();
            }

            return AppBar(
              toolbarHeight: 64.0,

              leading: PersonPicture(
                source: user.pictureUrl ?? '',
                size: 40.0,
              ).center(),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    '${'hello'.tr()},',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '${firstName(user.displayName)} ${lastName(user.displayName)}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<User> loadData() async {
    final userId = ref.read(authProvider)!.id;
    final user = await ref.read(userProvider).getById(userId);

    return user!;
  }

  String firstName(String fullName) {
    return fullName.split(' ')[0];
  }

  String lastName(String fullName) {
    return fullName.split(' ')[2];
  }
}
