import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/exceptions.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/providers.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/core/services.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/management/exports.dart';
import 'package:paralelo/features/user/exports.dart';
import 'package:paralelo/utils/extensions.dart';
import 'package:paralelo/utils/helpers.dart';

class SplashPage extends ConsumerStatefulWidget {
  static const routePath = '/splash';

  const SplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends ConsumerState<SplashPage> {
  bool maintenanceMode = false, needUpdate = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final updated = await check();
      if (updated) await setup();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),

      child: page(),
    );
  }

  Widget page() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AnimatedLogo(animated: !maintenanceMode && !needUpdate),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 4.0,
            children: [
              if (maintenanceMode) ...[
                Text(
                  'Estamos en mantenimiento',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Volveremos pronto con una mejor experiencia. Gracias por tu paciencia.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                FilledButton.tonal(
                  onPressed: () {},
                  child: const Text('Cerrar aplicación'),
                ).margin(Insets.a16),
              ] else if (needUpdate) ...[
                Text(
                  'Actualización disponible',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Por favor, actualiza Paralelo para seguir usando todas las funciones.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                FilledButton(
                  onPressed: () {},
                  child: const Text('Actualizar ahora'),
                ).margin(Insets.a16),
              ],
            ],
          ).margin(Insets.h16v8),
        ],
      ).useSafeArea(),
    );
  }

  Future<(User?, UserPreference?)> loadData() {
    final userId = ref.read(authProvider)?.id ?? '';

    if (userId.isEmpty) return Future.value((null, null));

    return (
      ref.read(userProvider).getById(userId),
      ref.read(userPreferenceProvider).getForUser(userId),
    ).wait;
  }

  Future<bool> check() async {
    try {
      final platform = isAndroid ? 'Android' : 'iOS';
      final app = await ref.read(applicationProvider).getByPlatform(platform);

      if (app == null) throw NotFoundException('Aplicación no encontrada');

      final info = await PackageInfo.fromPlatform();

      // comparation returns -1 if app.minVersion < info.version
      final comparation = compareVersions(info.version, app.minVersion);

      // Maintenance mode
      if (app.maintenanceMode) {
        safeSetState(() => maintenanceMode = true);
        return false;
      }

      // Needs update
      if (comparation == -1 || app.forceUpdate) {
        safeSetState(() => needUpdate = true);
        return false;
      }

      return true;
    } on NotFoundException catch (e) {
      showSnackbar(context, e.message);
      return false;
    } catch (e) {
      debugPrint('Error en `check()`: $e');
      return false;
    }
  }

  Future<void> setup() async {
    final router = ref.read(goRouterProvider);

    try {
      // Load user and remote preferences
      final (user, remotePrefs) = await loadData();

      if (user == null || remotePrefs == null) {
        await router.pushReplacement('/sign-in');
        return;
      }

      final prefsNotifier = ref.read(preferencesProvider.notifier);
      final fcmToken = await FCMService.instance.getDeviceToken();

      // Update device token only if necessary
      if (user.deviceToken != fcmToken && (fcmToken ?? '').isNotEmpty) {
        await ref.read(userProvider).update(user.id, deviceToken: fcmToken);
      }

      // Apply remote preferences locally
      prefsNotifier
        ..setLocale(remotePrefs.language)
        ..setTheme(remotePrefs.darkMode ? ThemeMode.dark : ThemeMode.light)
        ..setNotifications(remotePrefs.notificationsEnabled);

      // Apply locale immediately in UI
      await context.setLocale(Locale(remotePrefs.language));

      // Navigate to main route after setup
      router.pushReplacement('/');
    } catch (e) {
      debugPrint('Error en `setup()`: $e');
    }
  }
}
