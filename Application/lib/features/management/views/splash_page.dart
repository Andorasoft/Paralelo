import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/modals.dart';
import 'package:paralelo/core/providers.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/core/services.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/university/exports.dart';
import 'package:paralelo/features/user/exports.dart';
import 'package:paralelo/utils/formatters.dart';
import '../widgets/animated_logo.dart';

class SplashPage extends ConsumerStatefulWidget {
  static const routeName = 'SplashPage';
  static const routePath = '/splash';

  const SplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends ConsumerState<SplashPage> {
  late final String userId, userEmail;

  @override
  void initState() {
    super.initState();

    userId = ref.read(authProvider)!.id;
    userEmail = ref.read(authProvider)!.email;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var (user, prefs, uni) = await loadData();
      final preferences = ref.read(preferencesProvider.notifier);

      if (uni == null) {
        await showUserNotAllowedDialog(context, ref: ref);
        return;
      }

      prefs ??= await ref.read(userPreferenceProvider).create(userId: userId);

      final token = await FCMService.instance.getDeviceToken();

      if (user.deviceToken != token) {
        user = (await ref
            .read(userProvider)
            .update(user.id, deviceToken: token))!;
      }

      preferences.setLocale(prefs.language);
      preferences.setTheme(prefs.darkMode ? ThemeMode.dark : ThemeMode.light);
      preferences.setNotifications(prefs.notificationsEnabled);

      await context.setLocale(Locale(prefs.language));
      await ref.read(goRouterProvider).pushReplacement('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),

      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,

        body: const AnimatedLogo(),
      ),
    );
  }

  Future<(User, UserPreference?, University?)> loadData() async {
    final (user, prefs, uni) = await (
      ref.read(userProvider).getById(userId),
      ref.read(userPreferenceProvider).getForUser(userId),
      ref.read(universityProvider).getByDomain(userEmail.extractDomain()),
    ).wait;

    return (user!, prefs, uni);
  }
}
