import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Provides persistent storage for simple data.

// Manages the global state of the application, including locale, theme, and temperature unit.
class AppState with ChangeNotifier {
  Locale _currentLocale = const Locale(
    'en',
  ); // The currently selected locale, defaults to English.
  ThemeMode _currentThemeMode =
      ThemeMode
          .system; // The currently selected theme mode, defaults to system default.
  String _temperatureUnit =
      'Celsius'; // The currently selected temperature unit, defaults to Celsius.

  // Getter for the current locale.
  Locale get currentLocale => _currentLocale;
  // Getter for the current theme mode.
  ThemeMode get currentThemeMode => _currentThemeMode;
  // Getter for the current temperature unit.
  String get temperatureUnit => _temperatureUnit;

  // Constructor for AppState.
  AppState() {
    _loadSettings(); // Loads saved settings when the app state is initialized.
  }

  // Loads application settings from persistent storage (SharedPreferences).
  Future<void> _loadSettings() async {
    final prefs =
        await SharedPreferences.getInstance(); // Gets the SharedPreferences instance.

    // Load the language code. If not found, default to device locale or English.
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

    // Load the theme mode. Defaults to system if not found.
    final themeIndex = prefs.getInt('themeMode') ?? 0;
    _currentThemeMode = ThemeMode.values[themeIndex];

    // Load the temperature unit. Defaults to Celsius if not found.
    _temperatureUnit = prefs.getString('temperatureUnit') ?? 'Celsius';

    notifyListeners(); // Notifies all listeners (widgets) that the state has changed.
  }

  // Sets the application's locale and saves it to persistent storage.
  Future<void> setLocale(Locale newLocale) async {
    _currentLocale = newLocale;
    notifyListeners(); // Notifies listeners about the locale change.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'languageCode',
      newLocale.languageCode,
    ); // Saves the new locale code.
  }

  // Sets the application's theme mode and saves it to persistent storage.
  Future<void> setThemeMode(ThemeMode newThemeMode) async {
    _currentThemeMode = newThemeMode;
    notifyListeners(); // Notifies listeners about the theme mode change.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
      'themeMode',
      newThemeMode.index,
    ); // Saves the index of the new theme mode.
  }

  // Sets the preferred temperature unit and saves it to persistent storage.
  Future<void> setTemperatureUnit(String newUnit) async {
    _temperatureUnit = newUnit;
    notifyListeners(); // Notifies listeners about the temperature unit change.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'temperatureUnit',
      newUnit,
    ); // Saves the new temperature unit.
    // TODO: Implement saving this to the server attribute
    print('Saving temperature unit to server: $newUnit');
  }
}
