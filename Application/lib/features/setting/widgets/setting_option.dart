import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SettingOption extends ConsumerStatefulWidget {
  final void Function()? onTap;
  final void Function(bool)? onChanged;

  final Widget? leading;
  final Widget? trailing;

  final String title;
  final bool value;

  const SettingOption.tile({
    super.key,
    required this.onTap,
    required this.title,
    this.leading,
    this.trailing,
  }) : onChanged = null,
       value = false;

  const SettingOption.toggle({
    super.key,
    required this.onChanged,
    required this.title,
    required this.value,
    this.leading,
    this.trailing,
  }) : onTap = null;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return SettingOptionState();
  }
}

class SettingOptionState extends ConsumerState<SettingOption> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        widget.onTap?.call();
      },

      minTileHeight: 44.0,
      visualDensity: VisualDensity.compact,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12.0),
      ),

      leading: widget.leading != null
          ? Container(
              padding: const EdgeInsets.all(4.0),
              width: 28.0,
              height: 28.0,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  iconTheme: IconThemeData(
                    size: 20.0,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                child: widget.leading!,
              ),
            )
          : null,
      title: Text(widget.title, style: Theme.of(context).textTheme.bodyMedium),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 4.0,

        children: [
          if (widget.trailing != null) widget.trailing!,

          widget.onChanged != null
              ? Switch.adaptive(
                  value: widget.value,
                  activeTrackColor: Theme.of(context).colorScheme.primary,
                  onChanged: (v) {
                    widget.onChanged?.call(v);
                  },
                )
              : Icon(
                  LucideIcons.chevronRight,
                  size: 20.0,
                  color: Colors.grey.shade400,
                ),
        ],
      ),
    );
  }
}
