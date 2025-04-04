import 'package:flutter/material.dart';
import 'package:mobile_app/l10n/app_localizations.dart'; // Provides localized strings for the UI.
import 'package:provider/provider.dart'; // For accessing and listening to changes in the application state.
import 'package:mobile_app/providers/app_state.dart'; // Provides access to the application's global state.
import 'package:fl_chart/fl_chart.dart'; // Provides widgets for creating charts.

// Displays the historical telemetry data for a specific device.
class TelemetryHistoryScreen extends StatelessWidget {
  final String
  thingName; // The name of the device for which to display the history.

  const TelemetryHistoryScreen({super.key, required this.thingName});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(
      context,
    ); // Accesses the application state.
    final currentUnit =
        appState
            .temperatureUnit; // Retrieves the user's preferred temperature unit.

    // Dummy data representing historical telemetry readings.
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

    // Converts a temperature value to the user's preferred unit.
    double _convertToUnit(String value, String currentUnit) {
      try {
        double numericValue;
        if (value.endsWith(' °C')) {
          numericValue = double.parse(value.replaceAll(' °C', ''));
          if (currentUnit == 'Fahrenheit') {
            return (numericValue * 9 / 5) + 32;
          }
          return numericValue;
        } else if (value.endsWith(' °F')) {
          numericValue = double.parse(value.replaceAll(' °F', ''));
          if (currentUnit == 'Celsius') {
            return (numericValue - 32) * 5 / 9;
          }
          return numericValue;
        } else if (value.contains('°C')) {
          numericValue = double.parse(value.split('°C')[0].trim());
          if (currentUnit == 'Fahrenheit') {
            return (numericValue * 9 / 5) + 32;
          }
          return numericValue;
        } else if (value.contains('°F')) {
          numericValue = double.parse(value.split('°F')[0].trim());
          if (currentUnit == 'Celsius') {
            return (numericValue - 32) * 5 / 9;
          }
          return numericValue;
        } else if (value.isNotEmpty && double.tryParse(value.trim()) != null) {
          numericValue = double.parse(value.trim());
          if (currentUnit == 'Fahrenheit') {
            return (numericValue * 9 / 5) + 32;
          }
          return numericValue;
        }
      } catch (e) {
        print('Error parsing temperature: $e');
      }
      return 0.0; // Returns 0.0 if parsing fails.
    }

    // Converts the history data into a list of FlSpot for the chart.
    final List<FlSpot> chartData =
        _historyData.asMap().entries.map((entry) {
          final index = entry.key;
          final dataPoint = entry.value;
          final value = _convertToUnit(dataPoint['value']!, currentUnit);
          return FlSpot(
            index.toDouble(),
            value,
          ); // Creates a data point for the chart.
        }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.telemetryHistory!,
        ), // Localized title for the screen.
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Displays the name of the device for which the history is shown.
            Text(
              '${AppLocalizations.of(context)!.historyFor!} $thingName', // Localized text with the device name.
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Displays the historical data in a list format.
            SizedBox(
              height: 200,
              child: ListView.builder(
                shrinkWrap: true,
                physics:
                    const ClampingScrollPhysics(), // Prevents scrolling of the inner list from affecting the outer scroll view.
                itemCount: _historyData.length,
                itemBuilder: (context, index) {
                  final dataPoint = _historyData[index];
                  String displayedValue = dataPoint['value']!;

                  // Converts the temperature value to the user's preferred unit for display.
                  if (displayedValue != 'N/A') {
                    try {
                      displayedValue =
                          '${_convertToUnit(displayedValue, currentUnit).toStringAsFixed(1)} ${currentUnit == 'Celsius' ? '°C' : '°F'}';
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
                          Text(
                            dataPoint['timestamp']!,
                          ), // Displays the timestamp of the reading.
                          Text(
                            displayedValue,
                          ), // Displays the temperature value.
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Section for displaying the historical telemetry graph.
            Text(
              AppLocalizations.of(
                context,
              )!.historicalTelemetryGraph!, // Localized title for the graph section.
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            // Displays the historical data as a line chart.
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(
                    show: true,
                  ), // Shows the grid lines on the chart.
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize:
                            60, // Reserves space for the left axis titles.
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval:
                            3, // Shows bottom titles at an interval of 3 data points.
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          // Displays the timestamp for every third data point on the bottom axis.
                          if (index >= 0 &&
                              index < _historyData.length &&
                              index % 3 == 0) {
                            return Text(
                              _historyData[index]['timestamp']!.substring(
                                0,
                                8,
                              ), // Shows only the time part of the timestamp.
                            );
                          }
                          return const Text(
                            '',
                          ); // Returns an empty text for other data points.
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ), // Hides the top axis titles.
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ), // Hides the right axis titles.
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: const Color(0xff37434d),
                      width: 1,
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots:
                          chartData, // Provides the data points for the line chart.
                      isCurved: true, // Makes the line curved.
                      barWidth: 3, // Sets the width of the line.
                      isStrokeCapRound:
                          true, // Makes the ends of the line rounded.
                      color:
                          Theme.of(context)
                              .colorScheme
                              .primary, // Sets the color of the line using the primary color from the theme.
                      dotData: const FlDotData(
                        show: true,
                      ), // Shows dots at each data point.
                      // Removed belowBarData here
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
