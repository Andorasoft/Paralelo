import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/constants.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/services.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/projects/exports.dart';
import 'package:paralelo/features/chats/exports.dart';
import 'package:paralelo/features/proposal/exports.dart';
import 'package:paralelo/widgets/loading_indicator.dart';
import 'package:paralelo/widgets/navigation_button.dart';
import 'package:paralelo/widgets/number_input_form_field.dart';

class CreateProposalPage extends ConsumerStatefulWidget {
  static const routePath = '/create-proposal';

  final Project project;
  final ProjectPayment? payment;

  const CreateProposalPage({super.key, required this.project, this.payment});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CreateProposalPageState();
  }
}

class _CreateProposalPageState extends ConsumerState<CreateProposalPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  late final Future<ProjectPayment?> loadDataFuture;

  final messageFieldController = TextEditingController();
  final messageFieldFocusNode = FocusNode();

  final amountFieldController = TextEditingController();
  final amountFieldFocusNode = FocusNode();

  final timeFieldController = NumberEditingController(value: 1);
  final timeFieldFocusNode = FocusNode();

  String selectedMode = 'REMOTE';

  @override
  void initState() {
    super.initState();

    loadDataFuture = loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        automaticallyImplyLeading: false,

        leading: const NavigationButton(type: NavigationButtonType.close),
      ),

      body: FutureBuilder(
        future: loadDataFuture,

        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingIndicator().center();
          }

          final payment = snapshot.data!;

          if (amountFieldController.text.isEmpty) {
            amountFieldController.text = ((payment.max + payment.min) / 2)
                .toStringAsFixed(2);
          }

          return Form(
            key: formKey,

            child: ListView(
              children: [
                Text('Propuesta para el proyecto'),
                Text(
                  widget.project.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
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
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
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

                if (payment.type == 'proyecto') ...[
                  Text(
                    'Monto total (USD)',
                  ).margin(const EdgeInsets.only(top: 16.0, bottom: 4.0)),
                  TextFormField(
                    controller: amountFieldController,
                    focusNode: amountFieldFocusNode,

                    decoration: InputDecoration(
                      prefixIcon: Icon(LucideIcons.dollarSign),
                    ),

                    keyboardType: TextInputType.number,
                  ),
                ] else ...[
                  Text(
                    'Tarifa por hora (USD)',
                  ).margin(const EdgeInsets.only(top: 16.0, bottom: 4.0)),
                  TextFormField(
                    controller: amountFieldController,
                    focusNode: amountFieldFocusNode,

                    decoration: InputDecoration(
                      prefixIcon: Icon(LucideIcons.dollarSign),
                    ),

                    keyboardType: TextInputType.number,
                  ),
                ],

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

                  hintText: payment.type == 'proyecto'
                      ? 'Ejemplo: 2 días'
                      : 'Ejemplo: 4 horas',
                  min: 0,
                  max: 50,
                  icon: Icon(LucideIcons.calendar),
                ),
              ],
            ),
          ).margin(const EdgeInsets.symmetric(horizontal: 8.0));
        },
      ),

      bottomNavigationBar: FutureBuilder(
        future: loadDataFuture,

        builder: (_, snapshot) {
          return FilledButton(
            onPressed: snapshot.hasData
                ? () async {
                    final error = await createProposal(snapshot.data!);

                    if (error == null) {
                      ref.read(goRouterProvider).pop();
                    } else {
                      showSnackbar(context, error);
                    }
                  }
                : null,
            child: const Text('Aplicar'),
          ).margin(const EdgeInsets.all(8.0)).useSafeArea();
        },
      ),
    ).hideKeyboardOnTap(context);
  }

  Future<ProjectPayment> loadData() async {
    if (widget.payment != null) {
      return Future.value(widget.payment);
    }

    final payment = await ref
        .read(projectPaymentProvider)
        .getByProject(widget.project.id);

    return payment!;
  }

  Future<String?> createProposal(ProjectPayment payment) async {
    final userId = ref.read(authProvider)!.id;
    String? error;

    final hourlyRate = payment.type == 'HOURLY'
        ? num.parse(amountFieldController.text)
        : null;
    final fixedRate = payment.type == 'FIXED'
        ? num.parse(amountFieldController.text)
        : null;

    try {
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
            projectId: widget.project.id,
          );
      final room = await ref
          .read(chatRoomProvider)
          .create(
            user1Id: widget.project.ownerId,
            user2Id: userId,
            proposalId: proposal.id,
          );

      await ChatService.instance.sendMessage(
        roomId: room.id,
        senderId: userId,
        recipientId: widget.project.ownerId,
        text: proposal.message,
      );
    } catch (err) {
      error = 'Error: $err';
    }

    return error;
  }
}
