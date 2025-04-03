import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // For accessing application-wide state.
import 'package:mobile_app/providers/app_state.dart'; // Provides and manages the application's global state.
import 'package:mobile_app/l10n/app_localizations.dart'; // Provides localized strings for the UI.

// Allows users to configure various application settings.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(
      context,
    ); // Accesses the application state.

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings!),
      ), // AppBar with the localized title for the settings screen.
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          // Setting to change the application language.
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.language!,
            ), // Localized title for the language setting.
            trailing: DropdownButton<Locale>(
              value:
                  appState
                      .currentLocale, // The currently selected locale from the application state.
              items: const [
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text('English'),
                ), // English language option.
                DropdownMenuItem(
                  value: Locale('fr'),
                  child: Text('Français'),
                ), // French language option.
              ],
              onChanged: (Locale? newValue) {
                if (newValue != null) {
                  appState.setLocale(
                    newValue,
                  ); // Updates the application's locale in the AppState.
                }
              },
            ),
          ),
          // Setting to change the application theme.
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.theme!,
            ), // Localized title for the theme setting.
            trailing: DropdownButton<ThemeMode>(
              value:
                  appState
                      .currentThemeMode, // The currently selected theme mode from the application state.
              items: [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(
                    AppLocalizations.of(context)!.systemDefault!,
                  ), // Localized "System Default" theme option.
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(
                    AppLocalizations.of(context)!.light!,
                  ), // Localized "Light" theme option.
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(
                    AppLocalizations.of(context)!.dark!,
                  ), // Localized "Dark" theme option.
                ),
              ],
              onChanged: (ThemeMode? newValue) {
                if (newValue != null) {
                  appState.setThemeMode(
                    newValue,
                  ); // Updates the application's theme mode in the AppState.
                }
              },
            ),
          ),
          // Setting to change the preferred temperature unit.
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.temperatureUnit!,
            ), // Localized title for the temperature unit setting.
            trailing: DropdownButton<String>(
              value:
                  appState
                      .temperatureUnit, // The currently selected temperature unit from the application state.
              items: [
                DropdownMenuItem(
                  value: 'Celsius',
                  child: Text(
                    AppLocalizations.of(context)!.celsius!,
                  ), // Localized "Celsius" option.
                ),
                DropdownMenuItem(
                  value: 'Fahrenheit',
                  child: Text(
                    AppLocalizations.of(context)!.fahrenheit!,
                  ), // Localized "Fahrenheit" option.
                ),
              ],
              onChanged: (String? newValue) {
                if (newValue != null) {
                  appState.setTemperatureUnit(
                    newValue,
                  ); // Updates the preferred temperature unit in the AppState.
                }
              },
            ),
          ),
          // Add more settings options here
        ],
      ),
    );
  }
}
