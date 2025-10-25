import 'package:paralelo/core/imports.dart';

class EmailFormField extends ConsumerStatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final String? labelText;

  const EmailFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.labelText,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _EmailFormFieldState();
  }
}

class _EmailFormFieldState extends ConsumerState<EmailFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,

      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withAlpha(100),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12.0),
        ),

        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: widget.labelText,
        hintText: widget.hintText,

        prefixIcon: const Icon(LucideIcons.mail),
        suffixIcon: InkWell(
          onTap: () {},
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          child: const Icon(LucideIcons.x),
        ),
      ),

      keyboardType: TextInputType.emailAddress,
    );
  }
}
