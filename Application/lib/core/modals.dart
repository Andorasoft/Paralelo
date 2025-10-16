import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/widgets/modal_bottom_sheet.dart';

Future<String?> showLocaleSelectorModalBottomSheet(
  BuildContext context, {
  String? value,
}) {
  final options = const [
    {'title': 'Español', 'code': 'es'},
    {'title': 'English', 'code': 'en'},
  ];

  return showModalBottomSheet<String>(
    context: context,
    builder: (_) {
      return ModalBottomSheet(
        title: PreferredSize(
          preferredSize: const Size.fromHeight(44.0),

          child: Text('modal.language.title'.tr()).center(),
        ),

        child: RadioGroup(
          groupValue: value,
          onChanged: (value) {
            if (!context.mounted) return;

            Navigator.of(context).pop(value);
          },

          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: options
                .map(
                  (it) => RadioListTile(
                    value: it['code'] as String,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      it['title'] as String,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
    },
  );
}

Future<String?> showProjectReportModalBottomSheet(BuildContext context) {
  final options = const [
    'inappropriate',
    'scam',
    'offensive',
    'terms_violation',
    'abusive_budget',
  ];

  String? selected;

  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,

    builder: (_) {
      return ModalBottomSheet(
        title: PreferredSize(
          preferredSize: Size.fromHeight(44.0),
          child: Text('modal.report.title'.tr()).center(),
        ),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(44.0),
          child: FilledButton(
            onPressed: () {
              Navigator.of(context).pop(selected);
            },
            child: Text('modal.report.submit'.tr()),
          ),
        ),

        child: StatefulBuilder(
          builder: (_, setState) {
            return RadioGroup(
              groupValue: selected,
              onChanged: (value) {
                if (!context.mounted) return;

                setState(() => selected = value);
              },

              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: options
                    .map(
                      (key) => RadioListTile<String>(
                        value: key,
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'modal.report.options.$key.title'.tr(),
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          'modal.report.options.$key.description'.tr(),
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
      );
    },
  );
}

// Future<Map<String, dynamic>?> showProjectFilterModalBottomSheet(
//   BuildContext context,
// ) {
//   final formKey = GlobalKey<FormState>();

//   final filters =
//       {
//             'start_date': null,
//             'end_date': null,
//             'min_price': '1',
//             'max_price': '5',
//             'payment_type': 'HOURLY',
//           }
//           as Map<String, dynamic>;

//   final minPriceFieldController = TextEditingController(text: '1');
//   final minPriceFieldFocusNode = FocusNode();

//   final maxPriceFieldController = TextEditingController(text: '5');
//   final maxPriceFieldFocusNode = FocusNode();

//   return showModalBottomSheet<Map<String, dynamic>?>(
//     context: context,
//     isScrollControlled: true,

//     builder: (_) {
//       return StatefulBuilder(
//         builder: (_, setState) {
//           return Form(
//             key: formKey,

//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               spacing: 4.0,

//               children: [
//                 Stack(
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         filters['start_date'] = null;
//                         filters['end_date'] = null;
//                         filters['min_price'] = '1';
//                         filters['max_price'] = '5';
//                         filters['payment_type'] = 'hourly';

//                         setState(() {
//                           minPriceFieldController.text = '1';
//                           maxPriceFieldController.text = '5';
//                         });
//                       },
//                       child: Text(
//                         'button.reset'.tr(),
//                         style: TextStyle(
//                           color: Theme.of(context).colorScheme.error,
//                         ),
//                       ),
//                     ).align(AlignmentGeometry.centerLeft),
//                     Text(
//                       'Filters',
//                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ).center(),
//                   ],
//                 ).size(height: 44.0),

//                 Text('Date range').margin(const EdgeInsets.only(top: 16.0)),
//                 Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   spacing: 8.0,

//                   children: [
//                     DatePickerButton(
//                       value: filters['start_date'] as DateTime?,
//                       onDateChanged: (date) {
//                         setState(() => filters['start_date'] = date);
//                       },
//                     ).expanded(),
//                     DatePickerButton(
//                       value: filters['end_date'] as DateTime?,
//                       onDateChanged: (date) {
//                         setState(() => filters['end_date'] = date);
//                       },
//                     ).expanded(),
//                   ],
//                 ),

//                 Text('Price range').margin(const EdgeInsets.only(top: 16.0)),
//                 Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   spacing: 8.0,

//                   children: [
//                     TextFormField(
//                       controller: minPriceFieldController,
//                       focusNode: minPriceFieldFocusNode,

//                       validator: (value) => priceFormValidator(value),
//                       onChanged: (value) {},

//                       decoration: const InputDecoration(
//                         prefixIcon: Icon(LucideIcons.dollarSign),
//                       ),

//                       keyboardType: TextInputType.number,
//                     ).expanded(),
//                     TextFormField(
//                       controller: maxPriceFieldController,
//                       focusNode: maxPriceFieldFocusNode,

//                       validator: (value) => priceFormValidator(value),
//                       onChanged: (value) {},

//                       decoration: const InputDecoration(
//                         prefixIcon: Icon(LucideIcons.dollarSign),
//                       ),

//                       keyboardType: TextInputType.number,
//                     ).expanded(),
//                   ],
//                 ),

//                 Text('Payment type').margin(const EdgeInsets.only(top: 16.0)),
//                 DropdownButtonFormField(
//                   onChanged: (value) {},
//                   initialValue: filters['payment_type'],
//                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
//                   items: [
//                     DropdownMenuItem(value: 'HOURLY', child: Text('Hourly')),
//                     DropdownMenuItem(value: 'PROJECT', child: Text('Project')),
//                   ],
//                 ),

//                 FilledButton(
//                   onPressed: () {
//                     if (!formKey.currentState!.validate()) {
//                       return;
//                     }

//                     Navigator.of(context).pop(filters);
//                   },
//                   child: Text('Apply now'),
//                 ).margin(const EdgeInsets.only(top: 16.0)),
//               ],
//             ).useSmartMargin(),
//           ).hideKeyboardOnTap(context);
//         },
//       ).useSafeArea();
//     },
//   );
// }

Future<String?> showProjectSortModalBottomSheet(
  BuildContext context, {
  String? value,
}) {
  final List<String> options = [
    'last_updated',
    'first_updated',
    'a_to_z',
    'z_to_a',
  ];

  return showModalBottomSheet<String?>(
    context: context,
    isScrollControlled: true,

    builder: (_) {
      return ModalBottomSheet(
        title: PreferredSize(
          preferredSize: const Size.fromHeight(44.0),
          child: Text('modal.sort.title'.tr()).center(),
        ),

        child: RadioGroup<String>(
          groupValue: value,
          onChanged: (value) {
            Navigator.of(context).pop(value);
          },

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: options
                .map(
                  (key) => RadioListTile<String>(
                    value: key,
                    contentPadding: EdgeInsets.zero,
                    title: Text('modal.sort.options.$key'.tr()),
                  ),
                )
                .toList(),
          ),
        ),
      );
    },
  );
}

Future<void> showUserNotAllowedDialog(
  BuildContext context, {
  required WidgetRef ref,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,

    builder: (_) => AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),

      title: const Text('Acceso restringido'),
      content: Text(
        'El dominio no pertenece a ninguna universidad registrada.\n'
        'Por favor, utiliza tu correo institucional para acceder.',
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await ref.read(authProvider.notifier).logout();
          },
          child: const Text('Entendido'),
        ),
      ],
    ),
  );
}
