import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/widgets/modal_bottom_sheet.dart';

class _SortProjectModal extends ConsumerWidget {
  final String? value;

  _SortProjectModal({this.value});

  final List<String> options = [
    'last_updated',
    'first_updated',
    'a_to_z',
    'z_to_a',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
  }
}

Future<String?> showProjectSortModalBottomSheet(
  BuildContext context, {
  String? value,
}) {
  return showModalBottomSheet<String?>(
    context: context,
    isScrollControlled: true,

    builder: (_) {
      return _SortProjectModal(value: value);
    },
  );
}
