import 'package:paralelo/core/imports.dart';
import 'services.dart';

final messagesProvider =
    StreamProvider.family<List<Map<String, dynamic>>, String>((_, roomId) {
      return ChatService.instance.messagesStream(roomId);
    });

final unreadProvider = StreamProvider.family<Map<String, dynamic>?, String>((
  _,
  roomId,
) {
  return ChatService.instance.unreadStream(roomId);
});

final preferencesProvider =
    StateNotifierProvider<PreferencesNotifier, PreferencesState>(
      (ref) => PreferencesNotifier(),
    );

class PreferencesState {
  final ThemeMode theme;
  final Locale locale;
  final bool notifications;

  const PreferencesState({
    required this.theme,
    required this.locale,
    required this.notifications,
  });
}

class PreferencesNotifier extends StateNotifier<PreferencesState> {
  static const _kThemeKey = '__theme_mode__';
  static const _kLocaleKey = '__locale_mode__';
  static const _kNotifKey = '__notifications_enabled__';

  late final SharedPreferences _prefs;

  PreferencesNotifier()
    : super(
        const PreferencesState(
          theme: ThemeMode.light,
          locale: Locale('es'),
          notifications: false,
        ),
      ) {
    _init();
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();

    final isDark = _prefs.getBool(_kThemeKey);
    final lang = _prefs.getString(_kLocaleKey);
    final notif = _prefs.getBool(_kNotifKey);

    state = PreferencesState(
      theme: isDark == null
          ? ThemeMode.light
          : (isDark ? ThemeMode.dark : ThemeMode.light),
      locale: Locale(lang ?? 'es'),
      notifications: notif ?? false,
    );
  }

  void setTheme(ThemeMode mode) {
    _prefs.setBool(_kThemeKey, mode == ThemeMode.dark);
    state = PreferencesState(
      theme: mode,
      locale: state.locale,
      notifications: state.notifications,
    );
  }

  void setLocale(String code) {
    _prefs.setString(_kLocaleKey, code);
    state = PreferencesState(
      theme: state.theme,
      locale: Locale(code),
      notifications: state.notifications,
    );
  }

  void setNotifications(bool enabled) {
    _prefs.setBool(_kNotifKey, enabled);
    state = PreferencesState(
      theme: state.theme,
      locale: state.locale,
      notifications: enabled,
    );
  }
}
