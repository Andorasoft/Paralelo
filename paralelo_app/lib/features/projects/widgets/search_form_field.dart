import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';

class SearchFormField extends ConsumerStatefulWidget {
  final void Function(String)? onQuery;

  const SearchFormField({super.key, required this.onQuery});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SearchFormFieldState();
  }
}

class _SearchFormFieldState extends ConsumerState<SearchFormField> {
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 16.0),
      ),
      leading: Icon(LucideIcons.search),

      hintText: 'Search projects...',
    ).size(height: 48.0);
  }
}
