import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';

class NameFormField extends ConsumerStatefulWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Color? backgroundColor;
  final String? hintText;
  final String? labelText;

  const NameFormField({
    super.key,
    this.controller,
    this.validator,
    this.backgroundColor,
    this.hintText,
    this.labelText,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _NameFormFieldState();
  }
}

class _NameFormFieldState extends ConsumerState<NameFormField> {
  final focusNode = FocusNode();
  final uuid = Uuid().v4();
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      focusNode: focusNode,

      onChanged: (value) {
        EasyDebounce.debounce(uuid, Durations.medium4, () {
          safeSetState(() {});
        });
      },

      decoration: InputDecoration(
        filled: true,
        fillColor: widget.backgroundColor ?? Colors.transparent,

        enabledBorder: inputBorder(),
        focusedBorder: inputBorder(),
        errorBorder: inputBorder(),
        focusedErrorBorder: inputBorder(),

        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: hintStyle(),

        prefixIcon: Icon(
          LucideIcons.user,
          color: Theme.of(context).colorScheme.outline,
        ),
        suffixIcon: controller.text.isNotEmpty
            ? InkWell(
                onTap: () {
                  controller.clear();
                  safeSetState(() {});
                },
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                child: const Icon(LucideIcons.x),
              )
            : null,
      ),

      keyboardType: TextInputType.text,
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
