import 'package:flutter/material.dart';
import 'package:mobile_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/providers/app_state.dart';
import 'package:fl_chart/fl_chart.dart';

class TelemetryHistoryScreen extends StatelessWidget {
  final String thingName;

  const TelemetryHistoryScreen({super.key, required this.thingName});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final currentUnit = appState.temperatureUnit;

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
      return 0.0;
    }

    final List<FlSpot> chartData =
        _historyData.asMap().entries.map((entry) {
          final index = entry.key;
          final dataPoint = entry.value;
          final value = _convertToUnit(dataPoint['value']!, currentUnit);
          return FlSpot(index.toDouble(), value);
        }).toList();

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
                          Text(dataPoint['timestamp']!),
                          Text(displayedValue),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.historicalTelemetryGraph!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 60,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 3,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= 0 &&
                              index < _historyData.length &&
                              index % 3 == 0) {
                            return Text(
                              _historyData[index]['timestamp']!.substring(0, 8),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
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
                      spots: chartData,
                      isCurved: true,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      color: Theme.of(context).colorScheme.primary,
                      dotData: const FlDotData(show: true),
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
