import 'package:paralelo/core/imports.dart';

class MyProposalsPage extends ConsumerStatefulWidget {
  static const routePath = '/my-proposals';

  const MyProposalsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MyProposalsPageState();
  }
}

class _MyProposalsPageState extends ConsumerState<MyProposalsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: scaffoldKey);
  }
}
