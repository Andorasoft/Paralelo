import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/constants.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/services.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/project/exports.dart';
import 'package:paralelo/features/chat/exports.dart';
import 'package:paralelo/features/project_payment/exports.dart';
import 'package:paralelo/features/proposal/exports.dart';
import 'package:paralelo/widgets/navigation_button.dart';
import 'package:paralelo/widgets/skeleton.dart';
import 'package:paralelo/widgets/skeleton_block.dart';
import 'package:paralelo/widgets/skeleton_card.dart';

class CreateProposalPage extends ConsumerStatefulWidget {
  static const routePath = '/create-proposal';

  final String projectId;

  const CreateProposalPage({super.key, required this.projectId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CreateProposalPageState();
  }
}

class _CreateProposalPageState extends ConsumerState<CreateProposalPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  late Future<_CreateProposalDto> loadDataFuture;
  late final String userId;

  final messageFieldController = TextEditingController();
  final amountFieldController = TextEditingController();
  final durationFieldController = TextEditingController();

  final messageFieldFocusNode = FocusNode();
  final amountFieldFocusNode = FocusNode();
  final durationFieldFocusNode = FocusNode();

  bool isBussy = false;
  String selectedMode = ProposalMode.remote;

  @override
  void initState() {
    super.initState();

    userId = ref.read(authProvider)!.id;
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

          final data = snapshot.data!;

          return page(
            project: data.project,
            payment: data.payment,
            applied: data.applied,
          );
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
          ),

          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.0,
            children: [
              ...const [
                SkeletonBlock(width: 192.0, height: 16.0),
                SkeletonBlock(width: double.infinity, height: 16.0),
                SkeletonBlock(width: double.infinity, height: 16.0),
              ],

              const SkeletonBlock(
                width: 160.0,
                height: 16.0,
              ).margin(const EdgeInsets.only(top: 16.0)),
              const SkeletonCard(
                child: SizedBox(width: double.infinity, height: 128.0),
              ),
              const SkeletonBlock(
                radius: 100.0,
                width: 160.0,
                height: 16.0,
              ).margin(const EdgeInsets.only(top: 16.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 16.0,
                children: [
                  for (int i = 0; i < 3; i++)
                    const SkeletonBlock(
                      width: double.infinity,
                      height: 24.0,
                    ).expanded(),
                ],
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

  Widget page({
    required Project project,
    required ProjectPayment payment,
    required bool applied,
  }) {
    if (amountFieldController.text.isEmpty) {
      final avg = ((payment.max + payment.min) / 2);
      amountFieldController.text = avg.toStringAsFixed(2);
    }

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const NavigationButton(type: NavigationButtonType.close),
      ),

      body: Form(
        key: formKey,

        child: ListView(
          children: [
            Text('Propuesta para el proyecto'),
            Text(
              project.title,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500),
            ),

            Text(
              'Mensaje al solicitante',
            ).margin(const EdgeInsets.only(top: 16.0, bottom: 4.0)),
            TextFormField(
              controller: messageFieldController,
              focusNode: messageFieldFocusNode,
              minLines: 4,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Escribe aquí tu propuesta o cómo planeas ayudar',
              ),
            ),

            Text(
              'Modalidad de trabajo',
            ).margin(const EdgeInsets.only(top: 16.0, bottom: 4.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 8.0,
              children: ProposalMode.values
                  .map(
                    (i) => ChoiceChip(
                      label: Text(ProposalMode.labels[i]!).center(),
                      showCheckmark: false,
                      backgroundColor: Colors.transparent,
                      selected: selectedMode == i,

                      onSelected: (_) {
                        setState(() => selectedMode = i);
                      },
                    ).expanded(),
                  )
                  .toList(),
            ),

            Text(
              payment.type == ProjectPaymentType.fixed
                  ? 'Monto total (USD)'
                  : 'Tarifa por hora (USD)',
            ).margin(const EdgeInsets.only(top: 16.0, bottom: 4.0)),
            TextFormField(
              controller: amountFieldController,
              focusNode: amountFieldFocusNode,

              decoration: InputDecoration(
                prefixIcon: Icon(LucideIcons.dollarSign),
              ),

              keyboardType: TextInputType.number,
            ),

            Text(
              'Tiempo estimado de entrega (opcional)',
            ).margin(const EdgeInsets.only(top: 16.0, bottom: 4.0)),
            TextFormField(
              controller: durationFieldController,
              focusNode: durationFieldFocusNode,

              decoration: InputDecoration(hintText: 'Ejemplo: 4 horas'),
            ),
          ],
        ),
      ).margin(Insets.h16v8),

      bottomNavigationBar: FilledButton(
        onPressed: !applied && !isBussy
            ? () async {
                safeSetState(() => isBussy = true);

                await createProposal(project: project, payment: payment);
                ref.read(goRouterProvider).pop();
              }
            : null,

        child: Text(!isBussy ? 'Enviar propuesta' : 'Enviando propuesta...'),
      ).margin(Insets.h16v8).useSafeArea(),
    );
  }

  Future<_CreateProposalDto> loadData() async {
    final userId = ref.read(authProvider)!.id;

    final (project, payment, applied) = await (
      ref.read(projectProvider).getById(widget.projectId),
      ref.read(projectPaymentProvider).getForProject(widget.projectId),
      ref
          .read(proposalProvider)
          .applied(projectId: widget.projectId, providerId: userId),
    ).wait;

    return _CreateProposalDto(
      project: project!,
      payment: payment!,
      applied: applied,
    );
  }

  Future<void> createProposal({
    required Project project,
    required ProjectPayment payment,
  }) async {
    final amount = num.parse(amountFieldController.text);
    num? hourlyRate, fixedRate;

    if (payment.type == ProjectPaymentType.hourly) {
      hourlyRate = amount;
    } else {
      fixedRate = amount;
    }

    final proposal = await ref
        .read(proposalProvider)
        .create(
          message: messageFieldController.text,
          mode: selectedMode,
          amount: fixedRate,
          hourlyRate: hourlyRate,
          estimatedDuration: durationFieldController.text,
          providerId: userId,
          projectId: widget.projectId,
        );
    final room = await ref
        .read(chatRoomProvider)
        .create(
          user1Id: project.ownerId,
          user2Id: userId,
          proposalId: proposal.id,
        );

    await ChatService.instance.sendMessage(
      roomId: room.id,
      senderId: userId,
      recipientId: project.ownerId,
      text: proposal.message,
    );
  }
}

class _CreateProposalDto {
  final Project project;
  final ProjectPayment payment;
  final bool applied;

  const _CreateProposalDto({
    required this.project,
    required this.payment,
    required this.applied,
  });
}
