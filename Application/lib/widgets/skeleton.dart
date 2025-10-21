import 'package:paralelo/core/imports.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends ConsumerWidget {
  final Widget child;

  const Skeleton({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey.shade300,

      child: child,
    );
  }
}
