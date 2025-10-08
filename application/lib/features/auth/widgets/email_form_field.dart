import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

class EmailFormField extends ConsumerStatefulWidget {
  final TextEditingController? controller;
  final String? hintText;

  const EmailFormField({super.key, this.controller, this.hintText});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _EmailFormFieldState();
  }
}

class _EmailFormFieldState extends ConsumerState<EmailFormField> {
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: focusNode,

      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Icon(LucideIcons.mail),
        suffixIcon: InkWell(
          onTap: () {},
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          child: Icon(LucideIcons.x),
        ),
      ),

      keyboardType: TextInputType.emailAddress,
    );
  }
}
