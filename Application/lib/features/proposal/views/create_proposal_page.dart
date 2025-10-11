import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/features/auth/controllers/auth_notifier.dart';
import 'package:paralelo/features/projects/controllers/project_payment_provider.dart';
import 'package:paralelo/features/projects/models/project_payment.dart';
import 'package:paralelo/features/projects/models/project.dart';
import 'package:paralelo/features/chats/controllers/chat_room_provider.dart';
import 'package:paralelo/features/proposal/controllers/proposal_provider.dart';
import 'package:paralelo/widgets/loading_indicator.dart';
import 'package:paralelo/widgets/number_input_form_field.dart';
import 'package:paralelo/core/services.dart';
import 'package:paralelo/core/router.dart';

class CreateProposalPage extends ConsumerStatefulWidget {
  static const routeName = 'CreateProposalPage';
  static const routePath = '/create-proposal';

  final Project project;
  final ProjectPayment? projectPayment;

  const CreateProposalPage({
    super.key,
    required this.project,
    this.projectPayment,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return CreateProposalPageState();
  }
}

class CreateProposalPageState extends ConsumerState<CreateProposalPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final _messageFieldController = TextEditingController();
  final _messageFieldFocusNode = FocusNode();

  final _amountFieldController = TextEditingController();
  final _amountFieldFocusNode = FocusNode();

  final _timeFieldController = NumberEditingController(value: 1);
  final _timeFieldFocusNode = FocusNode();

  late final Future<ProjectPayment?> _loadDataFuture;

  final _modes = ['Remote', 'In-person', 'Hybrid'];
  String _selectedMode = 'Remote';

  @override
  void initState() {
    super.initState();

    _loadDataFuture = _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      appBar: AppBar(
        automaticallyImplyLeading: false,

        leading: IconButton(
          onPressed: () {
            ref.read(goRouterProvider).pop();
          },
          icon: const Icon(LucideIcons.x),
        ),
      ),

      body: FutureBuilder(
        future: _loadDataFuture,

        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return LoadingIndicator().center();
          }

          final payment = snapshot.data!;

          if (_amountFieldController.text.isEmpty) {
            _amountFieldController.text =
                '${((payment.max + payment.min) / 2)}';
          }

          return Form(
            key: _formKey,

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
                  controller: _messageFieldController,
                  focusNode: _messageFieldFocusNode,

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

                  children: _modes
                      .map(
                        (m) => ChoiceChip(
                          label: Text(m).center(),
                          showCheckmark: false,
                          backgroundColor: Colors.transparent,
                          selected: _selectedMode == m,

                          onSelected: (_) {
                            setState(() => _selectedMode = m);
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
                    controller: _amountFieldController,
                    focusNode: _amountFieldFocusNode,

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
                    controller: _amountFieldController,
                    focusNode: _amountFieldFocusNode,

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
                  controller: _timeFieldController,
                  focusNode: _timeFieldFocusNode,
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
        future: _loadDataFuture,

        builder: (_, snapshot) {
          return FilledButton(
            onPressed: snapshot.hasData
                ? () async {
                    final error = await _createProposal();

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

  Future<ProjectPayment> _loadData() async {
    if (widget.projectPayment != null) {
      return Future.value(widget.projectPayment);
    }

    final payment = await ref
        .read(projectPaymentProvider)
        .getByProject(widget.project.id);

    return payment!;
  }

  Future<String?> _createProposal() async {
    String? error;

    try {
      final user = ref.read(authProvider)!;

      final proposal = await ref
          .read(proposalProvider)
          .create(
            message: _messageFieldController.text,
            mode: _selectedMode,
            status: 'PENDING',
            providerId: widget.project.ownerId,
            projectId: widget.project.id,
          );
      final room = await ref
          .read(chatRoomProvider)
          .create(
            user1Id: widget.project.ownerId,
            user2Id: user.id,
            proposalId: proposal.id,
          );

      await ChatService.sendMessage(
        roomId: room.id,
        senderId: user.id,
        recipientId: widget.project.ownerId,
        text: proposal.message,
      );
    } catch (err) {
      error = 'Error: $err';
    }

    return error;
  }
}
