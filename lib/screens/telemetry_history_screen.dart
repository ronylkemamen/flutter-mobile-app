import 'package:flutter/material.dart';
import 'package:mobile_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/providers/app_state.dart';

class TelemetryHistoryScreen extends StatelessWidget {
  final String thingName;

  const TelemetryHistoryScreen({super.key, required this.thingName});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final currentUnit = appState.temperatureUnit;

    // Dummy historical data
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
        title: Text(AppLocalizations.of(context)!.telemetryHistory!),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${AppLocalizations.of(context)!.historyFor!} $thingName',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
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

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(dataPoint['timestamp']!),
                          Text(displayedValue), // Use the converted value
                        ],
                      ),
                    ),
                  );
                },
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
  }
}
