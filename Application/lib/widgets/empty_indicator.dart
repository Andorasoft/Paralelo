import 'package:paralelo/core/imports.dart';

class EmptyIndicator<T> extends ConsumerWidget {
  final String? message;

  const EmptyIndicator({super.key, this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(message ?? 'empty'.tr());
  }
}
