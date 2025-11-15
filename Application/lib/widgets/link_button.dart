import 'package:paralelo/core/imports.dart';

class LinkButton extends ConsumerWidget {
  final String data;
  final String url;

  const LinkButton(this.data, {super.key, required this.url});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {},

      style: Theme.of(context).textButtonTheme.style?.copyWith(
        minimumSize: WidgetStateProperty.all(Size.zero),
        fixedSize: WidgetStateProperty.all(Size.fromHeight(15.0)),
        padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 5.0)),
        shape: WidgetStateProperty.all(const RoundedRectangleBorder()),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
      ),

      child: Text(data),
    );
  }
}
