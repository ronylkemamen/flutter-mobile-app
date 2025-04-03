import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState with ChangeNotifier {
  Locale _currentLocale = const Locale('en');
  ThemeMode _currentThemeMode = ThemeMode.system;
  String _temperatureUnit = 'Celsius';

  Locale get currentLocale => _currentLocale;
  ThemeMode get currentThemeMode => _currentThemeMode;
  String get temperatureUnit => _temperatureUnit;

  AppState() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('languageCode');
    if (languageCode != null) {
      _currentLocale = Locale(languageCode);
    } else {
      final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
      if (deviceLocale.languageCode == 'fr') {
        _currentLocale = const Locale('fr');
      } else {
        _currentLocale = const Locale('en');
      }
    }

    final themeIndex = prefs.getInt('themeMode') ?? 0;
    _currentThemeMode = ThemeMode.values[themeIndex];

    _temperatureUnit = prefs.getString('temperatureUnit') ?? 'Celsius';

    notifyListeners();
  }

  Future<void> setLocale(Locale newLocale) async {
    _currentLocale = newLocale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', newLocale.languageCode);
  }

  Future<void> setThemeMode(ThemeMode newThemeMode) async {
    _currentThemeMode = newThemeMode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', newThemeMode.index);
  }

  Future<void> setTemperatureUnit(String newUnit) async {
    _temperatureUnit = newUnit;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('temperatureUnit', newUnit);
    // TODO: Implement saving this to the server attribute
    print('Saving temperature unit to server: $newUnit');
  }
}
