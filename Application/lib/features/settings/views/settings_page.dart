import 'package:app_settings/app_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/features/auth/controllers/auth_notifier.dart';
import 'package:paralelo/features/projects/views/my_projects_page.dart';
import 'package:paralelo/features/settings/widgets/setting_option.dart';
import 'package:paralelo/features/user/controllers/app_user_provider.dart';
import 'package:paralelo/features/user/models/app_user.dart';
import 'package:paralelo/features/user/widgets/user_presenter.dart';
import 'package:paralelo/widgets/loading_indicator.dart';
import 'package:paralelo/core/providers.dart';
import 'package:paralelo/core/services.dart';
import 'package:paralelo/core/modals.dart';
import 'package:paralelo/core/router.dart';

class SettingsPage extends ConsumerStatefulWidget {
  static const routeName = 'settingPage';
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
              child: Text('button.logout'.tr()),
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
                  'setting.sections.activity'.tr(),
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

                  leading: const Icon(TablerIcons.briefcase_filled),
                  title: 'setting.options.my_projects'.tr(),
                ),
                SettingOption.tile(
                  onTap: () {},

                  leading: const Icon(TablerIcons.file_filled),
                  title: 'setting.options.my_proposals'.tr(),
                ),
                SettingOption.tile(
                  onTap: () {},

                  leading: const Icon(TablerIcons.star_filled),
                  title: 'setting.options.my_skills'.tr(),
                ),
              ],
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                Text(
                  'setting.sections.preferences'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ).margin(const EdgeInsets.only(left: 8.0)),
                SettingOption.tile(
                  onTap: () async {
                    final notifier = ref.read(localeNotifierProvider.notifier);

                    final locale = await showLocaleSelectorModalBottomSheet(
                      context,
                      value: notifier.getLocale().languageCode,
                    );

                    if (locale == null) return;

                    notifier.setLocale(locale);
                    await context.setLocale(notifier.getLocale());
                  },

                  leading: const Icon(TablerIcons.globe_filled),
                  trailing: Text(
                    ref
                        .read(localeNotifierProvider.notifier)
                        .getLocale()
                        .languageCode
                        .toUpperCase(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  title: 'setting.options.language'.tr(),
                ),
                SettingOption.toggle(
                  value: notify,

                  onChanged: (v) async {
                    final granted = await _handleNotificationPermission(
                      context,
                    );

                    if (!granted) return;

                    ref.read(notifyNotifierProvider.notifier).setNotify(v);
                  },

                  leading: const Icon(TablerIcons.bell_filled),
                  title: 'setting.options.notifications'.tr(),
                ),
                SettingOption.toggle(
                  value: theme == ThemeMode.dark,
                  onChanged: (v) {
                    ref
                        .read(themeNotifierProvider.notifier)
                        .setTheme(v ? ThemeMode.dark : ThemeMode.light);
                  },

                  leading: const Icon(TablerIcons.moon_filled),
                  title: 'setting.options.dark_mode'.tr(),
                ),
              ],
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                Text(
                  'setting.sections.account'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ).margin(const EdgeInsets.only(left: 12.0)),
                SettingOption.tile(
                  onTap: () {},

                  leading: const Icon(TablerIcons.lock_filled),
                  title: 'setting.options.change_password'.tr(),
                ),
                SettingOption.tile(
                  onTap: () {},

                  leading: const Icon(TablerIcons.trash_filled),
                  title: 'setting.options.delete_account'.tr(),
                ),
              ],
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                Text(
                  'setting.sections.support'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ).margin(const EdgeInsets.only(left: 12.0)),
                SettingOption.tile(
                  onTap: () {},

                  leading: const Icon(TablerIcons.info_circle_filled),
                  title: 'setting.options.help_center'.tr(),
                ),
                SettingOption.tile(
                  onTap: () {},

                  leading: const Icon(TablerIcons.message_filled),
                  title: 'setting.options.contact_us'.tr(),
                ),
              ],
            ),

            Text.rich(
              textAlign: TextAlign.center,

              TextSpan(
                children: [
                  const TextSpan(text: '© 2025 Andorasoft\n'),
                  TextSpan(text: 'all_rights_reserved'.tr()),
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

  Future<bool> _handleNotificationPermission(BuildContext context) async {
    var granted = await FCMService.instance.checkPermission();

    if (!granted) {
      granted = await FCMService.instance.requestPermissions();
    }

    if (!granted) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,

        builder: (ctx) {
          return AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),

            title: Text('modal.notification.title'.tr()),

            content: Text('modal.notification.content'.tr()),

            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                child: Text('button.cancel'.tr()),
              ),
              TextButton(
                onPressed: () async {
                  await AppSettings.openAppSettings();
                  Navigator.pop(context, true);
                },

                child: Text('button.open_settings'.tr()),
              ),
            ],
          );
        },
      );
    }

    return granted;
  }
}
