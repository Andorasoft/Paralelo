import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/constants.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/core/services.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/chats/exports.dart';
import 'package:paralelo/features/projects/exports.dart';
import 'package:paralelo/features/proposal/exports.dart';
import 'package:paralelo/utils/extensions.dart';
import 'package:paralelo/widgets/navigation_button.dart';
import 'package:paralelo/widgets/skeleton.dart';
import 'package:paralelo/widgets/skeleton_block.dart';
import 'package:paralelo/widgets/skeleton_card.dart';

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
  late final Future<(Proposal, ChatRoom)> loadDataFuture;

  bool isBussy = false;

  @override
  void initState() {
    super.initState();

    loadDataFuture = loadData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !isBussy,
      child: FutureBuilder(
        future: loadDataFuture,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return skeleton();
          }

          return page(snapshot.data!);
        },
      ),
    ).hideKeyboardOnTap(context);
  }

  Widget skeleton() {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Skeleton(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.transparent,

          appBar: AppBar(
            leading: const SkeletonBlock(
              radius: 100.0,
              width: 40.0,
              height: 40.0,
            ).align(Alignment.centerRight),
            actions: [const SkeletonBlock(width: 32.0, height: 16.0)],
          ),

          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16.0,
            children: [
              const SkeletonBlock(width: double.infinity, height: 16.0),
              SkeletonCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16.0,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SkeletonBlock(width: 100.0, height: 16.0),
                        SkeletonBlock(width: 50.0, height: 16.0),
                      ],
                    ),
                    for (int i = 0; i < 4; i++) ...const [
                      SkeletonBlock(width: 50.0, height: 16.0),
                      SkeletonBlock(width: double.infinity, height: 16.0),
                    ],
                  ],
                ).margin(Insets.h16),
              ),
            ],
          ).margin(Insets.h16v8),

          bottomNavigationBar: SkeletonBlock(
            radius: 12.0,
            width: double.infinity,
            height: 44.0,
          ).margin(Insets.h16v8).useSafeArea(),
        ),
      ),
    );
  }

  Widget page((Proposal, ChatRoom) data) {
    final userId = ref.read(authProvider)!.id;
    final (proposal, room) = data;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const NavigationButton(),
        actions: [
          if (proposal.providerId == userId)
            TextButton(
              onPressed: proposal.status != ProposalStatus.accepted
                  ? () {}
                  : null,
              child: Text('button.edit'.tr()),
            ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16.0,
        children: [
          Text(
            'Detalles de la propuesta',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.0,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 4.0,

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Presupuesto',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (proposal.amount.isNotNull)
                      Text('USD ${proposal.amount}')
                    else
                      Text('USD ${proposal.hourlyRate} / hora'),
                  ],
                ),

                Text(
                  'Modalidad',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ).margin(const EdgeInsets.only(top: 12.0)),
                Text(ProposalMode.labels[proposal.mode]!),

                Text(
                  'Tiempo estimado',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ).margin(const EdgeInsets.only(top: 12.0)),
                Text(
                  '${proposal.estimatedDurationValue} ${proposal.estimatedDurationUnit}',
                ),

                Text(
                  'Estado',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ).margin(const EdgeInsets.only(top: 12.0)),
                Text(ProposalStatus.labels[proposal.status]!),

                Text(
                  'Mensaje inicial',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ).margin(const EdgeInsets.only(top: 12.0)),
                Text(proposal.message),
                FilledButton.tonal(
                  onPressed: () async {
                    await ref
                        .read(goRouterProvider)
                        .push(
                          ProjectDetailsPage.routePath,
                          extra: proposal.projectId,
                        );
                  },
                  child: const Text('Ir al proyecto'),
                ).margin(const EdgeInsets.only(top: 20.0)),
              ],
            ).margin(Insets.a16),
          ),
        ],
      ).margin(Insets.h16v8),

      bottomNavigationBar: proposal.providerId != userId
          ? FilledButton(
              onPressed: proposal.status != 'ACCEPTED' && !isBussy
                  ? () async {
                      safeSetState(() => isBussy = true);

                      final success = await acceptProposal();

                      if (!success) return;

                      await ChatService.instance.sendMessage(
                        roomId: room.id,
                        senderId: userId,
                        recipientId: room.user1Id == userId
                            ? room.user2Id
                            : room.user1Id,
                        text:
                            '¡Tu propuesta ha sido aceptada!'
                            '\nBuenas noticias, tu propuesta para el proyecto ha sido aceptada por el solicitante.'
                            '\nAhora puedes comenzar a coordinar los detalles y gestionar la entrega desde el chat del proyecto.',
                      );
                      ref.read(goRouterProvider).pop();
                    }
                  : null,
              child: Text(!isBussy ? 'Aceptar propuesta' : 'Aceptando...'),
            ).margin(Insets.h16v8).useSafeArea()
          : null,
    );
  }

  Future<(Proposal, ChatRoom)> loadData() async {
    final (proposal, room) = await (
      ref.read(proposalProvider).getById(widget.proposalId),
      ref.read(chatRoomProvider).getByProposal(widget.proposalId),
    ).wait;

    return (proposal!, room!);
  }

  Future<bool> acceptProposal() {
    return ref.read(proposalProvider).accept(widget.proposalId);
  }
}
