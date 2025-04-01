import 'package:flutter/material.dart';

class TelemetryHistoryScreen extends StatelessWidget {
  final String thingName;

  const TelemetryHistoryScreen({super.key, required this.thingName});

  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(title: const Text('Telemetry History')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'History for: $thingName',
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
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(dataPoint['timestamp']!),
                          Text(dataPoint['value']!),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (true) ...[
              const SizedBox(height: 16),
              const Text(
                'Historical Telemetry Graph (Placeholder)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              const SizedBox(
                height: 200,
                child: Center(child: Text('Historical Graph will be here')),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
