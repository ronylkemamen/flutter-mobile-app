import 'package:flutter/material.dart';
import 'package:mobile_app/l10n/app_localizations.dart'; // Provides localized strings for the UI.
import 'package:mobile_app/providers/app_state.dart'; // Provides access to the application's global state.
import 'package:mobile_app/screens/telemetry_history_screen.dart'; // Navigates to the telemetry history screen.
import 'package:provider/provider.dart'; // For accessing and listening to changes in the application state.

// Displays the details of a temperature sensor device.
class TemperatureSensorDetailsScreen extends StatefulWidget {
  final Map<String, dynamic>
  thing; // The data representing the temperature sensor device.

  const TemperatureSensorDetailsScreen({super.key, required this.thing});

  @override
  State<TemperatureSensorDetailsScreen> createState() =>
      _TemperatureSensorDetailsScreenState();
}

class _TemperatureSensorDetailsScreenState
    extends State<TemperatureSensorDetailsScreen> {
  String _refreshRateKey =
      '5 seconds'; // Stores the key for the currently selected refresh rate.

  // Defines the available refresh rate options with their localized labels.
  Map<String, String> get _refreshRateOptions => {
    'manual':
        AppLocalizations.of(context)!.manual!, // Localized "Manual" option.
    '5 seconds':
        '5 ${AppLocalizations.of(context)!.seconds!}', // Localized "5 seconds" option.
    '10 seconds':
        '10 ${AppLocalizations.of(context)!.seconds!}', // Localized "10 seconds" option.
    '30 seconds':
        '30 ${AppLocalizations.of(context)!.seconds!}', // Localized "30 seconds" option.
  };

  // Extracts client attributes from the device data.
  Map<String, String> get _clientAttributes =>
      (widget.thing['clientAttributes'] as Map<String, dynamic>)
          .cast<String, String>() ??
      {};
  // Extracts server attributes from the device data.
  Map<String, String> get _serverAttributes =>
      (widget.thing['serverAttributes'] as Map<String, dynamic>)
          .cast<String, String>() ??
      {};
  // Extracts telemetry data from the device data.
  Map<String, String> get _telemetryData =>
      (widget.thing['telemetryData'] as Map<String, dynamic>)
          .cast<String, String>() ??
      {};

  @override
  Widget build(BuildContext context) => Consumer<AppState>(
    builder: (context, appState, child) {
      final currentUnit =
          appState
              .temperatureUnit; // Retrieves the user's preferred temperature unit.
      final temperatureValue =
          _telemetryData['temperature'] ??
          'N/A'; // Gets the current temperature reading.
      String displayedTemperature =
          temperatureValue; // Stores the temperature value to be displayed.

      // Converts the temperature value to the user's preferred unit if necessary.
      if (temperatureValue != 'N/A') {
        try {
          if (currentUnit == 'Fahrenheit' && temperatureValue.endsWith(' °C')) {
            final celsius = double.parse(
              temperatureValue.replaceAll(' °C', ''),
            );
            final fahrenheit = (celsius * 9 / 5) + 32;
            displayedTemperature = '${fahrenheit.toStringAsFixed(1)} °F';
          } else if (currentUnit == 'Celsius' &&
              temperatureValue.endsWith(' °F')) {
            final fahrenheit = double.parse(
              temperatureValue.replaceAll(' °F', ''),
            );
            final celsius = (fahrenheit - 32) * 5 / 9;
            displayedTemperature = '${celsius.toStringAsFixed(1)} °C';
          } else if (currentUnit == 'Fahrenheit' &&
              temperatureValue.contains('°C')) {
            final celsius = double.parse(
              temperatureValue.split('°C')[0].trim(),
            );
            final fahrenheit = (celsius * 9 / 5) + 32;
            displayedTemperature = '${fahrenheit.toStringAsFixed(1)} °F';
          } else if (currentUnit == 'Celsius' &&
              temperatureValue.contains('°F')) {
            final fahrenheit = double.parse(
              temperatureValue.split('°F')[0].trim(),
            );
            final celsius = (fahrenheit - 32) * 5 / 9;
            displayedTemperature = '${celsius.toStringAsFixed(1)} °C';
          } else if (currentUnit == 'Fahrenheit' &&
              temperatureValue.isNotEmpty &&
              double.tryParse(temperatureValue.replaceAll('°C', '').trim()) !=
                  null) {
            final celsius = double.parse(
              temperatureValue.replaceAll('°C', '').trim(),
            );
            final fahrenheit = (celsius * 9 / 5) + 32;
            displayedTemperature = '${fahrenheit.toStringAsFixed(1)} °F';
          } else if (currentUnit == 'Celsius' &&
              temperatureValue.isNotEmpty &&
              double.tryParse(temperatureValue.replaceAll('°F', '').trim()) !=
                  null) {
            final fahrenheit = double.parse(
              temperatureValue.replaceAll('°F', '').trim(),
            );
            final celsius = (fahrenheit - 32) * 5 / 9;
            displayedTemperature = '${celsius.toStringAsFixed(1)} °C';
          }
        } catch (e) {
          print('Error parsing temperature: $e');
        }
      }

      return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.thing['name'] as String ?? 'Temperature Sensor',
          ), // Displays the device name in the app bar.
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Section for displaying client attributes.
              Text(
                AppLocalizations.of(
                  context,
                )!.clientAttributes!, // Localized title for client attributes.
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              // Displays each client attribute in a row.
              for (var entry in _clientAttributes.entries)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(entry.key), // Attribute name.
                      Text(
                        entry.value, // Attribute value.
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              // Section for displaying and potentially editing server attributes.
              Text(
                AppLocalizations.of(
                  context,
                )!.serverAttributes!, // Localized title for server attributes.
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              // Displays the temperature unit setting.
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.temperatureUnit}:', // Localized label for temperature unit.
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(currentUnit), // The current temperature unit.
                  ],
                ),
              ),
              // Displays each server attribute (excluding Temperature Unit) with an editable text field.
              for (var entry in _serverAttributes.entries)
                if (entry.key != 'Temperature Unit') // Skip Temperature Unit
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('${entry.key}:'),
                        ), // Server attribute name.
                        Expanded(
                          child: TextFormField(
                            initialValue:
                                entry.value, // Initial value of the attribute.
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (newValue) {
                              // TODO: Implement saving server attribute
                              print(
                                'Saving ${entry.key} with value: $newValue',
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
              const SizedBox(height: 16),
              // Section for displaying telemetry data.
              Text(
                AppLocalizations.of(
                  context,
                )!.telemetryData!, // Localized title for telemetry data.
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              // Displays the current temperature reading.
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.temperature!,
                    ), // Localized label for temperature.
                    Text(
                      displayedTemperature, // The current temperature value (potentially converted).
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Row for selecting the refresh rate of the telemetry data.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.refreshRate}:', // Localized label for refresh rate.
                    style: const TextStyle(fontSize: 16),
                  ),
                  // Dropdown to select the refresh rate.
                  DropdownButton<String>(
                    value:
                        _refreshRateKey, // The currently selected refresh rate key.
                    items:
                        _refreshRateOptions.entries
                            .map(
                              (entry) => DropdownMenuItem<String>(
                                value: entry.key,
                                child: Text(
                                  entry.value,
                                ), // Localized refresh rate option.
                              ),
                            )
                            .toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _refreshRateKey =
                              newValue; // Updates the selected refresh rate key.
                          // TODO: Implement refresh rate logic using the key
                          print('Refresh rate set to key: $_refreshRateKey');
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Button to navigate to the telemetry history screen, now centered and with adjusted styling.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => TelemetryHistoryScreen(
                                thingName:
                                    widget.thing['name']
                                        as String, // Passes the device name to the history screen.
                              ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: Text(
                      AppLocalizations.of(
                        context,
                      )!.viewTelemetryHistory!, // Localized text for the button.
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
