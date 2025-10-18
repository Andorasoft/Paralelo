import 'package:paralelo/core/imports.dart';

class PersonPicture extends ConsumerWidget {
  final String source;
  final double? size;

  const PersonPicture({super.key, required this.source, this.size});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = size ?? 64.0;

    if (source.isEmpty) {
      return SvgPicture.asset('assets/images/user.svg', width: s, height: s);
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: Image.network(source, width: s, height: s),
      );
    }
  }
}
