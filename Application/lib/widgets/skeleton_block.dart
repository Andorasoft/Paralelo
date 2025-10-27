import 'package:paralelo/core/imports.dart';

class SkeletonBlock extends ConsumerWidget {
  final double width;
  final double height;
  final double? radius;

  const SkeletonBlock({
    super.key,
    required this.width,
    required this.height,
    this.radius,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 100.0),
        color: Colors.grey.shade200,
      ),
    );
  }
}
