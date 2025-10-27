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
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final (_, prefs, _) = await loadData();
      final notifier = ref.read(preferencesProvider.notifier);

      if (prefs == null) {
        await showUserNotAllowedDialog(context, ref: ref);
        return;
      }

      notifier.setLocale(prefs.language);
      notifier.setTheme(prefs.darkMode ? ThemeMode.dark : ThemeMode.light);
      notifier.setNotifications(prefs.notificationsEnabled);

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

  Future<(User?, UserPreference?, University?)> loadData() async {
    final authUser = ref.read(authProvider)!;
    final userRepo = ref.read(userProvider);
    final uniRepo = ref.read(universityProvider);
    final prefRepo = ref.read(userPreferenceProvider);

    var (user, prefs, uni) = await (
      userRepo.getById(authUser.id),
      prefRepo.getForUser(authUser.id),
      uniRepo.getByDomain(authUser.email.extractDomain()),
    ).wait;

    if (uni == null) return (null, null, null);

    user ??= await userRepo.create(
      id: authUser.id,
      displayName: 'Usuario sin nombre',
      email: authUser.email,
      pictureUrl: authUser.pictureUrl,
      planId: 1,
      universityId: uni.id,
    );

    prefs ??= await prefRepo.create(userId: authUser.id);

    final token = await FCMService.instance.getDeviceToken();

    if (user.deviceToken != token) {
      user = await userRepo.update(user.id, deviceToken: token);
    }

    return (user, prefs, uni);
  }
}
