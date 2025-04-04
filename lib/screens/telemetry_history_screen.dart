import 'package:flutter/material.dart';
import 'package:mobile_app/l10n/app_localizations.dart'; // Provides localized strings for the UI.
import 'package:provider/provider.dart'; // For accessing application-wide state.
import 'package:mobile_app/providers/app_state.dart'; // Provides and manages the application's global state.

// Displays the historical telemetry data for a specific IoT device.
class TelemetryHistoryScreen extends StatelessWidget {
  final String
  thingName; // The name of the IoT device for which to display history.

  const TelemetryHistoryScreen({super.key, required this.thingName});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(
      context,
    ); // Accesses the application state.
    final currentUnit =
        appState
            .temperatureUnit; // Retrieves the user's preferred temperature unit.

    // Dummy historical data representing telemetry readings over time.
    final List<Map<String, String>> _historyData = [
      {'timestamp': '10:00:00', 'value': '23.0 °C'},
      {'timestamp': '10:00:05', 'value': '23.2 °C'},
      {'timestamp': '10:00:10', 'value': '23.5 °C'},
      {'timestamp': '10:00:15', 'value': '23.3 °C'},
      {'timestamp': '10:00:20', 'value': '23.1 °C'},
      {'timestamp': '10:00:25', 'value': '23.4 °C'},
      {'timestamp': '10:00:30', 'value': '23.6 °C'},
      {'timestamp': '10:00:35', 'value': '23.2 °C'},
      {'timestamp': '10:00:40', 'value': '23.0 °C'},
      {'timestamp': '10:00:45', 'value': '23.3 °C'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.telemetryHistory!,
        ), // Localized title for the telemetry history screen.
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Displays the name of the device for which the history is shown.
            Text(
              '${AppLocalizations.of(context)!.historyFor!} $thingName',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Displays the historical telemetry data in a list format.
            SizedBox(
              height: 200,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: _historyData.length,
                itemBuilder: (context, index) {
                  final dataPoint = _historyData[index];
                  String displayedValue = dataPoint['value']!;
                  final temperatureValue = dataPoint['value']!;

                  // Converts the temperature value to the user's preferred unit if necessary.
                  if (temperatureValue != 'N/A') {
                    try {
                      if (currentUnit == 'Fahrenheit' &&
                          temperatureValue.endsWith(' °C')) {
                        final celsius = double.parse(
                          temperatureValue.replaceAll(' °C', ''),
                        );
                        final fahrenheit = (celsius * 9 / 5) + 32;
                        displayedValue = '${fahrenheit.toStringAsFixed(1)} °F';
                      } else if (currentUnit == 'Celsius' &&
                          temperatureValue.endsWith(' °F')) {
                        final fahrenheit = double.parse(
                          temperatureValue.replaceAll(' °F', ''),
                        );
                        final celsius = (fahrenheit - 32) * 5 / 9;
                        displayedValue = '${celsius.toStringAsFixed(1)} °C';
                      } else if (currentUnit == 'Fahrenheit' &&
                          temperatureValue.contains('°C')) {
                        final celsius = double.parse(
                          temperatureValue.split('°C')[0].trim(),
                        );
                        final fahrenheit = (celsius * 9 / 5) + 32;
                        displayedValue = '${fahrenheit.toStringAsFixed(1)} °F';
                      } else if (currentUnit == 'Celsius' &&
                          temperatureValue.contains('°F')) {
                        final fahrenheit = double.parse(
                          temperatureValue.split('°F')[0].trim(),
                        );
                        final celsius = (fahrenheit - 32) * 5 / 9;
                        displayedValue = '${celsius.toStringAsFixed(1)} °C';
                      } else if (currentUnit == 'Fahrenheit' &&
                          temperatureValue.isNotEmpty &&
                          double.tryParse(
                                temperatureValue.replaceAll('°C', '').trim(),
                              ) !=
                              null) {
                        final celsius = double.parse(
                          temperatureValue.replaceAll('°C', '').trim(),
                        );
                        final fahrenheit = (celsius * 9 / 5) + 32;
                        displayedValue = '${fahrenheit.toStringAsFixed(1)} °F';
                      } else if (currentUnit == 'Celsius' &&
                          temperatureValue.isNotEmpty &&
                          double.tryParse(
                                temperatureValue.replaceAll('°F', '').trim(),
                              ) !=
                              null) {
                        final fahrenheit = double.parse(
                          temperatureValue.replaceAll('°F', '').trim(),
                        );
                        final celsius = (fahrenheit - 32) * 5 / 9;
                        displayedValue = '${celsius.toStringAsFixed(1)} °C';
                      }
                    } catch (e) {
                      print('Error parsing temperature history: $e');
                    }
                  }

                  // Displays each historical data point in a card.
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dataPoint['timestamp']!,
                          ), // Displays the timestamp of the reading.
                          Text(
                            displayedValue,
                          ), // Displays the telemetry value (potentially converted).
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Section for displaying a historical telemetry graph (currently a placeholder).
            if (true) ...[
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(
                  context,
                )!.historicalTelemetryGraph!, // Localized title for the graph section.
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              SizedBox(
                height: 200,
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.graphWillBeHere!,
                  ), // Localized placeholder text for the graph.
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
