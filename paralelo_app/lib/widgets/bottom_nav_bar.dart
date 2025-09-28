import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/features/calendar/views/calendar_page.dart';
import 'package:paralelo/features/chats/views/chats_page.dart';
import 'package:paralelo/features/home/views/home_page.dart';
import 'package:paralelo/features/projects/views/add_project_page.dart';
import 'package:paralelo/features/projects/views/marketplace_page.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Theme(
      data: Theme.of(
        context,
      ).copyWith(scaffoldBackgroundColor: Colors.transparent),
      child: BottomNavBarWidget(
        onTap: (index) {},
        showLabels: false,
        extendContent: true,
        backgroundGradient: const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Color(0xFFF7F6FA), Colors.white],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await ref.read(goRouterProvider).push(AddProjectPage.routePath);
          },
          highlightElevation: 0.0,
          elevation: 2.0,

          child: Icon(TablerIcons.plus),
        ),

        items: [
          BottomNavBarItem(
            label: 'Inicio',
            icon: Icon(TablerIcons.smart_home, size: 28.0),
            page: const HomePage(),
          ),
          BottomNavBarItem(
            label: 'Buscar',
            icon: Icon(TablerIcons.search, size: 28.0),
            page: const MarketplacePage(),
          ),
          BottomNavBarItem(
            label: 'Chats',
            icon: Icon(TablerIcons.message_2, size: 28.0),
            page: const ChatsPage(),
          ),
          BottomNavBarItem(
            label: 'Agenda',
            icon: Icon(TablerIcons.calendar_week, size: 28.0),
            page: const CalendarPage(),
          ),
        ],
      ),
    );
  }
}
