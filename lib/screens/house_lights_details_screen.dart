import 'package:flutter/material.dart';
import 'package:mobile_app/l10n/app_localizations.dart'; // Provides localized strings for the UI.

// Displays the details and controls for a house lights device.
class HouseLightsDetailsScreen extends StatefulWidget {
  const HouseLightsDetailsScreen({super.key});

  @override
  State<HouseLightsDetailsScreen> createState() =>
      _HouseLightsDetailsScreenState();
}

class _HouseLightsDetailsScreenState extends State<HouseLightsDetailsScreen> {
  // Hardcoded client attributes for the house lights.
  final Map<String, String> _clientAttributes = {'Serial Number': 'HL-001'};
  // Hardcoded server attributes for the house lights.
  final Map<String, String> _serverAttributes = {
    'IP Address': '192.168.1.100',
    'Status': 'Online',
  };
  // Hardcoded telemetry data for the lights.
  late Map<String, String> _telemetryData;
  // Stores the modified server attributes.
  final Map<String, String> _updatedServerAttributes = {};

  @override
  void initState() {
    super.initState();
    // Initializes the telemetry data.
    _telemetryData = {
      'bedroom1': 'off',
      'bedroom2': 'on',
      'diningRoom': 'off',
      'livingRoom1': 'on',
      'livingRoom2': 'off',
      'stairs': 'on',
    };
    // Initialize the map with existing server attributes.
    _updatedServerAttributes.addAll(_serverAttributes);
  }

  String _getLocalizedRoomName(String roomName) {
    switch (roomName) {
      case 'bedroom1':
        return AppLocalizations.of(context)!.bedroom1!;
      case 'bedroom2':
        return AppLocalizations.of(context)!.bedroom2!;
      case 'diningRoom':
        return AppLocalizations.of(context)!.diningRoom!;
      case 'livingRoom1':
        return AppLocalizations.of(context)!.livingRoom1!;
      case 'livingRoom2':
        return AppLocalizations.of(context)!.livingRoom2!;
      case 'stairs':
        return AppLocalizations.of(context)!.stairs!;
      default:
        return roomName.toUpperCase(); // Fallback
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        "Domotic House",
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
                  Text(
                    entry.key == 'Serial Number'
                        ? AppLocalizations.of(context)!.serialNumber!
                        : entry.key, // Attribute name.
                  ),
                  Text(
                    entry.value, // Attribute value.
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),

          // Section for displaying server attributes as editable textboxes.
          Text(
            AppLocalizations.of(
              context,
            )!.serverAttributes!, // Localized title for server attributes.
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          for (var entry in _serverAttributes.entries)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      entry.key == 'Status'
                          ? AppLocalizations.of(context)!.status!
                          : entry.key == 'IP Address'
                          ? AppLocalizations.of(context)!.ipAddress!
                          : entry.key,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      initialValue: entry.value,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          _updatedServerAttributes[entry.key] = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          // Button to update server attributes.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Print the updated attributes for now.
                  _updatedServerAttributes.forEach((key, value) {
                    print('Updated $key: $value');
                  });
                  // TODO: Implement API call to update server attributes
                },
                child: Text(
                  AppLocalizations.of(context)!.updateServerAttributes!,
                ),
              ),
            ],
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
                  _getLocalizedRoomName(entry.key),
                ), // Displays the localized light name.
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
