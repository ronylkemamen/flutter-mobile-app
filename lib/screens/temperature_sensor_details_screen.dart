import 'package:flutter/material.dart';
import 'package:mobile_app/l10n/app_localizations.dart';
import 'package:mobile_app/providers/app_state.dart';
import 'package:mobile_app/screens/telemetry_history_screen.dart';
import 'package:provider/provider.dart';

class TemperatureSensorDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> thing;

  const TemperatureSensorDetailsScreen({super.key, required this.thing});

  @override
  State<TemperatureSensorDetailsScreen> createState() =>
      _TemperatureSensorDetailsScreenState();
}

class _TemperatureSensorDetailsScreenState
    extends State<TemperatureSensorDetailsScreen> {
  // Use a language-independent key for refresh rate
  String _refreshRateKey = '5 seconds'; // Default to 5 seconds

  // Map keys to their localized display strings
  Map<String, String> get _refreshRateOptions => {
    'manual': AppLocalizations.of(context)!.manual!,
    '5 seconds': '5 ${AppLocalizations.of(context)!.seconds!}',
    '10 seconds': '10 ${AppLocalizations.of(context)!.seconds!}',
    '30 seconds': '30 ${AppLocalizations.of(context)!.seconds!}',
  };

  // Dummy data (adapt based on your actual data structure)
  Map<String, String> get _clientAttributes =>
      (widget.thing['clientAttributes'] as Map<String, dynamic>)
          .cast<String, String>() ??
      {};
  Map<String, String> get _serverAttributes =>
      (widget.thing['serverAttributes'] as Map<String, dynamic>)
          .cast<String, String>() ??
      {};
  Map<String, String> get _telemetryData =>
      (widget.thing['telemetryData'] as Map<String, dynamic>)
          .cast<String, String>() ??
      {};

  @override
  Widget build(BuildContext context) => Consumer<AppState>(
    builder: (context, appState, child) {
      final currentUnit = appState.temperatureUnit;
      final temperatureValue = _telemetryData['temperature'] ?? 'N/A';
      String displayedTemperature = temperatureValue;

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
          title: Text(widget.thing['name'] as String ?? 'Temperature Sensor'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.clientAttributes!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              for (var entry in _clientAttributes.entries)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(entry.key),
                      Text(
                        entry.value,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.serverAttributes!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              for (var entry in _serverAttributes.entries)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(child: Text('${entry.key}:')),
                      Expanded(
                        child: TextFormField(
                          initialValue: entry.value,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (newValue) {
                            // TODO: Implement saving server attribute
                            print('Saving ${entry.key} with value: $newValue');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.telemetryData!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.temperature!),
                    Text(
                      displayedTemperature,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.refreshRate}:',
                    style: const TextStyle(fontSize: 16),
                  ),
                  DropdownButton<String>(
                    value: _refreshRateKey, // Use the key as the value
                    items:
                        _refreshRateOptions.entries
                            .map(
                              (entry) => DropdownMenuItem<String>(
                                value: entry.key, // The key is the value
                                child: Text(
                                  entry.value,
                                ), // The value is the displayed text
                              ),
                            )
                            .toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _refreshRateKey = newValue; // Update the key
                          // TODO: Implement refresh rate logic using the key
                          print('Refresh rate set to key: $_refreshRateKey');
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.temperatureUnit}:',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(currentUnit), // Display the selected unit
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => TelemetryHistoryScreen(
                            thingName: widget.thing['name'] as String,
                          ),
                    ),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.viewTelemetryHistory!,
                ),
              ),
              if (true) ...[
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.historicalTelemetryGraph!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: 200,
                  child: Center(
                    child: Text(AppLocalizations.of(context)!.graphWillBeHere!),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    },
  );
}
