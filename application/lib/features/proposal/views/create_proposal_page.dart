import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/features/projects/controllers/project_payment_provider.dart';
import 'package:paralelo/features/projects/models/project_payment.dart';
import 'package:paralelo/features/projects/models/project.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/widgets/loading_indicator.dart';
import 'package:paralelo/widgets/number_form_field.dart';

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
    return _CreateProposalPageState();
  }
}

class _CreateProposalPageState extends ConsumerState<CreateProposalPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final messageFieldController = TextEditingController();
  final amountFieldController = TextEditingController();
  final timeFieldController = NumberEditingController(value: 1);

  late Future<ProjectPayment?> loadPaymentFuture;

  final messageFieldFocusNode = FocusNode();
  final amountFieldFocusNode = FocusNode();
  final timeFieldFocusNode = FocusNode();

  List<String> modes = ['Remote', 'In-person', 'Hybrid'];
  String selected = 'Remote';

  @override
  void initState() {
    super.initState();

    loadPaymentFuture = loadPayment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: IconButton(
          onPressed: () {
            ref.read(goRouterProvider).pop();
          },
          icon: Icon(LucideIcons.x),
        ).align(AlignmentGeometry.centerLeft),
      ),

      body: FutureBuilder(
        future: loadPaymentFuture,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return LoadingIndicator().center();
          }

          final payment = snapshot.data!;

          if (amountFieldController.text.isEmpty) {
            amountFieldController.text = '${((payment.max + payment.min) / 2)}';
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

                  children: modes
                      .map(
                        (m) => ChoiceChip(
                          label: Text(m).center(),
                          showCheckmark: false,
                          backgroundColor: Colors.transparent,
                          selected: selected == m,

                          onSelected: (_) {
                            setState(() => selected = m);
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
                NumberFormField(
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
          ).margin(const EdgeInsets.symmetric(horizontal: 16.0));
        },
      ),

      bottomNavigationBar: FutureBuilder(
        future: loadPayment(),
        builder: (_, snapshot) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 16.0,

            children: [
              OutlinedButton(
                onPressed: snapshot.hasData ? () {} : null,
                child: Text('Cancelar'),
              ).expanded(),
              FilledButton(
                onPressed: snapshot.hasData
                    ? () {
                        formKey.currentState!.validate();
                      }
                    : null,
                child: Text('Aplicar'),
              ).expanded(),
            ],
          ).margin(const EdgeInsets.symmetric(horizontal: 16.0)).useSafeArea();
        },
      ),
    ).hideKeyboardOnTap(context);
  }

  Future<ProjectPayment?> loadPayment() {
    if (widget.projectPayment != null) {
      return Future.value(widget.projectPayment);
    }

    return ref.read(projectPaymentProvider).getByProject(widget.project.id);
  }
}
