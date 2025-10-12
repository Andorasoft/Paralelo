import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './services.dart';

final messagesProvider =
    StreamProvider.family<List<Map<String, dynamic>>, String>((_, roomId) {
      return ChatService.messagesStream(roomId);
    });

final themeNotifierProvider = StateNotifierProvider((_) {
  return ThemeStateNotifier().._loadTheme();
});

final localeNotifierProvider = StateNotifierProvider((_) {
  return LocaleStateNotifier().._loadLocale();
});

final notifyNotifierProvider = StateNotifierProvider((_) {
  return NotificationStateNotifier().._loadNotification();
});

class ThemeStateNotifier extends StateNotifier<ThemeMode> {
  final kThemeModeKey = '__theme_mode__';

  late final SharedPreferences _prefs;

  ThemeStateNotifier() : super(ThemeMode.light);

  void _loadTheme() async {
    _prefs = await SharedPreferences.getInstance();

    final isDark = _prefs.getBool(kThemeModeKey);

    if (isDark == null) return;

    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void setTheme(ThemeMode mode) {
    if (mode == ThemeMode.system) {
      _prefs.remove(kThemeModeKey);
    } else {
      _prefs.setBool(kThemeModeKey, mode == ThemeMode.dark);
    }

    state = mode;
  }

  ThemeMode getTheme() {
    return state;
  }
}

class LocaleStateNotifier extends StateNotifier<Locale> {
  final kLocaleModeKey = '__locale_mode__';

  late final SharedPreferences _prefs;

  LocaleStateNotifier() : super(const Locale('es'));

  void _loadLocale() async {
    _prefs = await SharedPreferences.getInstance();

    final code = _prefs.getString(kLocaleModeKey);

    if (code == null) return;

    state = Locale(code);
  }

  void setLocale(String code) {
    _prefs.setString(kLocaleModeKey, code);
    state = Locale(code);
  }

  Locale getLocale() {
    return state;
  }
}

class NotificationStateNotifier extends StateNotifier<bool> {
  final kNotificationKey = '__notification_enabled__';

  late final SharedPreferences _prefs;

  NotificationStateNotifier() : super(false);

  void _loadNotification() async {
    _prefs = await SharedPreferences.getInstance();

    final notify = _prefs.getBool(kNotificationKey);

    if (notify == null) return;

    state = notify;
  }

  void setNotify(bool enabled) {
    _prefs.setBool(kNotificationKey, enabled);
    state = enabled;
  }

  bool getNotify() {
    return state;
  }
}
