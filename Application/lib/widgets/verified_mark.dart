import 'package:paralelo/core/imports.dart';

class VerifiedMark extends ConsumerWidget {
  final double size;

  const VerifiedMark({super.key, this.size = 24.0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Icon(
      TablerIcons.rosette_discount_check_filled,
      size: size,
      color: Theme.of(context).colorScheme.tertiary.withAlpha(155),
    );
  }
}
