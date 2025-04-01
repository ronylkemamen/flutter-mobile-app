import 'package:flutter/material.dart';
import 'package:mobile_app/screens/telemetry_history_screen.dart';

class TemperatureSensorDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> thing;

  const TemperatureSensorDetailsScreen({super.key, required this.thing});

  @override
  State<TemperatureSensorDetailsScreen> createState() =>
      _TemperatureSensorDetailsScreenState();
}

class _TemperatureSensorDetailsScreenState
    extends State<TemperatureSensorDetailsScreen> {
  String _refreshRate = '5 seconds';
  String _temperatureUnit = 'Celsius'; // Specific to temperature sensor

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.thing['name'] as String ?? 'Temperature Sensor'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Client Attributes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            const Text(
              'Server Attributes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            const Text(
              'Telemetry Data',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            for (var entry in _telemetryData.entries)
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Refresh Rate:', style: TextStyle(fontSize: 16)),
                DropdownButton<String>(
                  value: _refreshRate,
                  items:
                      <String>[
                            'Manual',
                            '5 seconds',
                            '10 seconds',
                            '30 seconds',
                          ]
                          .map(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _refreshRate = newValue!;
                      // TODO: Implement refresh rate logic
                      print('Refresh rate set to: $_refreshRate');
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Temperature Unit:', style: TextStyle(fontSize: 16)),
                DropdownButton<String>(
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
              child: const Text('View Telemetry History'),
            ),
            if (true) ...[
              const SizedBox(height: 16),
              const Text(
                'Telemetry Graph (Placeholder)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              const SizedBox(
                height: 200,
                child: Center(child: Text('Graph will be here')),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
