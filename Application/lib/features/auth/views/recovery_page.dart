import 'package:paralelo/core/imports.dart';

class RecoveryPage extends ConsumerStatefulWidget {
  static const routePath = '/recovery';

  const RecoveryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _RecoveryPageState();
  }
}

class _RecoveryPageState extends ConsumerState<RecoveryPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: scaffoldKey);
  }
}
