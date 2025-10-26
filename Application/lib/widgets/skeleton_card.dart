import 'package:paralelo/core/imports.dart';

class SkeletonCard extends ConsumerWidget {
  final Widget child;

  const SkeletonCard({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(width: 1.0, color: Colors.grey.shade200),
      ),
      child: child,
    );
  }
}
