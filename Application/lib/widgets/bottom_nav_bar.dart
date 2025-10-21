import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/settings/views/settings_page.dart';
import 'package:paralelo/features/chats/views/chats_page.dart';
import 'package:paralelo/features/home/views/home_page.dart';
import 'package:paralelo/features/projects/views/create_project_page.dart';
import 'package:paralelo/features/projects/views/marketplace_page.dart';
import 'package:paralelo/core/router.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Theme(
      data: Theme.of(
        context,
      ).copyWith(scaffoldBackgroundColor: Colors.transparent),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),

        child: BottomNavBarWidget(
          onTap: (index) {},

          height: 56.0,
          showLabels: false,
          extendContent: true,

          backgroundGradient: const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Color(0xFFF7F6FA), Colors.white],
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await ref
                  .read(goRouterProvider)
                  .push(CreateProjectPage.routePath);
            },
            highlightElevation: 0.0,
            elevation: 2.0,

            child: const Icon(TablerIcons.plus),
          ),

          items: [
            BottomNavBarItem(
              label: 'nav.home'.tr(),
              icon: const Icon(TablerIcons.smart_home, size: 28.0),
              page: const HomePage(),
            ),
            BottomNavBarItem(
              label: 'nav.search'.tr(),
              icon: const Icon(TablerIcons.search, size: 28.0),
              page: const MarketplacePage(),
            ),
            BottomNavBarItem(
              label: 'nav.chats'.tr(),
              icon: Badge(
                isLabelVisible: false,
                backgroundColor: Theme.of(context).colorScheme.primary,

                child: const Icon(TablerIcons.message_2, size: 28.0),
              ),
              page: const ChatsPage(),
            ),
            BottomNavBarItem(
              label: 'nav.account'.tr(),
              icon: const Icon(TablerIcons.user_circle, size: 28.0),
              page: const SettingsPage(),
            ),
          ],
        ),
      ),
    );
  }
}
