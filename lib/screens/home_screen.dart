import 'package:flutter/material.dart';
import 'package:mobile_app/models/sensor.dart';
import 'package:mobile_app/screens/temperature_sensor_details_screen.dart';
import 'package:mobile_app/screens/house_lights_details_screen.dart';
import 'package:mobile_app/l10n/app_localizations.dart';
import 'package:mobile_app/screens/your_thing_details_screen.dart';
import 'package:mobile_app/services/http_services.dart';
import 'package:mobile_app/utils/constants.dart';

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

  //   List<Map<String, dynamic>> sensors = [];
  String _filterType = 'All';

  Future<void> fetchSensors() async {
    final List<dynamic> response = await getSensors() as List<dynamic>;
    setState(() {
      //   _things = response;
      _things =
          response
              .map((json) => Sensor.fromJson(json as Map<String, dynamic>))
              .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchSensors();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(AppLocalizations.of(context)!.things!),
      actions: [
        PopupMenuButton<String>(
          onSelected: (String result) {
            setState(() {
              _filterType = result;
            });
          },
          itemBuilder:
              (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'All',
                  child: Text(AppLocalizations.of(context)!.all!),
                ),
                ...sensorTypes
                    .map(
                      (type) => PopupMenuItem<String>(
                        value: type['type'],
                        child: Text(type['name']!),
                      ),
                    )
                    .toList(),
              ],
          child: const Icon(Icons.filter_list),
        ),
      ],
    ),
    body: ListView.builder(
      itemCount: _things.length,
      itemBuilder: (context, index) {
        final thing = _things[index];
        if (_filterType == 'All' || thing.type == _filterType) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: _getIconForThingType(
                thing.type as String,
              ), // Added leading icon
              title: Text(thing.name as String),
              subtitle: Text(
                '${AppLocalizations.of(context)!.type}: ${thing.type}',
              ),
              onTap: () {
                if (thing.type == sensorTypes[0]['type']) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              TemperatureSensorDetailsScreen(thing: thing),
                    ),
                  );
                } else if (thing.type == sensorTypes[1]['type']) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => YourThingDetailsScreen(thing: thing),
                    ),
                  );
                } else {
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
          return const SizedBox.shrink();
        }
      },
    ),
  );

  // Helper function to get the icon based on the thing type
  Widget _getIconForThingType(String type) {
    switch (type) {
      case "temperature_sensor":
        return const Icon(Icons.thermostat);
      case 'my_thing':
        return const Icon(Icons.home);
      default:
        return const Icon(Icons.device_unknown); // Default icon
    }
  }
}
