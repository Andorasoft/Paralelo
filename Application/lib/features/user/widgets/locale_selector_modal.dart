import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/widgets/modal_bottom_sheet.dart';

class LocaleSelectorModal extends ConsumerWidget {
  final String? value;

  const LocaleSelectorModal({super.key, this.value});

  final options = const [
    {'title': 'Español', 'code': 'es'},
    //{'title': 'English', 'code': 'en'},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
  }
}
