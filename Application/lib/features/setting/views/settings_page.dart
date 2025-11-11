import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/constants.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/providers.dart';
import 'package:paralelo/core/services.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/plan/exports.dart';
import 'package:paralelo/features/project/exports.dart';
import 'package:paralelo/features/setting/exports.dart';
import 'package:paralelo/features/user/exports.dart';
import 'package:paralelo/widgets/skeleton.dart';
import 'package:paralelo/widgets/skeleton_block.dart';

class SettingsPage extends ConsumerStatefulWidget {
  static const routePath = '/settings';

  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SettingsPageState();
  }
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late final Future<(User, Plan)> loadDataFuture;
  late final PreferencesNotifier preferences;
  late final String userId;

  @override
  void initState() {
    super.initState();

    preferences = ref.read(preferencesProvider.notifier);
    userId = ref.read(authProvider)!.id;

    loadDataFuture = loadData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadDataFuture,
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return skeleton();
        }

        return page(snapshot.data!);
      },
    );
  }

  Widget skeleton() {
    return Skeleton(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.transparent,

        appBar: AppBar(actions: [SkeletonBlock(width: 128.0, height: 24.0)]),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.0,
          children: [
            SizedBox(
              height: 192.0,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12.0,
                children: const [
                  SkeletonBlock(width: 64.0, height: 64.0),
                  SkeletonBlock(width: 256.0, height: 24.0),
                  SkeletonBlock(width: 192.0, height: 16.0),
                ],
              ).center(),
            ),

            ...const [
              SkeletonBlock(width: 128.0, height: 16.0),
              SkeletonBlock(width: double.infinity, height: 24.0),
              SkeletonBlock(width: double.infinity, height: 24.0),

              SizedBox(height: 12.0),

              SkeletonBlock(width: 128.0, height: 16.0),
              SkeletonBlock(width: double.infinity, height: 24.0),
              SkeletonBlock(width: double.infinity, height: 24.0),

              SizedBox(height: 12.0),

              SkeletonBlock(width: 128.0, height: 16.0),
              SkeletonBlock(width: double.infinity, height: 24.0),
              SkeletonBlock(width: double.infinity, height: 24.0),
            ],
          ],
        ).margin(Insets.h16v8),
      ),
    );
  }

  Widget page((User, Plan) data) {
    final currentLocale = ref.read(preferencesProvider).locale;
    final allowNotifications = ref.read(preferencesProvider).notifications;

    final (user, plan) = data;

    return Scaffold(
      key: scaffoldKey,

      body: ListView(
        padding: Insets.a8,
        children: [
          TextButton(
            onPressed: () async {
              await ref.read(authProvider.notifier).signOut();
            },
            child: Text('button.logout'.tr()),
          ).align(Alignment.centerRight),

          SizedBox(
            height: 192.0,

            child: UserPresenter(user: user, plan: plan).center(),
          ),

          const SizedBox(height: 16.0),

          Text(
            'setting.sections.activity'.tr(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ).margin(const EdgeInsets.only(left: 8.0)),
          SettingOption.tile(
            onTap: () async {
              await ref.read(goRouterProvider).push(MyProjectsPage.routePath);
            },

            leading: const Icon(TablerIcons.briefcase_filled),
            title: 'setting.options.published_projects'.tr(),
          ),
          SettingOption.tile(
            onTap: () {},

            leading: const Icon(TablerIcons.file_filled),
            title: 'setting.options.proposals_submitted'.tr(),
          ),
          SettingOption.tile(
            onTap: () async {
              await ref.read(goRouterProvider).push(PlansPage.routePath);
            },

            leading: const Icon(TablerIcons.star_filled),
            title: 'setting.options.benefits_plan'.tr(),
          ),

          const SizedBox(height: 16.0),

          Text(
            'setting.sections.preferences'.tr(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ).margin(const EdgeInsets.only(left: 8.0)),
          SettingOption.tile(
            onTap: () async {
              final newLocale = await showModalBottomSheet<String>(
                context: context,
                isScrollControlled: true,
                builder: (_) {
                  return LocaleSelectorModal(value: currentLocale.languageCode);
                },
              );

              if (newLocale == null) return;

              await updateLocale(newLocale);
            },
            leading: const Icon(TablerIcons.globe_filled),
            trailing: Text(
              currentLocale.languageCode.toUpperCase(),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade400),
            ),
            title: 'setting.options.language'.tr(),
          ),
          SettingOption.toggle(
            value: allowNotifications,
            onChanged: (checked) async {
              if (checked) {
                final granted = await handleNotificationPermission(context);

                if (!granted) return;
              }
            },

            leading: const Icon(TablerIcons.bell_filled),
            title: 'setting.options.notifications'.tr(),
          ),

          const SizedBox(height: 16.0),

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

          const SizedBox(height: 16.0),

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

          Text(
            '${'© 2025 Andorasoft'}\n${'all_rights_reserved'.tr()}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ).margin(const EdgeInsets.only(top: 16.0, bottom: 32.0)),
        ],
      ),
    );
  }

  Future<(User, Plan)> loadData() async {
    final (user, plan) = await (
      ref.read(userProvider).getById(userId),
      ref.read(planProvider).getForUser(userId),
    ).wait;

    return (user!, plan!);
  }

  Future<void> updateLocale(String code) async {
    try {
      preferences.setLocale(code);

      await context.setLocale(Locale(code));
      await ref.read(userPreferenceProvider).update(userId, language: code);
    } catch (e) {
      showSnackbar(context, '');
      debugPrint('$e');
    }
  }

  Future<void> updateNotifications(bool value) async {
    try {
      preferences.setNotifications(value);

      await ref
          .read(userPreferenceProvider)
          .update(userId, notificationsEnabled: value);
    } catch (e) {
      showSnackbar(context, '');
      debugPrint('$e');
    }
  }

  Future<bool> handleNotificationPermission(BuildContext context) async {
    var granted = await FCMService.instance.checkPermission();

    if (!granted) {
      granted = await FCMService.instance.requestPermissions();
    }

    if (!granted) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) {
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
