import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/proposal/exports.dart';
import 'package:paralelo/widgets/loading_indicator.dart';
import 'package:paralelo/widgets/navigation_button.dart';

class ProposalDetailsPage extends ConsumerStatefulWidget {
  static const routePath = '/proposal-details';

  final int proposalId;

  const ProposalDetailsPage({super.key, required this.proposalId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ProposalDetailsPageState();
  }
}

class _ProposalDetailsPageState extends ConsumerState<ProposalDetailsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final Future<Proposal> loadDataFuture;

  @override
  void initState() {
    super.initState();

    loadDataFuture = loadData();
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.read(authProvider)!.id;
    return Scaffold(
      key: scaffoldKey,

      appBar: AppBar(
        automaticallyImplyLeading: false,

        leading: const NavigationButton(),
        actions: [
          FutureBuilder(
            future: loadDataFuture,
            builder: (_, snapshot) {
              final proposal = snapshot.data;

              if (proposal == null || proposal.providerId != userId) {
                return const SizedBox.shrink();
              }

              return TextButton(
                onPressed: () {},
                child: Text('button.edit'.tr()),
              );
            },
          ),
        ],
      ),

      body: FutureBuilder(
        future: loadDataFuture,
        builder: (_, snapshot) {
          final proposal = snapshot.data;

          if (proposal == null) {
            return const LoadingIndicator().center();
          }

          return ListView(children: [Text(proposal.message)]);
        },
      ),
    );
  }

  Future<Proposal> loadData() async {
    final proposal = await ref
        .read(proposalProvider)
        .getById(widget.proposalId);
    return proposal!;
  }
}
