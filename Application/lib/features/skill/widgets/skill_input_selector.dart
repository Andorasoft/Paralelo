import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/skill/exports.dart';
import 'package:paralelo/utils/extensions.dart';

class SkillInputSelector extends ConsumerStatefulWidget {
  final List<Skill> source;
  final int? max;
  final void Function(Skill)? onAdd;
  final void Function(Skill)? onRemove;
  final String? Function(String?)? validator;

  const SkillInputSelector({
    super.key,
    required this.source,
    this.max,
    this.onAdd,
    this.onRemove,
    this.validator,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChipInputFormField();
}

class _ChipInputFormField extends ConsumerState<SkillInputSelector> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  final link = LayerLink();
  final selected = <String>{};

  OverlayEntry? overlayEntry;

  List<Skill> get filteredSource {
    final query = controller.text.trim().toLowerCase();
    if (query.isEmpty) {
      return widget.source.where((i) => !selected.contains(i.id)).toList();
    }
    return widget.source
        .where(
          (i) =>
              !selected.contains(i.id) && i.name.toLowerCase().contains(query),
        )
        .toList();
  }

  @override
  void initState() {
    super.initState();

    focusNode.addListener(handleFocusChange);
    controller.addListener(() {
      if (overlayEntry != null) {
        overlayEntry!.markNeedsBuild();
      }
    });
  }

  @override
  void dispose() {
    hideOverlay();
    focusNode.removeListener(handleFocusChange);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: link,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12.0),
        ),

        child: Wrap(
          spacing: 6,
          runSpacing: -8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ...selected.map((id) {
              final item = widget.source.singleWhere((i) => i.id == id);
              return chip(item);
            }),
            input(),
          ],
        ).margin(Insets.a8),
      ),
    );
  }

  void handleFocusChange() {
    if (focusNode.hasFocus) {
      showOverlay();
    } else {
      hideOverlay();
    }
  }

  void showOverlay() {
    overlayEntry = overlay();
    Overlay.of(context, rootOverlay: true).insert(overlayEntry!);
  }

  void hideOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  OverlayEntry overlay() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final width = MediaQuery.of(context).size.width;
    final offset = Offset((size.width - width) / 2, size.height + 4.0);

    return OverlayEntry(
      builder: (_) {
        return Positioned(
          width: width,

          child: CompositedTransformFollower(
            link: link,
            showWhenUnlinked: false,
            offset: offset,

            child: Material(
              elevation: 8.0,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 250.0),
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,

                  children: filteredSource
                      .map(
                        (i) => ListTile(
                          dense: true,
                          shape: const RoundedRectangleBorder(),
                          title: Text(i.name),
                          onTap: () {
                            focusNode.unfocus();
                            safeSetState(() => selected.add(i.id));
                            widget.onAdd?.call(i);
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget chip(Skill item) {
    return Chip(
      onDeleted: () {
        safeSetState(() => selected.remove(item.id));
        widget.onRemove?.call(item);
      },
      label: Text(item.name, style: Theme.of(context).textTheme.bodyMedium),
      padding: EdgeInsets.zero,
      labelPadding: const EdgeInsets.only(left: 12.0),
      deleteIconBoxConstraints: const BoxConstraints(minWidth: 32.0),
      deleteIcon: const Icon(LucideIcons.x).align(Alignment.center),
    );
  }

  Widget input() {
    final disabled = widget.max != null && selected.length >= widget.max!;

    return TextField(
      controller: controller,
      focusNode: focusNode,
      enabled: !disabled,

      decoration: const InputDecoration(
        isDense: true,
        isCollapsed: true,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
        hintText: 'Agregar...',
      ),
      onChanged: (_) => setState(() {}),
    ).margin(
      selected.isNotEmpty ? const EdgeInsets.only(top: 12.0) : EdgeInsets.zero,
    );
  }
}
