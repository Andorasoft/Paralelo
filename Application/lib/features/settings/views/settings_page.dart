import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/features/auth/controllers/auth_notifier.dart';
import 'package:paralelo/features/projects/views/my_projects_page.dart';
import 'package:paralelo/features/settings/widgets/setting_option.dart';
import 'package:paralelo/features/user/controllers/app_user_provider.dart';
import 'package:paralelo/features/user/models/app_user.dart';
import 'package:paralelo/features/user/widgets/user_presenter.dart';
import 'package:paralelo/widgets/loading_indicator.dart';
import 'package:paralelo/core/providers.dart';
import 'package:paralelo/core/services.dart';

class SettingsPage extends ConsumerStatefulWidget {
  static const routeName = 'SettingsPage';
  static const routePath = '/settings';

  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return SettingsPageState();
  }
}

class SettingsPageState extends ConsumerState<SettingsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late final Future<AppUser> _loadDataFuture;

  @override
  void initState() {
    super.initState();

    _loadDataFuture = _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeNotifierProvider);
    final notify = ref.watch(notifyNotifierProvider);

    return Scaffold(
      key: _scaffoldKey,

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: Column(
          spacing: 16.0,

          children: [
            TextButton(
              onPressed: () async {
                await ref.read(authProvider.notifier).logout();
              },
              child: const Text('Cerrar sesión'),
            ).align(AlignmentGeometry.centerRight),

            SizedBox(
              height: 192.0,

              child: FutureBuilder(
                future: _loadDataFuture,

                builder: (_, snapshot) {
                  if (!snapshot.hasData) {
                    return const LoadingIndicator(showMessage: false).center();
                  }

                  final user = snapshot.data!;

                  return UserPresenter(
                    pictureUrl: user.pictureUrl!,
                    name: '${user.firstName} ${user.lastName}',
                    email: user.email,
                  ).center();
                },
              ),
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                Text(
                  'Actividad',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ).margin(const EdgeInsets.only(left: 8.0)),
                SettingOption.tile(
                  onTap: () async {
                    await ref
                        .read(goRouterProvider)
                        .push(MyProjectsPage.routePath);
                  },

                  leading: const Icon(TablerIcons.user_circle),
                  title: 'Mis proyectos',
                ),
                SettingOption.tile(
                  onTap: () {},

                  leading: const Icon(TablerIcons.user_circle),
                  title: 'Mis propuestas',
                ),
              ],
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                Text(
                  'Preferencias',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ).margin(const EdgeInsets.only(left: 8.0)),
                SettingOption.tile(
                  onTap: () {},

                  leading: const Icon(TablerIcons.globe_filled),
                  trailing: Text(
                    'ES',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  title: 'Idioma',
                ),
                SettingOption.toggle(
                  value: notify,

                  onChanged: (v) async {
                    var granted = await FCMService.instance.checkPermission();

                    if (!granted) {
                      granted = await FCMService.instance.requestPermissions();

                      if (!granted) return;
                    }

                    ref.read(notifyNotifierProvider.notifier).setNotify(v);
                  },

                  leading: const Icon(TablerIcons.bell_filled),
                  title: 'Notificaciones',
                ),
                SettingOption.toggle(
                  value: theme == ThemeMode.dark,
                  onChanged: (v) {
                    ref
                        .read(themeNotifierProvider.notifier)
                        .setTheme(v ? ThemeMode.dark : ThemeMode.light);
                  },

                  leading: const Icon(TablerIcons.moon_filled),
                  title: 'Modo oscuro',
                ),
              ],
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                Text(
                  'Cuenta',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ).margin(const EdgeInsets.only(left: 12.0)),
                SettingOption.tile(
                  onTap: () {},

                  leading: const Icon(TablerIcons.lock_filled),
                  title: 'Cambiar contraseña',
                ),
                SettingOption.tile(
                  onTap: () {},

                  leading: const Icon(TablerIcons.trash_filled),
                  title: 'Eliminar mi cuenta',
                ),
              ],
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                Text(
                  'Soporte',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ).margin(const EdgeInsets.only(left: 12.0)),
                SettingOption.tile(
                  onTap: () {},

                  leading: const Icon(TablerIcons.info_circle_filled),
                  title: 'Centro de ayuda',
                ),
                SettingOption.tile(
                  onTap: () {},

                  leading: const Icon(TablerIcons.message_filled),
                  title: 'Contáctanos',
                ),
              ],
            ),

            Text.rich(
              textAlign: TextAlign.center,

              TextSpan(
                children: [
                  TextSpan(text: '© 2025 Andorasoft\n'),
                  TextSpan(text: 'Todos los derechos reservados'),
                ],

                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ).margin(const EdgeInsets.only(top: 16.0, bottom: 32.0)),
          ],
        ).margin(const EdgeInsets.all(8.0)),
      ),
    );
  }

  Future<AppUser> _loadData() async {
    final userId = ref.read(authProvider)!.id;

    return (await ref.read(appUserProvider).getById(userId))!;
  }
}
