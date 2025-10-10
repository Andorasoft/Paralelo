import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';

class MessageInputBar extends ConsumerStatefulWidget {
  final void Function(String) onSubmitted;

  const MessageInputBar({super.key, required this.onSubmitted});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return MessageInputBarState();
  }
}

class MessageInputBarState extends ConsumerState<MessageInputBar> {
  final _inputFieldController = TextEditingController();
  final _inputFieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 8.0,

      children: [
        TextFormField(
          controller: _inputFieldController,
          focusNode: _inputFieldFocusNode,

          decoration: InputDecoration(
            hintText: 'Mensaje...',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(100.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
        ).expanded(),
        IconButton.filled(
          onPressed: () {
            if (_inputFieldController.text.isEmpty) return;

            final msg = _inputFieldController.text;
            _inputFieldController.clear();

            widget.onSubmitted.call(msg);
          },
          icon: const Icon(Icons.send, size: 20.0),
        ),
      ],
    );
  }
}
