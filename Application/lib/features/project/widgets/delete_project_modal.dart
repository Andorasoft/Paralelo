import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/widgets/modal_bottom_sheet.dart';

class _DeleteProjectModal extends ConsumerWidget {
  const _DeleteProjectModal();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ModalBottomSheet(
      title: PreferredSize(
        preferredSize: Size.fromHeight(44.0),
        child: const Text('¿Quieres eliminar este proyecto?').center(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 4.0,
        children: [
          const Text('Esta acción no se puede deshacer.'),
          const SizedBox(height: 12.0),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Sí, eliminar'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }
}

Future<bool?> showDeleteProjectModalBottomSheet(BuildContext context) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return const _DeleteProjectModal();
    },
  );
}
