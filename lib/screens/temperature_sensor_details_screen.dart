import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_app/l10n/app_localizations.dart';
import 'package:mobile_app/models/sensor.dart';
import 'package:mobile_app/providers/app_state.dart';
import 'package:mobile_app/screens/telemetry_history_screen.dart';
import 'package:mobile_app/services/http_services.dart';
import 'package:provider/provider.dart';

class TemperatureSensorDetailsScreen extends StatefulWidget {
  final Sensor thing;

  const TemperatureSensorDetailsScreen({super.key, required this.thing});

  @override
  State<TemperatureSensorDetailsScreen> createState() =>
      _TemperatureSensorDetailsScreenState();
}

class _TemperatureSensorDetailsScreenState
    extends State<TemperatureSensorDetailsScreen> {
  // Use a language-independent key for refresh rate
  int _refreshRateKey = 5; // Default to 5 seconds
  late Timer timer;

  // Map keys to their localized display strings
  Map<String, String> get _refreshRateOptions => {
    'manual': AppLocalizations.of(context)!.manual!,
    '5 seconds': '5 ${AppLocalizations.of(context)!.seconds!}',
    '10 seconds': '10 ${AppLocalizations.of(context)!.seconds!}',
    '30 seconds': '30 ${AppLocalizations.of(context)!.seconds!}',
  };

  late Map<String, dynamic>? temperature = null;

  Future<void> fetchTemperatureData() async {
    timer = Timer.periodic(Duration(seconds: _refreshRateKey), (timer) async {
      final List<dynamic> response =
          await getLastTemperature() as List<dynamic>;
      print("the response returned $response");
      setState(() {
        //   _things = response;
        temperature = response[0] as Map<String, dynamic>;
      });
    });
  }


  @override
  void initState() {
    super.initState();
    fetchTemperatureData();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false; // Handwritten condition

    if (temperature == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Temperature Sensor')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Temperature Sensor')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Client Attributes',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Attribute Key'),
                  Text(
                    'Attribute Value',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Server Attributes',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(child: Text('Server Attribute:')),
                  Expanded(
                    child: TextFormField(
                      initialValue: 'Value',
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Telemetry Data',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Temperature'),
                  Text(
                    temperature!['temperature'].toString() + " C",
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Humidity'),
                  Text(
                    temperature!['humidity'].toString() + " C",
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Refresh Rate:', style: const TextStyle(fontSize: 16)),
                DropdownButton<String>(
                  value: '30s',
                  items: [
                    DropdownMenuItem<String>(
                      value: '30s',
                      child: Text('30 seconds'),
                    ),
                  ],
                  onChanged: (String? newValue) {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Temperature Unit:', style: const TextStyle(fontSize: 16)),
                Text('Celsius'),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: Text('View Telemetry History'),
            ),
            const SizedBox(height: 16),
            Text(
              'Historical Telemetry Graph',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            SizedBox(
              height: 200,
              child: Center(child: Text('Graph will be here!')),
            ),
          ],
        ),
      ),
    );
  }
}
