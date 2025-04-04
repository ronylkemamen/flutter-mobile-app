import 'dart:async'; // Provides support for asynchronous programming, including timers.

import 'package:flutter/material.dart';
import 'package:mobile_app/l10n/app_localizations.dart'; // Provides localized strings for the UI.
import 'package:mobile_app/models/sensor.dart'; // Defines the Sensor data model.
import 'package:mobile_app/providers/app_state.dart'; // Provides access to the application's global state.
import 'package:mobile_app/screens/telemetry_history_screen.dart'; // Navigates to the telemetry history screen.
import 'package:mobile_app/services/http_services.dart'; // Provides functions for making HTTP requests.
import 'package:provider/provider.dart'; // For accessing and listening to changes in the application state.

// Displays the details of a temperature sensor device, including real-time data.
class TemperatureSensorDetailsScreen extends StatefulWidget {
  final Sensor thing; // The Sensor object containing the device information.

  const TemperatureSensorDetailsScreen({super.key, required this.thing});

  @override
  State<TemperatureSensorDetailsScreen> createState() =>
      _TemperatureSensorDetailsScreenState();
}

class _TemperatureSensorDetailsScreenState
    extends State<TemperatureSensorDetailsScreen> {
  // Use a language-independent key for refresh rate
  int _refreshRateKey =
      5; // Stores the currently selected refresh rate in seconds, defaults to 5.
  late Timer timer; // Timer object to periodically fetch temperature data.

  // Map keys to their localized display strings for the refresh rate options.
  Map<String, String> get _refreshRateOptions => {
    '5 seconds':
        '5 ${AppLocalizations.of(context)!.seconds!}', // Localized "5 seconds" option.
    '10 seconds':
        '10 ${AppLocalizations.of(context)!.seconds!}', // Localized "10 seconds" option.
    '30 seconds':
        '30 ${AppLocalizations.of(context)!.seconds!}', // Localized "30 seconds" option.
  };

  Map<String, dynamic>? temperature =
      null; // Stores the latest temperature and humidity data fetched from the server.

  // Fetches the latest temperature data from the server at a set interval.
  Future<void> fetchTemperatureData() async {
    timer = Timer.periodic(Duration(seconds: _refreshRateKey), (timer) async {
      final List<dynamic> response =
          await getLastTemperature()
              as List<
                dynamic
              >; // Calls the getLastTemperature function from http_services.dart.
      print("the response returned $response");
      setState(() {
        // Updates the temperature data if the response is not empty.
        temperature =
            response.isNotEmpty ? response[0] as Map<String, dynamic> : null;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTemperatureData(); // Starts fetching temperature data when the widget is initialized.
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading =
        false; // Handwritten condition - likely intended for more complex loading logic.

    // Displays a loading indicator while temperature data is being fetched.
    if (temperature == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.thing.name),
        ), // Displays the device name in the app bar.
        body: Center(
          child: CircularProgressIndicator(),
        ), // Shows a circular progress indicator in the center.
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.thing.name),
      ), // Displays the device name in the app bar.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Section for displaying client attributes.
            Text(
              AppLocalizations.of(
                context,
              )!.clientAttributes!, // Localized title for client attributes.
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            // Displays each client attribute in a row.
            for (var entry in widget.thing.clientAttributes.entries)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(entry.key), // Attribute name.
                    Text(
                      entry.value, // Attribute value.
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            // Section for displaying server attributes.
            Text(
              AppLocalizations.of(
                context,
              )!.serverAttributes!, // Localized title for server attributes.
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            // Displays each server attribute in a row.
            for (var entry in widget.thing.serverAttributes.entries)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(entry.key), // Attribute name.
                    Text(
                      entry.value, // Attribute value.
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            // Section for displaying telemetry data.
            Text(
              AppLocalizations.of(
                context,
              )!.telemetryData!, // Localized title for telemetry data.
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            // Displays the current temperature reading.
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.temperature!,
                  ), // Localized label for temperature.
                  Text(
                    temperature!['temperature'].toString() +
                        " °C", // Displays the temperature value, assuming it's in Celsius.
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            // Displays the current humidity reading.
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.humidity!,
                  ), // Localized label for humidity.
                  Text(
                    temperature!['humidity'].toString() +
                        " %", // Displays the humidity value, assuming it's a percentage.
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Row for selecting the refresh rate of the telemetry data.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.refreshRate}:', // Localized label for refresh rate.
                  style: const TextStyle(fontSize: 16),
                ),
                // Dropdown to select the refresh rate.
                DropdownButton<int>(
                  value:
                      _refreshRateKey, // The currently selected refresh rate in seconds.
                  items:
                      _refreshRateOptions.entries.map((entry) {
                        int value;
                        // Maps the display string of the refresh rate to its corresponding integer value.
                        switch (entry.key) {
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
                            value =
                                5; // Default value if the key doesn't match.
                        }
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(
                            entry.value,
                          ), // Localized refresh rate option.
                        );
                      }).toList(),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _refreshRateKey =
                            newValue; // Updates the selected refresh rate.
                        timer.cancel(); // Cancels the previous timer.
                        fetchTemperatureData(); // Restarts fetching data with the new refresh rate.
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Button to navigate to the telemetry history screen, centered on the row.
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
                              thingName:
                                  widget
                                      .thing
                                      .name, // Passes the device name to the history screen.
                            ),
                      ),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(
                      context,
                    )!.viewTelemetryHistory!, // Localized text for the button.
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
