import 'package:paralelo/core/imports.dart';

class RatingPresenter extends ConsumerWidget {
  final double rating;

  const RatingPresenter({super.key, required this.rating});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      spacing: 4.0,
      children: [
        const Icon(Icons.star_rounded, size: 20.0),
        Text('$rating', style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
