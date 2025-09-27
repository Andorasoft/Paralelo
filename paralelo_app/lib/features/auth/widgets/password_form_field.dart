import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';

class PasswordFormField extends ConsumerStatefulWidget {
  final TextEditingController? controller;
  final String? hintText;

  const PasswordFormField({super.key, this.controller, this.hintText});

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
      focusNode: focusNode,

      obscureText: !showPassword,

      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Icon(LucideIcons.lock),
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
}
