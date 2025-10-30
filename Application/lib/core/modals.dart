import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/utils/extensions.dart';
import 'package:paralelo/widgets/modal_bottom_sheet.dart';

Future<String?> showLocaleSelectorModalBottomSheet(
  BuildContext context, {
  String? value,
}) {
  final options = const [
    {'title': 'Español', 'code': 'es'},
    //{'title': 'English', 'code': 'en'},
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
            child: Text('button.send_report'.tr()),
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
            await ref.read(authProvider.notifier).signOut();
          },
          child: const Text('Entendido'),
        ),
      ],
    ),
  );
}

Future<double?> showRatingUserModalBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,

    builder: (_) {
      var rating = 3.0;

      return ModalBottomSheet(
        title: PreferredSize(
          preferredSize: Size.fromHeight(44.0),
          child: Text('modal.rating_user.title'.tr()).center(),
        ),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(44.0),
          child: FilledButton(
            onPressed: () {
              Navigator.of(context).pop(rating);
            },
            child: Text('button.send_rating'.tr()),
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 4.0,
          children: [
            RatingBar.builder(
              minRating: 1,
              initialRating: rating,
              allowHalfRating: true,
              wrapAlignment: WrapAlignment.spaceBetween,

              onRatingUpdate: (value) {
                rating = value;
              },

              itemPadding: Insets.h8,
              itemBuilder: (_, _) {
                return const Icon(Icons.star, color: Colors.amber);
              },
            ).center().margin(const EdgeInsets.only(top: 20.0)),

            Text(
              'modal.rating_user.options.tell_more'.tr(),
            ).margin(const EdgeInsets.only(top: 20.0)),
            TextField(
              minLines: 3,
              maxLines: null,
              decoration: const InputDecoration(),
            ),
          ],
        ),
      );
    },
  );
}
