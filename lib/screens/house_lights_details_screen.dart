import 'package:flutter/material.dart';
import 'package:mobile_app/l10n/app_localizations.dart'; // Provides localized strings for the UI.

// Displays the details and controls for a house lights device.
class HouseLightsDetailsScreen extends StatefulWidget {
  final Map<String, dynamic>
  thing; // The data representing the house lights device.

  const HouseLightsDetailsScreen({super.key, required this.thing});

  @override
  State<HouseLightsDetailsScreen> createState() =>
      _HouseLightsDetailsScreenState();
}

class _HouseLightsDetailsScreenState extends State<HouseLightsDetailsScreen> {
  // Extracts client attributes from the device data.
  Map<String, String> get _clientAttributes =>
      (widget.thing['clientAttributes'] as Map<String, dynamic>)
          .cast<String, String>() ??
      {};
  // Extracts server attributes from the device data.
  Map<String, String> get _serverAttributes =>
      (widget.thing['serverAttributes'] as Map<String, dynamic>)
          .cast<String, String>() ??
      {};
  // Stores the telemetry data for the lights, which will be updated based on user interaction.
  late Map<String, String> _telemetryData;

  @override
  void initState() {
    super.initState();
    // Initializes the telemetry data from the widget's data.
    _telemetryData =
        (widget.thing['telemetryData'] as Map<String, dynamic>)
            .cast<String, String>() ??
        {};
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        widget.thing['name'] as String ?? 'House Lights',
      ), // Displays the device name in the app bar.
    ),
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
          for (var entry in _clientAttributes.entries)
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
          for (var entry in _serverAttributes.entries)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.key == 'Status'
                        ? AppLocalizations.of(context)!.status!
                        : entry.key,
                  ),
                  Text(
                    entry.key == 'Status' && entry.value == 'Online'
                        ? AppLocalizations.of(context)!.online!
                        : entry.key == 'Status' && entry.value == 'Offline'
                        ? AppLocalizations.of(context)!.offline!
                        : entry.value,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),

          // Section for displaying and controlling room lights.
          Text(
            AppLocalizations.of(
              context,
            )!.telemetryData!, // Localized title for telemetry data.
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          // Iterates through the telemetry data to display and control each light.
          for (var entry in _telemetryData.entries)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: ListTile(
                title: Text(
                  '${entry.key.toUpperCase()}',
                ), // Displays the light name in uppercase.
                trailing: Switch(
                  value:
                      entry.value ==
                      'on', // Determines if the switch should be on based on the value.
                  onChanged: (bool newValue) {
                    setState(() {
                      // Updates the telemetry data when the switch is toggled.
                      _telemetryData[entry.key] = newValue ? 'on' : 'off';
                      // TODO: Sends the action to the server
                      print(
                        'Light in ${entry.key} is now ${newValue ? 'on' : 'off'}',
                      );
                    });
                  },
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
