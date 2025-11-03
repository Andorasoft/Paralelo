import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';

class PasswordFormField extends ConsumerStatefulWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Color? backgroundColor;
  final String? hintText;
  final String? labelText;

  const PasswordFormField({
    super.key,
    this.controller,
    this.validator,
    this.backgroundColor,
    this.hintText,
    this.labelText,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PasswordFormFieldState();
  }
}

class _PasswordFormFieldState extends ConsumerState<PasswordFormField> {
  final focusNode = FocusNode();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      focusNode: focusNode,

      obscureText: !showPassword,

      decoration: InputDecoration(
        filled: true,
        fillColor: widget.backgroundColor ?? Colors.transparent,

        enabledBorder: inputBorder(),
        focusedBorder: inputBorder(),
        errorBorder: inputBorder(),
        focusedErrorBorder: inputBorder(),

        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: widget.hintText,
        labelText: widget.labelText,
        hintStyle: hintStyle(),

        prefixIcon: Icon(
          LucideIcons.lock,
          color: Theme.of(context).colorScheme.outline,
        ),
        suffixIcon: InkWell(
          onTap: () {
            safeSetState(() => showPassword = !showPassword);
          },
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          child: Icon(showPassword ? LucideIcons.eye : LucideIcons.eyeOff),
        ),
      ),

      keyboardType: TextInputType.visiblePassword,
    );
  }

  InputBorder inputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(12.0),
    );
  }

  TextStyle? hintStyle() {
    return Theme.of(
      context,
    ).inputDecorationTheme.hintStyle?.copyWith(fontSize: 14.0);
  }
}
