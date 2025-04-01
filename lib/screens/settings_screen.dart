import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _language = 'English';
  ThemeMode _themeMode = ThemeMode.system;
  String _temperatureUnit = 'Celsius';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          ListTile(
            title: const Text('Language'),
            trailing: DropdownButton<String>(
              value: _language,
              items:
                  <String>['English', 'French']
                      .map(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _language = newValue!;
                  // TODO: Implement language change logic
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Theme'),
            trailing: DropdownButton<ThemeMode>(
              value: _themeMode,
              items: const <DropdownMenuItem<ThemeMode>>[
                DropdownMenuItem<ThemeMode>(
                  value: ThemeMode.system,
                  child: Text('System Default'),
                ),
                DropdownMenuItem<ThemeMode>(
                  value: ThemeMode.light,
                  child: Text('Light'),
                ),
                DropdownMenuItem<ThemeMode>(
                  value: ThemeMode.dark,
                  child: Text('Dark'),
                ),
              ],
              onChanged: (ThemeMode? newValue) {
                setState(() {
                  _themeMode = newValue!;
                  // TODO: Implement theme change logic (might require a Provider or similar)
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Temperature Unit'),
            trailing: DropdownButton<String>(
              value: _temperatureUnit,
              items:
                  <String>['Celsius', 'Fahrenheit']
                      .map(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _temperatureUnit = newValue!;
                  // TODO: Implement temperature unit change logic (and save to server attribute)
                });
              },
            ),
          ),
          // Add more settings options here
        ],
      ),
    );
  }
}
