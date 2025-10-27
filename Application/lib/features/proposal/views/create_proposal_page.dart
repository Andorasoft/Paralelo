import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/constants.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/services.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/projects/exports.dart';
import 'package:paralelo/features/chats/exports.dart';
import 'package:paralelo/features/proposal/exports.dart';
import 'package:paralelo/utils/extensions.dart';
import 'package:paralelo/widgets/navigation_button.dart';
import 'package:paralelo/widgets/number_input_form_field.dart';
import 'package:paralelo/widgets/skeleton.dart';
import 'package:paralelo/widgets/skeleton_block.dart';
import 'package:paralelo/widgets/skeleton_card.dart';

class CreateProposalPage extends ConsumerStatefulWidget {
  static const routePath = '/create-proposal';

  final int projectId;

  const CreateProposalPage({super.key, required this.projectId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CreateProposalPageState();
  }
}

class _CreateProposalPageState extends ConsumerState<CreateProposalPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  late final Future<(Project, ProjectPayment, bool)> loadDataFuture;

  final messageFieldController = TextEditingController();
  final messageFieldFocusNode = FocusNode();

  final amountFieldController = TextEditingController();
  final amountFieldFocusNode = FocusNode();

  final timeFieldController = NumberEditingController(value: 1);
  final timeFieldFocusNode = FocusNode();

  String selectedMode = 'REMOTE';

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

  Widget page((Project, ProjectPayment, bool) data) {
    final (project, payment, applied) = data;

    if (amountFieldController.text.isEmpty) {
      amountFieldController.text = ((payment.max + payment.min) / 2)
          .toStringAsFixed(2);
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
              'Tiempo estimado de entrega',
            ).margin(const EdgeInsets.only(top: 16.0, bottom: 4.0)),
            NumberInputFormField(
              controller: timeFieldController,
              focusNode: timeFieldFocusNode,
              validator: (num? value) {
                if (value == null) {
                  return 'Por favor, ingresa un número válido';
                }
                if (value < 0) {
                  return "El valor debe ser mayor o igual a 1";
                }

                return null;
              },

              hintText: payment.type == ProjectPaymentType.fixed
                  ? 'Ejemplo: 2 días'
                  : 'Ejemplo: 4 horas',
              min: 0,
              max: 50,
              icon: const Icon(LucideIcons.calendar),
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

        child: Text(!isBussy ? 'Aplicar' : 'Aplicando...'),
      ).margin(Insets.h16v8).useSafeArea(),
    );
  }

  Future<(Project, ProjectPayment, bool)> loadData() async {
    final userId = ref.read(authProvider)!.id;

    final (project, payment, applied) = await (
      ref.read(projectProvider).getById(widget.projectId),
      ref.read(projectPaymentProvider).getByProject(widget.projectId),
      ref
          .read(proposalProvider)
          .applied(projectId: widget.projectId, providerId: userId),
    ).wait;

    return (project!, payment!, applied);
  }

  Future<void> createProposal({
    required Project project,
    required ProjectPayment payment,
  }) async {
    final userId = ref.read(authProvider)!.id;

    final hourlyRate = payment.type == 'HOURLY'
        ? num.parse(amountFieldController.text)
        : null;
    final fixedRate = payment.type == 'FIXED'
        ? num.parse(amountFieldController.text)
        : null;

    final proposal = await ref
        .read(proposalProvider)
        .create(
          message: messageFieldController.text,
          mode: selectedMode,
          amount: fixedRate,
          hourlyRate: hourlyRate,
          estimatedDurationValue: timeFieldController.value!,
          estimatedDurationUnit: payment.type == 'HOURLY' ? 'HOURS' : 'DAYS',
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
