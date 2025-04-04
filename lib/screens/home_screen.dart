import 'package:flutter/material.dart';
import 'package:mobile_app/models/sensor.dart'; // Defines the Sensor data model.
import 'package:mobile_app/screens/temperature_sensor_details_screen.dart'; // Displays details for temperature sensor devices.
import 'package:mobile_app/screens/house_lights_details_screen.dart'; // Displays details for house lights devices.
import 'package:mobile_app/l10n/app_localizations.dart'; // Provides localized strings for the UI.
import 'package:mobile_app/screens/your_thing_details_screen.dart'; // Displays details for generic "My Thing" devices.
import 'package:mobile_app/services/http_services.dart'; // Provides functions for making HTTP requests.
import 'package:mobile_app/utils/constants.dart'; // Contains application-wide constants, including sensor types.

// Displays a list of IoT devices fetched from a service with filtering options.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Updated list of things with type and dummy data
  List<Sensor> _things = [
    Sensor(
      "1",
      "Temperature Sensor",
      "temperature_sensor",
      clientAttributes: {'Serial Number': 'TS-001'},
      serverAttributes: {'Location': 'Living Room'},
      telemetryData: {'temperature': '22.5 °C'},
    ),
    Sensor(
      "2",
      "Humidity Sensor",
      "my_thing",
      clientAttributes: {'Serial Number': 'HS-002'},
      serverAttributes: {'Location': 'Kitchen'},
      telemetryData: {'temperature': '22.5 °C'},
    ),
  ];

  String _filterType = 'All'; // Stores the currently selected filter type.

  // Asynchronously fetches sensor data from the backend.
  Future<void> fetchSensors() async {
    final List<dynamic> response =
        await getSensors()
            as List<
              dynamic
            >; // Calls the getSensors function from http_services.dart.
    setState(() {
      _things =
          response
              .map(
                (json) => Sensor.fromJson(json as Map<String, dynamic>),
              ) // Converts each JSON object in the response to a Sensor object.
              .toList(); // Creates a list of Sensor objects.
    });
  }

  @override
  void initState() {
    super.initState();
    fetchSensors(); // Calls fetchSensors when the widget is first created.
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        AppLocalizations.of(context)!.things!,
      ), // Sets the title of the app bar using localized text.
      actions: [
        PopupMenuButton<String>(
          onSelected: (String result) {
            setState(() {
              _filterType =
                  result; // Updates the _filterType based on the selected menu item.
            });
          },
          itemBuilder:
              (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'All',
                  child: Text(
                    AppLocalizations.of(context)!.all!,
                  ), // Displays the "All" option in the filter menu.
                ),
                ...sensorTypes
                    .map(
                      (type) => PopupMenuItem<String>(
                        value:
                            type['type'], // Sets the value of the menu item to the sensor type.
                        child: Text(
                          type['name']!,
                        ), // Displays the sensor name in the filter menu.
                      ),
                    )
                    .toList(), // Converts the mapped PopupMenuItems to a list.
              ],
          child: const Icon(
            Icons.filter_list,
          ), // Displays the filter list icon in the app bar.
        ),
      ],
    ),
    body: ListView.builder(
      itemCount:
          _things
              .length, // Sets the number of items in the list based on the number of sensors.
      itemBuilder: (context, index) {
        final thing =
            _things[index]; // Gets the Sensor object at the current index.
        if (_filterType == 'All' || thing.type == _filterType) {
          return Card(
            margin: const EdgeInsets.all(8.0), // Adds margin around each card.
            child: ListTile(
              leading: _getIconForThingType(
                thing.type as String,
              ), // Added leading icon based on the sensor type.
              title: Text(
                thing.name as String,
              ), // Displays the name of the sensor.
              subtitle: Text(
                '${AppLocalizations.of(context)!.type}: ${thing.type}', // Displays the localized "Type" label and the sensor type.
              ),
              onTap: () {
                // Navigates to the details screen based on the sensor type.
                if (thing.type == sensorTypes[0]['type']) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => TemperatureSensorDetailsScreen(
                            thing: thing,
                          ), // Navigates to TemperatureSensorDetailsScreen.
                    ),
                  );
                } else if (thing.type == sensorTypes[1]['type']) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => YourThingDetailsScreen(
                            thing: thing,
                          ), // Navigates to YourThingDetailsScreen.
                    ),
                  );
                } else {
                  // Displays a snackbar if details are not available for the sensor type.
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
          return const SizedBox.shrink(); // Returns an empty SizedBox if the sensor type does not match the filter.
        }
      },
    ),
  );

  // Helper function to get the icon based on the thing type
  Widget _getIconForThingType(String type) {
    switch (type) {
      case "temperature_sensor":
        return const Icon(
          Icons.thermostat,
        ); // Returns the thermostat icon for temperature sensors.
      case 'my_thing':
        return const Icon(
          Icons.home,
        ); // Returns the home icon for generic "My Thing" devices.
      default:
        return const Icon(
          Icons.device_unknown,
        ); // Default icon for unknown sensor types.
    }
  }
}
