import 'package:flutter/material.dart';
import 'package:mobile_app/screens/temperature_sensor_details_screen.dart'; // Displays details for temperature sensor devices.
import 'package:mobile_app/screens/house_lights_details_screen.dart'; // Displays details for light devices.
import 'package:mobile_app/l10n/app_localizations.dart'; // Provides localized strings for the UI.

// Displays a list of IoT devices with filtering options.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Holds the list of IoT devices, each with its properties.
  final List<Map<String, dynamic>> _things = [
    {
      'name': 'Temperature Sensor',
      'type': 'Sensor',
      'clientAttributes': {'ID': 'TS-001'},
      'serverAttributes': {'Temperature Unit': 'Celsius'},
      'telemetryData': {'temperature': '22.5 °C'},
    },
    {
      'name': 'House lights',
      'type': 'Light',
      'clientAttributes': {'ID': 'HL-001'},
      'serverAttributes': {'Status': 'Online'},
      'telemetryData': {
        'Bedroom 1': 'on',
        'Bedroom 2': 'off',
        'Dining Room': 'on',
        'Living Room 1': 'off',
        'Living Room 2': 'off',
        'Stairs': 'off',
      },
    },
  ];
  String _filterType = 'All'; // Stores the currently selected filter type.

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        AppLocalizations.of(context)!.things!,
      ), // Localized title for the screen.
      actions: [
        // Provides a dropdown menu to filter the list of devices.
        PopupMenuButton<String>(
          onSelected: (String result) {
            setState(() {
              _filterType =
                  result; // Updates the filter type when an item is selected.
            });
          },
          itemBuilder:
              (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'All',
                  child: Text(
                    AppLocalizations.of(context)!.all!,
                  ), // Localized "All" option.
                ),
                const PopupMenuItem<String>(
                  value: 'Sensor',
                  child: Text(
                    'Sensor',
                  ), // Option to filter by temperature sensors.
                ),
                const PopupMenuItem<String>(
                  value: 'Light',
                  child: Text(
                    'Light',
                  ), // Option to filter by "My Thing" devices.
                ),
              ],
          child: const Icon(Icons.filter_list), // Filter icon button.
        ),
      ],
    ),
    // Displays the list of devices based on the current filter.
    body: ListView.builder(
      itemCount: _things.length,
      itemBuilder: (context, index) {
        final thing = _things[index];
        // Only display the item if it matches the filter or if "All" is selected.
        if (_filterType == 'All' || thing['type'] == _filterType) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: _getIconForThingType(
                thing['type'] as String,
              ), // Gets the appropriate icon for the device type.
              title: Text(
                thing['name'] as String,
              ), // Displays the name of the device.
              subtitle: Text(
                '${AppLocalizations.of(context)!.type}: ${thing['type']}', // Localized label with the device type.
              ),
              onTap: () {
                // Navigates to the detailed screen based on the device type.
                if (thing['type'] == 'Sensor') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              TemperatureSensorDetailsScreen(thing: thing),
                    ),
                  );
                } else if (thing['type'] == 'Light') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => HouseLightsDetailsScreen(thing: thing),
                    ),
                  );
                } else {
                  // Shows a message if details are not available for the device type.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppLocalizations.of(context)!.detailsNotAvailable!,
                      ),
                    ),
                  );
                }
              },
            ),
          );
        } else {
          return const SizedBox.shrink(); // Returns an empty widget if the item doesn't match the filter.
        }
      },
    ),
  );

  // Returns an appropriate icon widget based on the provided device type.
  Widget _getIconForThingType(String type) {
    switch (type) {
      case 'Sensor':
        return const Icon(Icons.thermostat);
      case 'Light':
        return const Icon(Icons.light);
      default:
        return const Icon(
          Icons.device_unknown,
        ); // Default icon for unknown device types.
    }
  }
}
