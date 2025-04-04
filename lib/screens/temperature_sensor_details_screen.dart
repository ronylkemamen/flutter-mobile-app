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
        temperature =
            response.isNotEmpty ? response[0] as Map<String, dynamic> : null;
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
        appBar: AppBar(title: Text(widget.thing.name)),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.thing.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.clientAttributes!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            for (var entry in widget.thing.clientAttributes.entries)
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
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            for (var entry in widget.thing.serverAttributes.entries)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
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
              AppLocalizations.of(context)!.telemetryData!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.temperature!),
                  Text(
                    temperature!['temperature'].toString() +
                        " °C", // Assuming server returns in Celsius for now
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
                  Text(AppLocalizations.of(context)!.humidity!),
                  Text(
                    temperature!['humidity'].toString() +
                        " %", // Assuming server returns humidity as a percentage
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
                DropdownButton<int>(
                  value: _refreshRateKey,
                  items:
                      _refreshRateOptions.entries.map((entry) {
                        int value;
                        switch (entry.key) {
                          case 'manual':
                            value = 0;
                            break;
                          case '5 seconds':
                            value = 5;
                            break;
                          case '10 seconds':
                            value = 10;
                            break;
                          case '30 seconds':
                            value = 30;
                            break;
                          default:
                            value = 5;
                        }
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(entry.value),
                        );
                      }).toList(),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _refreshRateKey = newValue;
                        timer.cancel();
                        fetchTemperatureData();
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center the button
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => TelemetryHistoryScreen(
                              thingName: widget.thing.name,
                            ),
                      ),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.viewTelemetryHistory!,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
