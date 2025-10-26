import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';

class PasswordFormField extends ConsumerStatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final String? labelText;

  const PasswordFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.labelText,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PasswordFormFieldState();
  }
}

class _PasswordFormFieldState extends ConsumerState<PasswordFormField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,

      obscureText: !showPassword,

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
        hintText: widget.hintText,
        labelText: widget.labelText,

        prefixIcon: const Icon(LucideIcons.lock),
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
