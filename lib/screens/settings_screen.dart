import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/providers/app_state.dart';
import 'package:mobile_app/l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings!)),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          ListTile(
            title: Text(AppLocalizations.of(context)!.language!),
            trailing: DropdownButton<Locale>(
              value: appState.currentLocale,
              items: const [
                DropdownMenuItem(value: Locale('en'), child: Text('English')),
                DropdownMenuItem(value: Locale('fr'), child: Text('Français')),
              ],
              onChanged: (Locale? newValue) {
                if (newValue != null) {
                  appState.setLocale(newValue);
                }
              },
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.theme!),
            trailing: DropdownButton<ThemeMode>(
              value: appState.currentThemeMode,
              items: [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(AppLocalizations.of(context)!.systemDefault!),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(AppLocalizations.of(context)!.light!),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(AppLocalizations.of(context)!.dark!),
                ),
              ],
              onChanged: (ThemeMode? newValue) {
                if (newValue != null) {
                  appState.setThemeMode(newValue);
                }
              },
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.temperatureUnit!),
            trailing: DropdownButton<String>(
              value: appState.temperatureUnit,
              items: [
                DropdownMenuItem(
                  value: 'Celsius',
                  child: Text(AppLocalizations.of(context)!.celsius!),
                ),
                DropdownMenuItem(
                  value: 'Fahrenheit',
                  child: Text(AppLocalizations.of(context)!.fahrenheit!),
                ),
              ],
              onChanged: (String? newValue) {
                if (newValue != null) {
                  appState.setTemperatureUnit(newValue);
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
