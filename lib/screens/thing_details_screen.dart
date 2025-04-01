import 'package:flutter/material.dart';
import 'package:mobile_app/screens/telemetry_history_screen.dart';

class ThingDetailsScreen extends StatefulWidget {
  final String thingName;

  const ThingDetailsScreen({super.key, required this.thingName});

  @override
  State<ThingDetailsScreen> createState() => _ThingDetailsScreenState();
}

class _ThingDetailsScreenState extends State<ThingDetailsScreen> {
  String _refreshRate = '5 seconds';

  // Dummy data for client and server attributes, and telemetry
  final Map<String, String> _clientAttributes = {
    'Serial Number': 'SN-12345',
    'Model': 'XYZ',
  };
  final Map<String, String> _serverAttributes = {
    'Location': 'Room A',
    'Threshold': '25',
  };
  final Map<String, String> _telemetryData = {
    'Temperature': '23.5 °C',
    'Humidity': '60%',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.thingName)),
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            TelemetryHistoryScreen(thingName: widget.thingName),
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
